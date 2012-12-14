class Witness.views.ProductPhotos extends Witness.View

  initialize: ( options, _id ) ->

  add: ( id ) ->
    @$el.append @getTemplate()?( { id } )

  render: ->
    @$el.empty()

    if @model.get "photos"
      for own photo in @model.get "photos"
        @add photo.id

    @

  template: "product-photos"