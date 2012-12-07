User = require( "../models/user" )
_ = require( "underscore" )
async = require( "async" )
backbone = require( "../middleware/backbone" )
AdminController = require( "./admin" )

class AdminManufacturers extends AdminController

  Manufacturer = require "../models/manufacturer"

  initialize: ->

  model: require "../models/manufacturer"
  fields: [ "name" ]

  validation:
    "name":
      required: on
      msg: "Поле не может быть пустым"

  # list: ( req, res ) ->
  #   offset = parseInt( req.query.offset ) || 0
  #   limit = parseInt( req.query.limit ) || 10

  #   console.log Manufacturer

  #   Manufacturer
  #     .count()
  #     .exec ( err, count ) ->
  #       Manufacturer
  #         .find()
  #         .sort( "+_id" )
  #         .skip( offset )
  #         .limit( limit )
  #         .exec ( err, manufacturers ) ->
  #           if err
  #             res.send 404
  #           else
  #             res.json { offset, limit, count, manufacturers }

  # show: ( req, res ) ->
  #   Manufacturer
  #     .findOne( _id: req.route.params.id )
  #     .exec ( err, manufacturer ) =>
  #       return res.send( 503 ) if err
  #       return res.send( 404 ) unless manufacturer

  #       res.json manufacturer

  # del: ( req, res ) ->
  #   Manufacturer
  #     .remove( _id: req.route.params.id )
  #     .exec ( err ) ->
  #       if err
  #         res.json 503, success: off
  #       else
  #         res.json success: on

  # create: ( req, res ) ->
  #   return unless @validate()

  #   new Manufacturer( { name } = req.body ).save ( err, manufacturer ) =>
  #     return res.send( 503 ) if err

  #     res.json manufacturer

  # update: ( req, res ) ->
  #   return unless @validate()

  #   { name } = req.body

  #   Manufacturer
  #     .findOne( _id: req.route.params.id )
  #     .exec ( err, manufacturer ) =>
  #       if err
  #         res.send 503
  #       else unless manufacturer
  #         res.send 404
  #       else
  #         manufacturer.update
  #           $set: { name }
  #         , ( err, numAffected ) =>
  #           return res.send( 503 ) if err

  #           res.json manufacturer

module.exports = AdminManufacturers