Backbone = require( "../middleware/backbone" )
_ = require "underscore"

class RestController

  fields: []
  model: {}

  validate: ->
    return on unless @validation

    Validator = Backbone.Model.extend
      idAttribute: "_id"
      validation = if typeof @validation is "function" then @validation() else @validation

    if typeof ( errors = new Validator( @req.body ).validate() ) isnt "undefined"
      @res.json( 400, { errors: errors, success: off } )
      return off

    on

  list: ( req, res ) ->
    offset = parseInt( req.query.offset ) || 0
    limit = parseInt( req.query.limit ) || 10
    order = if req.query.order is "+" then "+" else "-"

    @model
      .count()
      .exec ( err, count ) =>
        @model
          .find()
          .select( _.union( "_id", @fields ).join " "  )
          .sort( "#{ order }_id" )
          .skip( offset )
          .limit( limit )
          .exec ( err, docs ) ->
            if err
              res.send 404
            else
              res.json { offset, limit, count, docs }

  show: ( req, res ) ->
    @model
      .findOne( _id: req.route.params.id )
      .select( _.union( "_id", @fields ).join " " )
      .exec ( err, doc ) =>
        return res.send( 500 ) if err
        return res.send( 404 ) unless doc

        res.json doc

  del: ( req, res ) ->
    @model
      .remove( _id: req.route.params.id )
      .exec ( err ) ->
        if err
          res.json 500, success: off
        else
          res.json success: on

  create: ( req, res ) ->
    return unless @validate()

    changeset = {}

    for own field in @fields when field isnt "_id" and req.body[ field ]?
      changeset[ field ] = req.body[ field ]

    new @model( changeset ).save ( err, doc ) =>
      console.log err
      return res.send( 500 ) if err

      res.json doc

  update: ( req, res ) ->
    return unless @validate()

    changeset = {}

    for own field in @fields when field isnt "_id" and req.body[ field ]?
      changeset[ field ] = req.body[ field ]

    @model
      .findOne( _id: req.route.params.id )
      .exec ( err, doc ) =>
        if err
          res.send 500
        else unless doc
          res.send 404
        else
          doc.update
            $set: changeset
          , ( err, numAffected ) =>
            return res.send( 500 ) if err

            res.json doc

module.exports = RestController