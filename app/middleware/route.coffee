_ = require "underscore"
domain = require "domain"

module.exports = (app) ->
  return (method, path, route) ->
    controllerName = route.split("#")[0]
    actionName = route.split("#")[1]
    controller = require("../controllers/#{controllerName}")

    # define route handler
    app[method] path, (req, res, next) =>
      reqArgs = arguments
      reqd = domain.create()

      controllerInstance = new controller( req, res )

      res.on 'close', ->
        reqd.dispose()
        controllerInstance = null

      reqd.on "error", (er) ->
        if typeof controllerInstance.rescue is "function"
          controllerInstance.rescue.call controllerInstance, er, req, res, next
        else
          next er

        reqd.dispose()
        controllerInstance = null

      reqd.run =>
        _origRender = res.render

        # override original render method
        res.render = (params = {}, callback) ->
          _origRender.call @, "#{controllerName}/#{actionName}", _.extend({}, params, { request: req, _: _}), callback

        unless controllerInstance.stop
          if controllerInstance[actionName]?
            controllerInstance[actionName].apply controllerInstance, reqArgs
          else
            res.render()