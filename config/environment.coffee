express = require("express")
path    = require("path")
fs      = require("fs")

module.exports = (app) ->
  app.configure ->
    app.set "port", process.env.PORT or 3000
    app.set "views", fs.realpathSync(path.join __dirname, "..", "app", "views")
    app.set "view engine", "jade"

    app.use express.favicon fs.realpathSync(path.join __dirname, "..", "public", "assets", "images", "favicon.ico")
    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use require("less-middleware")( src: fs.realpathSync(path.join __dirname, "..", "public") )
    app.use express.static fs.realpathSync(path.join __dirname, "..", "public")
    app.use express.static fs.realpathSync(path.join __dirname, "..", "vendor")

  app.configure "development", ->
    app.use express.errorHandler()

  app.configure "production", ->
    app.use require("less-middleware")( src: fs.realpathSync(path.join __dirname, "..", "public"), compress: on )