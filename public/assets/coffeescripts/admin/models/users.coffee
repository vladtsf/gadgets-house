class Witness.models.Users extends Backbone.Collection

  initialize: ( users ) ->
    @on "remove", ( model, collection ) ->
      model.view.remove()
      model.destroy()

    @on "add", ( model, collection )->
      model.view.render()

  destroy: ->
    @remove( @models )
    @view?.remove()

  render: ->
    @view = new Witness.views.Users()
    @view.render()

    @pager = new Witness.views.UsersPager()
    @pager.setElement( @view.$el.find( ".b-users__pagination" ) )
    @pager.render( offset: @offset, count: @count )

    for own model in @models
      @view.$usersRoot.append( model.view.el )

  parse: ( res ) ->
    @offset = res.offset
    @count = res.count
    res.users

  url: "/admin/users"
  model: Witness.models.User