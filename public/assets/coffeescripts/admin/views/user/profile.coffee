class Witness.views.UsersProfile extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.UserProfile( id: _id )
    Backbone.Validation.bind( @ )

  destroy: ->
    @remove()

  data: ->
    data = {}

    for own field in @$el.find( "form" ).serializeArray()
      data[ field.name ] = field.value

    data

  buttonMsg: ( $button, msg, cb ) ->
    oldText = $button.text()
    $button.toggleClass( "btn-danger btn-primary" ).text( msg )

    setTimeout ->
      $button.toggleClass( "btn-danger btn-primary" ).text( oldText )

      cb() if typeof cb is "function"
    , 2e3

    @

  save: ( e ) ->
    @validate()

    if @model.isValid()
      $buttons = @$el.find( "button" )

      $buttons.attr( "disabled", on )
      $save = $buttons.filter( ".b-profile__save" )

      processing = @model.save()

      processing.fail =>
        @buttonMsg $save, "Ошибка", ->
          $buttons.attr( "disabled", off )

      processing.then =>
        @buttonMsg $save, "Сохранено", ->
          $buttons.attr( "disabled", off )

    off

  removeAccount: ->
    $buttons = @$el.find( "button" )
    $buttons.attr( "disabled", on )
    $delete = $buttons.filter( ".b-profile__delete" )

    processing = @model.destroy( wait: on )

    processing.fail =>
      @buttonMsg $delete, "Ошибка", ->
        $buttons.attr( "disabled", off )

    processing.then =>
      location.hash = "users"

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
    "click .b-profile__delete": "removeAccount"
    "focusout": "validate"

  template: "users-profile"