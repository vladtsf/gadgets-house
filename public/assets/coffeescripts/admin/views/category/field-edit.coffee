class Witness.views.CategoryFieldEdit extends Witness.View

  initialize: ( options ) ->
    Backbone.Validation.bind( @ )

  destroy: ->
    @remove()

  multiline: ( event ) ->
    $ct = $( event.currentTarget )

    $ct
      .toggleClass( "btn-warning" )
      .data( "multiline", not $ct.data( "multiline" ) )

    @validate()

  deleteField: ( event ) ->
    @model.destroy()
    @remove()

  validate: ->
    @model.set
      "machineName": @$el.find( "[name=\"machine-name\"]" ).val()
      "name": @$el.find( "[name=\"name\"]" ).val()
      "multiline": @$el.find( ".b-category-field__multiline" ).data( "multiline" ) is on
    , silent: on

    @model.validate()

    @$el.find( ".b-category-field__valid i" )
      .toggleClass( "icon-ok", @model.isValid() )
      .toggleClass( "icon-remove", not @model.isValid() )

  className: "input-prepend input-append b-category-field"

  events:
    "click .b-category-field__multiline": "multiline"
    "click .b-category-field__delete": "deleteField"
    "keyup": "validate"

  template: "category-field-edit"