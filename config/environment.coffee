express = require("express")
path    = require("path")
fs      = require("fs")
passport= require("passport")
pkg     = require("../package.json")

module.exports = (app) ->

  app.configure "development", ->
    app.use express.errorHandler()
    app.set 'mongodb', "mongodb://localhost/#{pkg.name}"

  app.configure "production", ->
    app.use require("less-middleware")( src: fs.realpathSync(path.join __dirname, "..", "public"), compress: on )
    app.set 'mongodb', process.env.MONGODB

  app.configure ->
    app.set "port", process.env.PORT or 3000
    app.set "views", fs.realpathSync(path.join __dirname, "..", "app", "views")
    app.set "view engine", "jade"

    app.use express.favicon fs.realpathSync(path.join __dirname, "..", "public", "assets", "images", "favicon.ico")
    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.cookieSession
        secret: "5a260b696d83f103c13a80a31b04f2b4"
        key: "sid"
        store: require("../app/middleware/session")( app )
    app.use passport.initialize()
    app.use passport.session()
    app.use express.methodOverride()
    app.use app.router
    app.use require("less-middleware")( src: fs.realpathSync(path.join __dirname, "..", "public") )
    app.use express.static fs.realpathSync(path.join __dirname, "..", "public")
    app.use express.static fs.realpathSync(path.join __dirname, "..", "vendor")
