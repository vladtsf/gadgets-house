passport = require('passport')
LocalStrategy = require('passport-local').Strategy;

passport.serializeUser (user, done) ->
  done null, 123
passport.deserializeUser (id, done) ->
  done null, {}
  # User.findOne id, (err, user) ->
    # done err, user
passport.use new LocalStrategy {usernameField: 'login', passwordField: 'password'}, (username, password, done) ->
  if username is "admin" and password is "12345678"
    return done(null, {username: "admin"})
  else
    return done( null, off, {message: "nope"} )
  # User.findOne({ username: username }, function (err, user) {
    # if (err) { return done(err); }
    # if (!user) {
    #   return done(null, false, { message: 'Unknown user' });
    # }
    # if (!user.validPassword(password)) {
    #   return done(null, false, { message: 'Invalid password' });
    # }
  # console.log "asddsasa"

module.exports = class

  @login: passport.authenticate('local',
      successRedirect: '/admin'
      failureRedirect: '/login'
  )

  @logout: (req, res) ->
    req.logOut()
    res.redirect('/');
