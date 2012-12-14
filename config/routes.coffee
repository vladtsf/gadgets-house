module.exports = (app, route) ->

  route "get", "/", "home#index"

  app.namespace "/admin", ->
    route "get", "/", "admin#index"

    app.namespace "/users", ->
      route "get", "/", "admin_users#list"
      route "get", "/:id", "admin_users#show"
      route "put", "/:id", "admin_users#update"
      route "post", "/", "admin_users#create"
      route "delete", "/:id", "admin_users#del"

    app.namespace "/categories", ->
      route "get", "/", "admin_categories#list"
      route "post", "/", "admin_categories#create"
      route "get", "/:id", "admin_categories#show"
      route "put", "/:id", "admin_categories#update"
      route "delete", "/:id", "admin_categories#del"

    app.namespace "/manufacturers", ->
      route "get", "/", "admin_manufacturers#list"
      route "post", "/", "admin_manufacturers#create"
      route "get", "/:id", "admin_manufacturers#show"
      route "put", "/:id", "admin_manufacturers#update"
      route "delete", "/:id", "admin_manufacturers#del"
      route "get", "/complete/:field", "admin_manufacturers#complete"

    app.namespace "/products", ->
      route "get", "/", "admin_products#list"
      route "post", "/", "admin_products#create"
      route "get", "/:id", "admin_products#show"
      route "put", "/:id", "admin_products#update"
      route "delete", "/:id", "admin_products#del"

    app.namespace "/images", ->
      route "get", "/", "admin_images#list"
      route "post", "/(:width?x:height?)?", "admin_images#create"
      route "get", "/:id", "admin_images#show"
      route "delete", "/:id", "admin_images#del"

  route "get", "/login", "auth#loginForm"
  route "post", "/login", "auth#login"
  route "get", "/logout/:csrf", "auth#logout"
