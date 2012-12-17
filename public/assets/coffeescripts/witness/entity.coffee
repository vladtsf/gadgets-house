class Witness.EntityView extends Witness.View

  constructor: ->
    super

  buttonMsg: ( $button, msg, success, cb ) ->
    oldText = $button.text()
    $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).text( msg )

    setTimeout ->
      $button.toggleClass( "btn-#{ if success then "success" else "danger" } btn-primary" ).text( oldText )

      cb() if typeof cb is "function"
    , 2e3

    @

  save: ( e ) ->
    @validate()

    if @model.isValid()
      $buttons = @$el.find( "button" )

      $buttons.attr( "disabled", on )
      $save = $buttons.filter( ".b-product__save" )

      processing = @model.save()

      processing.fail =>
        @buttonMsg $save, "Ошибка", false, ->
          $buttons.attr( "disabled", off )

      processing.then =>
        location.hash = "#{ @root }/#{ @model.id }"
        @buttonMsg $save, "Сохранено", true, ->
          $buttons.attr( "disabled", off )

    off

  del: ->
    $buttons = @$el.find( "button" )
    $buttons.attr( "disabled", on )
    $delete = $buttons.filter( ".b-product__delete" )

    processing = @model.destroy( wait: on )

    processing.fail =>
      @buttonMsg $delete, "Ошибка", false, ->
        $buttons.attr( "disabled", off )

    processing.then =>
      location.hash = @root

  render: ( params ) ->
    @$el.html @getTemplate()?( _.extend( {}, params, @model?.toJSON() ) )

    @