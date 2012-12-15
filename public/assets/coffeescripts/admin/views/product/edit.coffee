class Witness.views.ProductEdit extends Witness.View

  initialize: ( options, _id ) ->
    @model = @model ? new Witness.models.Product( { _id } )
    @categories = new Witness.models.Categories()
    @photos = new Backbone.Collection()
    @manufacturers = new Backbone.Collection( url: "/admin/manufacturers/name" )

    @partials =
      photo: new Witness.View
        model: @model
        template: "product-photo"
        partialPath: ".uploaded-photo-placeholder"
      photos: new Witness.views.ProductPhotos
        model: @model
        partialPath: ".uploaded-photos-placeholder"
        collection: @photos

    @model.on "change:photo", =>
      @partials.photo.render()

    @photos.on "add", ( model, collection ) =>
      @partials.photos.add model.id

    @photos.on "remove", ( model, collection ) =>
      @$( """.b-photos__thumb[data-id="#{ model.id }"]""" ).remove()

    Backbone.Validation.bind( @ )

  destroy: ->
    for own key, partial of @partials
      partial.remove()

    @remove()

  switchCategory: ( event ) ->
    $ct = $ event.currentTarget
    category = ( @categories.where name: $ct.val() )[ 0 ]

    @renderFields category.toJSON() if category?

  renderFields: ( category ) ->
    locals = _.extend @model.toJSON(), category: category
    @$( ".b-custom-fields" ).html _.trim jade.templates[ "product-custom-fields" ] locals

    @

  uploader: ( selector, multiple = off, size = "128x128" ) ->
    def = new $.Deferred()

    new qq.FineUploader
      element: @$( selector ).get 0
      multiple: multiple
      validation:
        allowedExtensions: ["jpeg", "jpg", "gif", "png"]
        sizeLimit: 4096e3 # 4096 kB = 4096 * 1024 bytes
      request:
        endpoint: "/admin/images/#{ size }/"
        forceMultipart: on
        customHeaders:
          "X-CSRF-Token": $( "meta[name=\"csrf\"]" ).attr( "content" )
      text:
        uploadButton: """Upload"""
      template: """<div class="qq-uploader">
                  <pre class="qq-upload-drop-area span12"><span>{dragZoneText}</span></pre>
                  <div class="qq-upload-button btn btn-success">Выбрать</div>
                  <ul class="qq-upload-list" style="display: none;"></ul>
                </div>"""
      classes:
        success: 'alert alert-success',
        fail: 'alert alert-error'
      debug: off
      callbacks:
        onComplete: ( id, fileName, res)  =>
          if res.success
            def.notify( res._id )
        onError: ( id, fileName, errorReason ) =>
          def.fail( id, errorReason )

    def

  render: ->
    if manufacturerName = @model.get( "manufacturer" )?.name
      completion = @complete manufacturerName, ->

    $.when( @categories.fetch( add: on, data: limit: 100 ), completion ).then =>

      Witness.View::render.call @,
        categoriesSource: _.escape JSON.stringify ( category.name for own category in @categories.toJSON() )

      # refresh partials
      for own key, partial of @partials
        partial.setElement @$ partial.options.partialPath
        partial.render()

      if @model.get "category"
        @renderFields @model.get "category"

      @$( ".b-toggle-button" ).toggleButtons()

      @uploader( ".upload-photo" ).progress ( id ) =>
        @model.set "photo", id

      @uploader( ".upload-photos", on, "260x180" ).progress ( id ) =>
        @photos.add { id }

      @$(".b-manufacturers-autocomplete").data "source", => @complete.apply @, arguments

      @$( ".fancybox" ).fancybox
        type: "image"

    @

  complete: ( query, process ) ->
    @_completeRequest?.abort()
    @_completeRequest = $.get "/admin/manufacturers/complete/name?query=#{ encodeURIComponent query }"

    @_completeRequest.then ( res ) =>
      @_manufacturersCache = {}

      for own item in res
        @_manufacturersCache[ item.name ] = item._id

      process ( item.name for own item in res )

    @_completeRequest


  removePhoto: ( e ) ->
    @photos.remove $( e.currentTarget.parentNode ).data "id"

  data: ->
    data =
      name: "name"
      category: "category"
      manufacturer: "manufacturer"
      price: "price"
      published: "published"
      onStock: "onStock"
      description: "description"

    for own key, field of data
      data[ key ] = @$( """[name="#{ field }"]""" ).val()

    data.published = data.published is "on"
    data.onStock = data.onStock is "on"
    data.category = @categories.where( name: data.category )[ 0 ]?.id
    data.manufacturer = @_manufacturersCache?[ data.manufacturer ]

    data.custom = {}

    for own field in @$ ".b-custom-field"
      $field = $( field )
      data.custom[ $field.attr( "name" ).replace "custom_", "" ] = $field.val()

    data.photo = @model.get "photo"
    data.photos = ( photo.id for own photo in @photos.toJSON() )

    data

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
        location.hash = "products/#{ @model.id }"
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
      location.hash = "products"

  validate: ( e ) ->
    @model.set( @data(), silent: on )

    @$el.find( ".control-group" )
      .removeClass( "error" )
      .find( ".help-inline" )
      .remove()

    for own field, msg of @model.validate()
      $errField = @$el.find( "form .control-group:has([name=\"#{ field }\"])" )

      $errField
        .addClass( "error" )
        .append( """<span class="help-inline">#{ msg }</span>""" )

  events:
    "change .b-category-select": "switchCategory"
    "click .b-remove-photo-button": "removePhoto"
    "submit": "save"
    "click .b-product__delete": "del"
    "focusout": "validate"
    "change *:not(.upload-photo, .upload-photos)": "validate"
    "input": "validate"

  template: "product-edit"