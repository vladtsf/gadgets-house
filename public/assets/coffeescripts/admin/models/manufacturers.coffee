class Witness.models.Manufacturers extends Backbone.Collection

  initialize: ( categories ) ->
    @model = Witness.models.Manufacturer

  parse: ( res ) ->
    @offset = res.offset
    @count = res.count
    @limit = res.limit
    res.docs

  url: "/admin/manufacturers"