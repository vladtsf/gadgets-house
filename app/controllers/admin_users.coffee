_ = require( "underscore" )
AdminController = require( "./admin" )

class AdminUsers extends AdminController

  initialize: ->

  model: require "../models/user"
  fields: [ "_id", "email", "roles" ]

  validation: ->
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


  update: ( req, res ) ->
    _id = req.route.params.id

    roles = if req.body.admin then [ 0, 1 ] else [ 0 ]

    @validate()

    @model
      .findOne( { _id } )
      .exec ( err, user ) ->
        if err
          res.send( 504 )
        else unless user
          res.send( 404 )
        else
          user.email = req.body.email
          user.roles = roles
          user.password = req.body.password if req.body.password

          user.save ->
            res.json( user )

  create: ( req, res ) ->
    roles = if req.body.admin then [ 0, 1 ] else [ 0 ]

    @validate()

    @model
      .findOne( email: req.body.email )
      .exec ( err, found ) =>
        if found
          res.send( 403 )
        else
          user = new @model
            email: req.body.email
            password: req.body.password
            roles: roles

          user.save ->
            res.json
              _id: user._id
              email: user.email
              roles: user.roles

  del: ( req, res ) ->
    _id = req.route.params.id

    return res.json( 403, error: "You can't remove your account" ) if _id is req.user._id.toString()

    AdminController::del.apply @, arguments

module.exports = AdminUsers