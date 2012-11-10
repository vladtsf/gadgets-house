User = require( "../models/user" )

module.exports = class

  constructor: ( req, res ) ->
    unless req.user
      @stop = on
      res.send( 403 )

  list: ( req, res ) ->
    offset = parseInt( req.query.offset ) || 0
    limit = parseInt( req.query.limit ) || 10

    User
      .count()
      .exec ( err, count ) ->
        User
          .find()
          .select( "_id email roles" )
          .sort( "-_id" )
          .skip( offset )
          .limit( limit )
          .exec (err, users) ->
            if err? or users.length is 0
              res.render 404
            else
              res.json { offset, limit, count, users }

  # @loginForm: ->
  #   user = new User( email: 'vtsvang@gmail.com', password: "12345678", roles: [1] )
  #   user.save ->
  #     console.log(arguments)