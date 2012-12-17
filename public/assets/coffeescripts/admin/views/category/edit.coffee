class Witness.views.CategoryEdit extends Witness.EntityView

  initialize: ( options, _id ) ->
    @fields = new Witness.models.CategoryFields()
    @model = @model ? new Witness.models.Category( { _id } )

    @fields.on "add", ( model, collection ) =>
      view = new Witness.views.CategoryFieldEdit( model: model )
      @$el.find( ".b-category-fields" ).append( view.render().el )

    Backbone.Validation.bind( @ )

  root: "categories"

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

    @fields.add @model.get( "fields" ) if @model.get( "fields" )?.length

    @


  data: ->
    "name": @$el.find( "[name=\"category-name\"]" ).val()
    "machineName": @$el.find( "[name=\"category-machineName\"]" ).val()

  save: ( e ) ->
    @validate()

    fields = []

    for own model in @fields.models
      model.validate()
      return off unless model.isValid()
      fields.push( model.toJSON() )

    Witness.View::save.call( @, e )

    off

  addField: ->
    @fields.add( new Witness.models.CategoryField() )

  validate: ( e ) ->
    @model.set( @data(), silent: on )

    @$el.find( ".control-group" )
      .removeClass( "error" )
      .find( ".help-inline" )
      .remove()

    for own field, msg of @model.validate()
      $errField = @$el.find( "form .control-group:has([name=\"category-#{ field }\"])" )

      $errField
        .addClass( "error" )
        .append( """<span class="help-inline">#{ msg }</span>""" )

  events:
    "submit form": "save"
    "click .b-category__delete": "del"
    "click .b-category__add-field": "addField"
    "focusout": "validate"

  template: "category-edit"