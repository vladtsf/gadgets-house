#!/usr/bin/env ./node_modules/coffee-script/bin/coffee


###
Module dependencies.
###
express   = require("express")
namespace = require('express-namespace')
http      = require("http")

module.exports = app = express()

require("./config/environment")(app)
require("./config/routes")( app, require("./app/middleware/route")(app) )

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port #{app.get("port")}"

