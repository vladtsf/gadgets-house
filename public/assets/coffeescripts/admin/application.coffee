class AdminApplication extends Backbone.Router

  initialize: ->

  switchNavBar: ( tabs )->
    selector = []

    if tabs.constructor is Array
      selector.push( "[data-action=\"#{ item }\"]" ) for own item in tabs
    else
      selector.push( "[data-action=\"#{ tabs }\"]" )

    $( ".b-admin-navbar li:has(a[data-action])" )
      .removeClass( "active" )
      .filter( ":has(#{ selector.join( "," ) })" )
      .addClass( "active" )

  setLayout: ( view ) ->
    $( "#layout" ).empty().append( view.el )

  dashboard: ->
    @switchNavBar( "dashboard" )
    @currentEntity?.destroy()

  users: ( page = 0 ) ->
    @switchNavBar( [ "users", "users-list" ] )

    oldEntity = @currentEntity

    users = @currentEntity = new Witness.models.Users()

    users.fetch( add: on, data: offset: page * 10 ).then =>
      oldEntity?.destroy()
      users.render()

      @setLayout( users.view )

  createUser: ->
    @switchNavBar( [ "users", "users-create" ] )

    oldEntity = @currentEntity

    user = @currentEntity = new Witness.views.UsersProfile()
    oldEntity?.destroy()
    user.render()
    @setLayout( user )

  profile: ( id ) ->
    @switchNavBar( "users" )

    oldEntity = @currentEntity

    user = @currentEntity = new Witness.views.UsersProfile( {}, id )

    user.model.fetch().always =>
      oldEntity?.destroy()
      user.render()
      @setLayout( user )

  routes:
    "": "dashboard"
    "users": "users"
    "users/new": "createUser"
    "users/page/:page": "users"
    "users/:id": "profile"


window.admin = new AdminApplication()