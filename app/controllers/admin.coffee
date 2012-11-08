module.exports = class

  constructor: ( req, res ) ->
    unless req.user
      @stop = on
      res.redirect("/login")
