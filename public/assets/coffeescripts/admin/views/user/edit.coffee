class Witness.views.UsersProfile extends Witness.EntityView

  initialize: ( options, _id ) ->
    @model = new Witness.models.UserProfile( { _id } )
    Backbone.Validation.bind( @ )

  root: "users"

  destroy: ->
    @remove()

  data: ->
    data = {}

    for own field in @$el.find( "form" ).serializeArray()
      data[ field.name ] = field.value

    data

  validate: ( e ) ->
    @model.set( @data(), silent: on )

    @$el.find( "form .control-group" )
      .removeClass( "error" )
      .find( ".help-inline" )
      .remove()

    for own field, msg of @model.validate()
      $errField = @$el.find( "form .control-group:has([name=\"#{ field }\"])" )

      $errField
        .addClass( "error" )
        .append( """<span class="help-inline">#{ msg }</span>""" )

  events:
    "submit form": "save"
    "click .b-profile__delete": "del"
    "focusout": "validate"

  template: "users-profile"