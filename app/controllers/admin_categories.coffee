User = require( "../models/user" )
_ = require( "underscore" )
async = require( "async" )
backbone = require( "../middleware/backbone" )
AdminController = require( "./admin" )

_.extend( backbone.Validation.patterns, {
  "machine-name": /^[a-z\d]+$/,
  "starts-with-word": /^[^\d]/
} )

class CategoryValidator extends backbone.Model

  idAttribute: "_id"

  initialize: ->
    @validation = do =>
      "machineName": [
        required: on
        msg: "Поле не может быть пустым"
      ,
        pattern: "machine-name"
        msg: "Поле должно состоять из латинских символов и цифр"
      ,
        pattern: "starts-with-word"
        msg: "Поле не должно начинаться с цифры"
      ]
      "name":
        required: on
        msg: "Поле не может быть пустым"

class AdminCategories extends AdminController

  Category = require "../models/category"

  # @publicFields: "_id email roles"

  initialize: ->

  validate: ( ) ->
    if typeof ( validation = new CategoryValidator( @req.body ).validate() ) isnt "undefined"
      @res.json( 403, { errors: validation, success: off } )
      return off

    return on

  list: ( req, res ) ->
    offset = parseInt( req.query.offset ) || 0
    limit = parseInt( req.query.limit ) || 10

    Category
      .count()
      .exec ( err, count ) ->
        Category
          .find()
          .sort( "-_id" )
          .skip( offset )
          .limit( limit )
          .exec ( err, categories ) ->
            if err
              res.send 404
            else
              res.json { offset, limit, count, categories }

  show: ( req, res ) ->
    Category
      .findOne( _id: req.route.params.id )
      .exec ( err, category ) =>
        return res.send( 503 ) if err
        return res.send( 404 ) unless category

        res.json category

  del: ( req, res ) ->
    Category
      .remove( _id: req.route.params.id )
      .exec ( err ) ->
        if err
          res.json 503, success: off
        else
          res.json success: on

  create: ( req, res ) ->
    return unless @validate()

    new Category( req.body ).save ( err, category ) =>
      return res.send( 503 ) if err

      res.json category

  update: ( req, res ) ->
    return unless @validate()

    { name, machineName, fields } = req.body

    Category
      .findOne( _id: req.route.params.id )
      .exec ( err, category ) =>
        if err
          res.send 503
        else unless category
          res.send 404
        else
          category.update
            $set: { name, machineName, fields }
          , ( err, numAffected ) =>
            return res.send( 503 ) if err

            res.json category

module.exports = AdminCategories