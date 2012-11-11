class Witness.models.UserEntry extends Backbone.Model

  initialize: ->
    @view = new Witness.views.UserEntry()
    @view.model = @
