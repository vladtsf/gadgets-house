class Witness.views.ProductEdit extends Witness.View

  initialize: ( options, _id ) ->
    @model = @model ? new Witness.models.Product( { _id } )
    @categories = new Witness.models.Categories()

    # @fields.on "add", ( model, collection ) =>
    #   view = new Witness.views.CategoryFieldEdit( model: model )
    #   @$el.find( ".b-category-fields" ).append( view.render().el )

    Backbone.Validation.bind( @ )

  destroy: ->
    @remove()

  switchCategory: ( event ) ->
    $ct = $ event.currentTarget
    category = ( @categories.where name: $ct.val() )[ 0 ]

    @renderFields category.toJSON() if category?

    off

  renderFields: ( category ) ->
    locals = _.extend @model.toJSON(), category: category
    @$( ".b-custom-fields" ).html _.trim jade.templates[ "product-custom-fields" ] locals

    @

  render: ->
    @categories.fetch( add: on, data: limit: 100 ).then =>

      Witness.View::render.call @,
        categoriesSource: _.escape JSON.stringify ( category.name for own category in @categories.toJSON() )

      if @model.get "category"
        @renderFields @model.get "category"

      @$( ".b-toggle-button" ).toggleButtons()

      uploader = new qq.FineUploader
        element: @$( ".upload-photo" ).get 0
        multiple: off
        validation:
          allowedExtensions: ["jpeg", "jpg", "gif", "png"]
          sizeLimit: 4096e3 # 4096 kB = 4096 * 1024 bytes
        request:
          endpoint: "/admin/images/128x128/"
          forceMultipart: on
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
          onComplete: ( id, fileName, res) =>
            if res.success
              @model.set "photo", res._id
              @$( ".uploaded-photo-placeholder" ).html """<img width="128" height="128" src="#{ res.link }" alt="#{ fileName }" />"""

    # @fields.add @model.get( "fields" ) if @model.get( "fields" )?.length

    @


  # data: ->
  #   "name": @$el.find( "[name=\"category-name\"]" ).val()
  #   "machineName": @$el.find( "[name=\"category-machineName\"]" ).val()

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

  #   fields = []

  #   for own model in @fields.models
  #     model.validate()
  #     return off unless model.isValid()
  #     fields.push( model.toJSON() )

  #   @model.set( "fields", fields, silent: on )

  #   if @model.isValid()
  #     $buttons = @$el.find( "button" )

  #     $buttons.attr( "disabled", on )
  #     $save = $buttons.filter( ".b-profile__save" )

  #     processing = @model.save()

  #     processing.fail =>
  #       @buttonMsg $save, "Ошибка", false, ->
  #         $buttons.attr( "disabled", off )

  #     processing.then =>
  #       location.hash = "categories/#{ @model.id }"
  #       @buttonMsg $save, "Сохранено", true, ->
  #         $buttons.attr( "disabled", off )

  #   off

  # del: ->
  #   $buttons = @$el.find( "button" )
  #   $buttons.attr( "disabled", on )
  #   $delete = $buttons.filter( ".b-category__delete" )

  #   processing = @model.destroy( wait: on )

  #   processing.fail =>
  #     @buttonMsg $delete, "Ошибка", false, ->
  #       $buttons.attr( "disabled", off )

  #   processing.then =>
  #     location.hash = "categories"

  # addField: ->
  #   @fields.add( new Witness.models.CategoryField() )

  # validate: ( e ) ->
  #   @model.set( @data(), silent: on )

  #   @$el.find( ".control-group" )
  #     .removeClass( "error" )
  #     .find( ".help-inline" )
  #     .remove()

  #   for own field, msg of @model.validate()
  #     $errField = @$el.find( "form .control-group:has([name=\"category-#{ field }\"])" )

  #     $errField
  #       .addClass( "error" )
  #       .append( """<span class="help-inline">#{ msg }</span>""" )

  events:
    "change .b-category-select": "switchCategory"
    # "change .b-category-select": "switchCategory"
    # "click .b-category__delete": "del"
    # "click .b-category__add-field": "addField"
    # "focusout": "validate"

  template: "product-edit"