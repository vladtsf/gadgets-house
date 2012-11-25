User = require( "../models/user" )
_ = require( "underscore" )
backbone = require( "../middleware/backbone" )
AdminController = require( "./admin" )

class UserValidator extends backbone.Model

  idAttribute: "_id"

  initialize: ->
    @validation = do =>
      email: [
        required: on
        msg: "Поле не может быть пустым"
      ,
        pattern: 'email'
        msg: "Введите действительный адрес email"
      ]
      password:
        required: not @id?
        minLength: 4
        msg: "Пароль должен быть длиннее 4 символов"
      password_repeat:
        equalTo: "password"
        msg: "Пароли не совпадают"

class AdminUsers extends AdminController

  @publicFields: "_id email roles"

  initialize: ->

  validate: ( ) ->
    if typeof ( validation = new UserValidator( @req.body ).validate() ) isnt "undefined"
      @res.json( 400, { errors: validation, success: off } )
      return off

    return on

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

    @validate()

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

    @validate()

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

          user.save ->
            res.json
              _id: user._id
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