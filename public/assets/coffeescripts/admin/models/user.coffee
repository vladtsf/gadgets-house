class Witness.models.User extends Backbone.Model

  initialize: ->
    @view = new Witness.views.User()
    @view.model = @
