module.exports = (app, route) ->

  route "get", "/", "home#index"

  # app.namespace "/forum", ->
  #   route "get", "/", "forum#index"