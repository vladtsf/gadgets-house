_ = require("underscore")

module.exports = (app) ->
  return (method, path, route) ->
    controllerName = route.split("#")[0]
    actionName = route.split("#")[1]

    controller = require("../controllers/#{controllerName}")
    # action = controller[actionName]

    # define route handler
    app[method] path, (req, res) =>
      controllerInstance = new controller( req, res )

      _origRender = res.render

      # override original render method
      res.render = (params = {}, callback) ->
        _origRender.call @, "#{controllerName}/#{actionName}", _.extend({}, params, { request: req, _: _}), callback

      unless controllerInstance.stop
        if controllerInstance[actionName]?
          controllerInstance[actionName].apply( controllerInstance, arguments)
        else
          res.render()

      controllerInstance = null