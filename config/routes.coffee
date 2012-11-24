module.exports = (app, route) ->

  route "get", "/", "home#index"

  app.namespace "/admin", ->
    route "get", "/", "admin#index"

    app.namespace "/users", ->
      route "get", "/", "admin_users#list"
      route "get", "/:id", "admin_users#profile"
      route "put", "/:id", "admin_users#saveProfile"
      route "post", "/", "admin_users#createProfile"
      route "delete", "/:id", "admin_users#deleteProfile"

    app.namespace "/categories", ->
      route "get", "/", "admin_categories#list"
      route "post", "/", "admin_categories#create"
      route "get", "/:id", "admin_categories#show"
      route "put", "/:id", "admin_categories#update"
      route "delete", "/:id", "admin_categories#del"

  route "get", "/login", "auth#loginForm"
  route "post", "/login", "auth#login"
  route "get", "/logout/:csrf", "auth#logout"
