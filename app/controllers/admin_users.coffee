User = require( "../models/user" )
_ = require( "underscore" )

class AdminUsers

  @publicFields: "_id email roles"

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
          .select( AdminUsers.publicFields )
          .sort( "-_id" )
          .skip( offset )
          .limit( limit )
          .exec ( err, users ) ->
            if err? or users.length is 0
              res.render 404
            else
              res.json { offset, limit, count, users }

  profile: ( req, res ) ->
    _id = req.route.params.id

    User
      .findOne( { _id } )
      .select( AdminUsers.publicFields )
      .exec ( err, user ) ->
        if err or not user
          res.json( 404, error: "not found" )
        else
          res.json( user )

  saveProfile: ( req, res ) ->
    _id = req.route.params.id

    roles = []
    roles.push( 1 ) if req.body.admin?

    # @todo: validation

    User
      .findOne( { _id } )
      .exec ( err, user ) ->
        if err
          res.send( 504 )
        else unless user
          res.send( 404 )
        else
          user.email = req.body.email
          user.roles = req.body.roles
          user.password = req.body.password if req.body.password

          user.save ->
            res.json( user )

  createProfile: ( req, res ) ->
    roles = []
    roles.push( 1 ) if req.body.admin?

    User
      .findOne( email: req.body.email )
      .exec ( err, found ) ->
        if found
          res.send( 403 )
        else
          user = new User
            email: req.body.email
            password: req.body.password
            roles: roles

          # @todo: validation

          user.save ->
            res.json
              _id: user._id
              id: user._id
              email: user.email
              roles: user.roles

  deleteProfile: ( req, res ) ->
    _id = req.route.params.id

    return res.json( 403, error: "You can't remove your account" ) if _id is req.user._id.toString()

    User
      .remove( { _id } )
      .exec ( err ) ->
        if err
          res.json( 504, "Oops, something went wrong" )
        else
          res.json( success: on )

module.exports = AdminUsers