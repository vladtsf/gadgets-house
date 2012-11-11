passport = require( "passport" )
Local = require( "passport-local" )
User = require( "../models/user" )

# To support persistent login sessions, Passport needs to know
# how to serialize a user instance.
passport.serializeUser ( user, done ) ->
  done( null, user._id )

# To support persistent login sessions, Passport needs to know
# how to deserialize a user instance.
passport.deserializeUser ( _id, done ) ->
  User.findOne { _id }, ( err, user ) ->
    done( null, user )

passport.use new Local.Strategy {usernameField: 'login', passwordField: 'password'}, ( email, password, done ) ->
  User.findOne { email }, ( err, user ) ->
    return done( err ) if err

    unless user
      return done( null, false, message: "Unknown user" )

    unless user.checkPassword( password )
      return done( null, false, message: "Invalid password" )

    done( null, user )

module.exports = class

  login: passport.authenticate("local",
      successRedirect: "/admin"
      failureRedirect: "/login"
  )

  logout: (req, res) ->
    req.logOut() if req.route.params.csrf is req.session._csrf
    res.redirect( "/admin/" )

# user = new User( email: 'admin@gadgets-house.net', password: "12345678", roles: [1] )
# user.save ->
#   console.log(arguments)