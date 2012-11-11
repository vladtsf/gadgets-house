class Witness.views.Users extends Witness.View

  initialize: ->

  render: ->
    Witness.View::render.call( @ )
    @$usersRoot = @$el.find( ".b-users-table__body" )
    @

  template: "users"

  # options:
  #   el: "#layout"