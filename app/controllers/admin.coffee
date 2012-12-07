class AdminController extends require( "./rest" )

  constructor: ( @req, @res ) ->
    unless req.user
      @stop = on
      res.redirect( "/login" )
    else unless 1 in req.user.roles
      @stop = on
      res.redirect( "/" )

module.exports = AdminController