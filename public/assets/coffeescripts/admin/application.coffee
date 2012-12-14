class window.AdminApplication extends Backbone.Router

  initialize: ->

  @settings = new Backbone.Model()

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

  category: ( id ) ->
    @switchNavBar( unless id then [ "categories", "categories-create" ] else [ "categories" ] )

    oldEntity = @currentEntity

    category = @currentEntity = new Witness.views.CategoryEdit( {}, id )

    render = =>
      oldEntity?.destroy()
      category.render()
      @setLayout( category )

    if id
      category.model.fetch().then render
    else
      render()

  product: ( id ) ->
    @switchNavBar( unless id then [ "products", "products-create" ] else [ "products" ] )

    oldEntity = @currentEntity

    product = @currentEntity = new Witness.views.ProductEdit( {}, id )

    render = =>
      oldEntity?.destroy()
      product.render()
      @setLayout( product )

    if id
      product.model.fetch().then render
    else
      render()

  listCategories: ( page = 0 ) ->
    @switchNavBar( [ "categories", "categories-list" ] )

    oldEntity = @currentEntity

    categories = @currentEntity = new Witness.views.CategoriesList()

    categories.model.fetch( add: on, data: offset: page * 10 ).then =>
      oldEntity?.destroy()
      categories.render()
      @setLayout( categories )

  listManufacturers: ( page = 0 ) ->
    @switchNavBar( [ "categories", "manufacturers" ] )

    oldEntity = @currentEntity

    manufacturers = @currentEntity = new Witness.views.ManufacturersList()

    manufacturers.model.fetch( add: on, data: offset: page * 10 ).then =>
      oldEntity?.destroy()
      manufacturers.render()
      @setLayout( manufacturers )

  profile: ( _id ) ->
    @switchNavBar( "users" )

    oldEntity = @currentEntity

    user = @currentEntity = new Witness.views.UsersProfile( {}, _id )

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

    "categories": "listCategories"
    "categories/new": "category"
    "categories/page/:page": "listCategories"
    "categories/:id": "category"

    "manufacturers": "listManufacturers"

    "products/new": "product"
    "products/:id": "product"


window.admin = new AdminApplication()