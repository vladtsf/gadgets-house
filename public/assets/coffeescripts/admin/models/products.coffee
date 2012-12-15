class Witness.models.Products extends Backbone.Collection

  model: Witness.models.Product

  initialize: ->

  parse: ( res ) ->
    @offset = res.offset
    @count = res.count
    @limit = res.limit
    res.docs

  url: -> "/admin/products/"