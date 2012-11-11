module.exports = (app, route) ->

  route "get", "/", "home#index"

  app.namespace "/admin", ->
    route "get", "/", "admin#index"

    app.namespace "/users", ->
      route "get", "/", "admin_users#list"
      route "get", "/:id", "admin_users#profile"
      route "post", "/:id", "admin_users#saveProfile"
      route "delete", "/:id", "admin_users#deleteProfile"

  route "get", "/login", "auth#loginForm"
  route "post", "/login", "auth#login"
  route "get", "/logout", "auth#logout" # xss
