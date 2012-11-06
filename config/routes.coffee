module.exports = (app, route) ->

  route "get", "/", "home#index"

  app.namespace "/admin", ->
    route "get", "/", "admin#index"

  app.namespace "/auth", ->
    route "post", "/login", "auth#login"
    route "get", "/logout", "auth#logout" # xss

  route "get", "/login", "auth#loginForm"