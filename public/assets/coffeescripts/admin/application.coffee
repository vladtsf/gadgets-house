class window.AdminApplication extends Backbone.Router

  initialize: ->
    @on "all", ( route, args... ) ->
      if matched = route.match /^route:(list|edit):(\w+)$/
        @[ matched[ 1 ] ].apply @, _.union matched[ 2 ], args

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

  _routes:
    shipment:
      list:
        navBar: [ "orders", "shipment" ]
        title: "Способы доставки"
        fields:
          name: "Название:inline"
          price: "Цена:inline"
      edit:
        navBar: [ "orders", "shipment" ]
        title: "Способ доставки"
        validation:
          name:
            required: on
            msg: "Поле не может быть пустым"
          price:
            required: off
            pattern: "number"
            msg: "Значение должно быть числовым"
        fields:
          name: "Название:inline"
          price: "Цена:inline"
    payment:
      list:
        navBar: [ "orders", "payment" ]
        title: "Способы оплаты"
        fields:
          name: "Название:inline"
          commission: "Комиссия:inline"
      edit:
        navBar: [ "orders", "payment" ]
        title: "Способ оплаты"
        validation:
          name:
            required: on
            msg: "Поле не может быть пустым"
          commission:
            required: off
            pattern: "number"
            msg: "Значение должно быть числовым"
        fields:
          name: "Название:inline"
          commission: "Комиссия:inline"


  list: ( entity, page = 0 ) ->
    route = @_routes[ entity ]?.list

    @switchNavBar route.navBar if route.navBar?
    oldEntity = @currentEntity
    entity = @currentEntity = new Witness.CRUDView _.extend { action: "list", entity: entity }, route
    entity.list( page ).then =>
      oldEntity?.destroy()
      @setLayout entity

  edit: ( entity, id ) ->
    route = @_routes[ entity ]?.edit

    @switchNavBar route.navBar if route.navBar?
    oldEntity = @currentEntity
    entity = @currentEntity = new Witness.CRUDView _.extend { action: "edit", entity: entity }, route
    entity.edit( id ).then =>
      oldEntity?.destroy()
      @setLayout entity

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

  listProducts: ( page = 0 ) ->
    @switchNavBar( [ "products", "products-list" ] )

    oldEntity = @currentEntity

    products = @currentEntity = new Witness.views.ProductsList()

    products.model.fetch( add: on, data: offset: page * 10 ).then =>
      oldEntity?.destroy()
      products.render()
      @setLayout( products )

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

    "products": "listProducts"
    "products/page/:page": "listProducts"
    "products/new": "product"
    "products/:id": "product"

    "shipment": "list:shipment"
    "shipment/page/:page": "list:shipment"
    "shipment/new": "edit:shipment"
    "shipment/:id": "edit:shipment"

    "payment": "list:payment"
    "payment/page/:page": "list:payment"
    "payment/new": "edit:payment"
    "payment/:id": "edit:payment"


window.admin = new AdminApplication()