class Witness.models.Categories extends Backbone.Collection

  initialize: ( categories ) ->
    @model = Witness.models.Category

    # @on "remove", ( model, collection ) ->
    #   model.view.remove()
    #   model.destroy()

    # @on "add", ( model, collection )->
    #   model.view.render()

  parse: ( res ) ->
    @offset = res.offset
    @count = res.count
    @limit = res.limit
    res.categories

  url: "/admin/categories"