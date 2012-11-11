module.exports = class

  constructor: ( req, res ) ->
    unless req.user
      @stop = on
      res.redirect("/login")

# User = require( "../models/user" )
# user = new User( email: 'vtsvang@gmail.com', password: "12345678", roles: [1] )
# user.save ->
#   console.log(arguments)