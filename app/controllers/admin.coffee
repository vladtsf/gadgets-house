module.exports = class
  @index: (req, res) ->
    if req.user?
      res.render()
    else
      res.redirect("/login")