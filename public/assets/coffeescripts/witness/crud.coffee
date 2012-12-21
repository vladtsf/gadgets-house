class Witness.CRUDView extends Witness.View

  constructor: ->
    super

    @options.model ?= Backbone.Model
    _entity = @options.entity
    _validation = @options.validation

    class Model extends @options.model
      idAttribute: "_id"

      initialize: ->
        @validation = if typeof _validation is "function" then _validation.call @ else _validation

      url: -> "/admin/#{ _entity }/#{ @id ? "" }"

    class Collection extends Backbone.Collection
      constructor: ->
        super

      model: Model

      parse: ( res ) ->
        @offset = res.offset
        @count = res.count
        @limit = res.limit
        res.docs

      url: -> "/admin/#{ _entity }"

    @Model = Model
    @Collection = Collection

  getTemplate: ->
    jade.templates[ ( @templates ? @options?.templates )?[ @options.action ? "list" ] ]

  parseFields: ( fields ) ->
    results = {}

    for own key, field of fields
      splitted = field.split /\s*:\s*/
      results[ key ] =
        name: splitted[ 0 ]
        type: splitted[ 1 ]
        placeholder: splitted[ 2 ]
        ref: splitted[ 3 ]

    results

  render: ( params ) ->
    fields = @parseFields @options.fields

    defs = for own key, field of fields when field.ref
      class collection extends Backbone.Collection
        initialize: ->
        url: field.ref
        parse: ( res ) -> res.docs
        model: Backbone.Model.extend( idAttribute: "_id" )

      field.options = new collection
      field.options.fetch()

    $.when.apply( $, defs ).then =>
      @$el.html @getTemplate()?( _.extend( {}, params, @options, fields: fields ) )

    @

  serialize: ->
    result = {}

    for own field in @$( ".b-entity-form" ).serializeArray()
      result[ field.name ] = field.value

    for own typeahead in @$ ".b-typeahead"
      $tah = $( typeahead )
      result[ $tah.attr "name" ] = $tah.data( "cache" ).byName[ $tah.val() ]

    result

  destroy: Witness.View::remove

  validate: ->
    @model.set( @serialize(), silent: on )

    @$( ".control-group" )
      .removeClass( "error" )
      .find( ".help-inline" )
      .remove()

    for own field, msg of @model.validate()
      $errField = @$( ".b-entity-form .control-group:has([name=\"#{ field }\"])" )

      $errField
        .addClass( "error" )
        .append( """<span class="help-inline">#{ msg }</span>""" )

  list: ( @page ) ->
    @model = new @Collection()
    @model.fetch( add: on, data: offset: @page * 10 ).then =>
      @render
        offset: @model.offset
        count: @model.count
        limit: @model.limit
        docs: @model?.toJSON()

  edit: ( @_id ) ->
    @model = new @Model( _id: @_id )

    Backbone.Validation.bind( @ )

    if @_id?
      fetch = @model.fetch()

      fetch.then =>
        @render
          doc: @model?.toJSON()

      fetch.fail =>
        @render
          doc: null
    else
      @render
        doc: @model?.toJSON()

      fetch = new $.Deferred().resolve()

    fetch

  buttonMsg: ( $button, msg, success, cb ) ->
    oldText = $button.html()

    $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).html """
      <i class="#{ if $button.hasClass "b-entity__save" then "icon-hdd" else "icon-trash" }"></i>
      &nbsp;
      #{ _.escape msg }
    """

    setTimeout ->
      $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).html( oldText )

      cb() if typeof cb is "function"
    , 2e3

    @

  save: ( e ) ->
    @validate()

    if @model.isValid()
      $buttons = @$ ".btn"

      $buttons.attr "disabled", on
      $save = $buttons.filter( ".b-entity__save" )

      processing = @model.save()

      processing.fail =>
        @buttonMsg $save, "Ошибка", false, ->
          $buttons.attr( "disabled", off )

      processing.then =>
        location.hash = "#{ @options.entity }/#{ @model.id }"
        @buttonMsg $save, "Сохранено", true, ->
          $buttons.attr( "disabled", off )

    off

  del: ->
    $buttons = @$ ".btn"
    $buttons.attr "disabled", on
    $delete = $buttons.filter( ".b-entity__delete" )

    processing = @model.destroy( wait: on )

    processing.fail =>
      @buttonMsg $delete, "Ошибка", false, ->
        $buttons.attr( "disabled", off )

    processing.then =>
      location.hash = @options.entity

  templates:
    list: "crud-list"
    edit: "crud-edit"

  events:
    "submit .b-entity-form": "save"
    "click .b-entity__delete": "del"
    "focusout *:not(.b-typeahead)": "validate"
    "change *:not(.b-typeahead)": "validate"
    "input *:not(.b-typeahead)": "validate"