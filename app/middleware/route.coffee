_ = require("underscore")

module.exports = (app) ->
  return (method, path, route) ->
    controllerName = route.split("#")[0]
    actionName = route.split("#")[1]

    controller = require("../controllers/#{controllerName}")
    action = controller[actionName]

    # define route handler
    app[method] path, (req, res) =>
      _origRender = res.render

      # override original render method
      res.render = (params = {}, callback) ->
        _origRender.call @, "#{controllerName}/#{actionName}", _.extend({}, params, request: req), callback

      if action?
        action.apply(@, arguments)
      else
        res.render()