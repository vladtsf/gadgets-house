class AdminApplication extends Backbone.Router

  initialize: ->

  switchNavBar: ( tab )->
    $( ".b-admin-navbar li:has(a[data-action])" )
      .removeClass( "active" )
      .filter( ":has([data-action=\"#{ tab }\"])" )
      .addClass( "active" )

  setLayout: ( view ) ->
    $( "#layout" ).empty().append( view.el )

  dashboard: ->
    @switchNavBar( "dashboard" )
    @currentEntity?.destroy()

  users: ( page = 0 ) ->
    @switchNavBar( "users" )

    oldEntity = @currentEntity

    users = @currentEntity = new Witness.models.Users()

    users.fetch( add: on, data: offset: page * 10 ).then =>
      oldEntity?.destroy()
      users.render()

      @setLayout( users.view )


  root: ->

  routes:
    "": "dashboard"
    "users": "users"
    "users/page/:page": "users"


window.admin = new AdminApplication()