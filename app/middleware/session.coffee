app = require( "../bootstrap" )
MongoStore = require("connect-mongo")(require "connect")
module.exports = new MongoStore url: app.settings.mongodb