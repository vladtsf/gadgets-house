User = require( "../models/user" )

module.exports = class

  constructor: ( req, res ) ->
    unless req.user
      @stop = on
      res.redirect("/login")

  list: ( req, res ) ->
    User
      .find()
      .limit(10)
      .exec (err, users) ->
        if err? or users.length is 0
          res.render 404
        else
          res.render( { users } )

  # @loginForm: ->
  #   user = new User( email: 'vtsvang@gmail.com', password: "12345678", roles: [1] )
  #   user.save ->
  #     console.log(arguments)