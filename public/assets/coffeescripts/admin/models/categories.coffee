class Witness.models.Categories extends Backbone.Collection

  initialize: ( categories ) ->
    @model = Witness.models.Category

  parse: ( res ) ->
    @offset = res.offset
    @count = res.count
    @limit = res.limit
    res.docs

  url: "/admin/categories"