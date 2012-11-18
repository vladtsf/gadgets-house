class Witness.models.CategoryFields extends Backbone.Collection

  initialize: ( users ) ->
    # @on "remove", ( model, collection ) ->
    #   model.view.remove()
    #   model.destroy()

    # @on "add", ( model, collection )->
    #   console.log( "sadsa" )

  # parse: ( res ) ->
  #   @offset = res.offset
  #   @count = res.count
  #   res.users

  # url: "/admin/users"
  model: Witness.models.CategoryField