class Witness.views.CategoryEdit extends Witness.View

  initialize: ( options, _id ) ->
    @fields = new Witness.models.CategoryFields()

    @fields.on "add", ( model, collection ) =>
      view = new Witness.views.CategoryFieldEdit( model: model )
      @$el.find( ".b-category-fields" ).append( view.render().el )

    # @model = new Witness.models.UserProfile( { _id } )
    # Backbone.Validation.bind( @ )

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )
    @fields.add( new Witness.models.CategoryField() )
    @


  # data: ->
  #   data = {}

  #   for own field in @$el.find( "form" ).serializeArray()
  #     data[ field.name ] = field.value

  #   data

  # buttonMsg: ( $button, msg, success, cb ) ->
  #   oldText = $button.text()
  #   $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).text( msg )

  #   setTimeout ->
  #     $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).text( oldText )

  #     cb() if typeof cb is "function"
  #   , 2e3

  #   @

  # save: ( e ) ->
  #   @validate()

  #   if @model.isValid()
  #     $buttons = @$el.find( "button" )

  #     $buttons.attr( "disabled", on )
  #     $save = $buttons.filter( ".b-profile__save" )

  #     processing = @model.save()

  #     processing.fail =>
  #       @buttonMsg $save, "Ошибка", false, ->
  #         $buttons.attr( "disabled", off )

  #     processing.then =>
  #       @buttonMsg $save, "Сохранено", true, ->
  #         $buttons.attr( "disabled", off )

  #   off

  # removeAccount: ->
  #   $buttons = @$el.find( "button" )
  #   $buttons.attr( "disabled", on )
  #   $delete = $buttons.filter( ".b-profile__delete" )

  #   processing = @model.destroy( wait: on )

  #   processing.fail =>
  #     @buttonMsg $delete, "Ошибка", false, ->
  #       $buttons.attr( "disabled", off )

  #   processing.then =>
  #     location.hash = "users"

  # validate: ( e ) ->
  #   @model.set( @data(), silent: on )

  #   @$el.find( "form .control-group" )
  #     .removeClass( "error" )
  #     .find( ".help-inline" )
  #     .remove()

  #   for own field, msg of @model.validate()
  #     $errField = @$el.find( "form .control-group:has([name=\"#{ field }\"])" )

  #     $errField
  #       .addClass( "error" )
  #       .append( """<span class="help-inline">#{ msg }</span>""" )

  events: {}
    # "submit form": "save"
    # "click .b-profile__delete": "removeAccount"
    # "focusout": "validate"

  template: "category-edit"