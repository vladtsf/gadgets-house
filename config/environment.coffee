express = require "express"
path    = require "path"
fs      = require "fs"
passport= require "passport"
pkg     = require "../package.json"

module.exports = (app) ->

  app.configure "development", ->
    app.use express.errorHandler()
    app.set 'mongodb', "mongodb://localhost/#{ pkg.name }"
    app.set "amazonS3",
        key: "AKIAJ4FKRGWTKJAH5GYA"
        secret: "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"
        bucket: "gadgets-house-test"
    app.set "amazonCloudFont", "http://gadgets-house-test.s3.amazonaws.com"

  app.configure "production", ->
    app.set 'mongodb', process.env.MONGODB
    app.set "amazonS3",
        key: process.env.AMAZON_S3_KEY
        secret: process.env.AMAZON_S3_SECRET
        bucket: process.env.AMAZON_S3_BUCKET
    app.set "amazonCloudFont", process.env.AMAZON_CLOUD_FRONT_URL

  app.configure ->
    app.set "db", require( "../app/middleware/db" )
    app.set "port", process.env.PORT or 3000
    app.set "views", fs.realpathSync(path.join __dirname, "..", "app", "views")
    app.set "view engine", "jade"
    app.set "revision", pkg.version

    app.use express.favicon fs.realpathSync(path.join __dirname, "..", "static", "assets", "images", "favicon.ico")
    app.use "/admin/", express.favicon fs.realpathSync(path.join __dirname, "..", "static", "assets", "images", "favicon.ico")
    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.cookieSession
        secret: "5a260b696d83f103c13a80a31b04f2b4"
        key: "ssid"
        store: require("../app/middleware/session")
    app.use passport.initialize()
    app.use passport.session()
    app.configure "production", ->
        app.use express.csrf()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static fs.realpathSync(path.join __dirname, "..", "static")
    app.use express.static fs.realpathSync(path.join __dirname, "..", "vendor")
