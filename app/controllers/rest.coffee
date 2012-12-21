Backbone = require( "../middleware/backbone" )
_ = require "underscore"

class RestController

  fields: []
  populate: []
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
    fields = if req.query.fields? then _.intersection( @fields, req.query.fields ) else @fields

    @model
      .count()
      .exec ( err, count ) =>
        query = @model
          .find()
          .select( _.union( "_id", fields ).join " "  )

        for own field in @populate
          query.populate( field )

        query
          .sort( "#{ order }_id" )
          .skip( offset )
          .limit( limit )
          .exec ( err, docs ) ->
            if err
              res.send 404
            else
              res.json { offset, limit, count, docs }

  show: ( req, res ) ->
    query = @model
      .findOne( _id: req.route.params.id )
      .select( _.union( "_id", @fields ).join " " )

    for own field in @populate
      query.populate( field )

    query
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

  complete: ( req, res ) ->
    field = req.route.params.field
    limit = parseInt( req.query.limit ) || 10

    return res.send 400 unless field in @fields and req.query.query?

    query = {}
    query[ field ] = new RegExp "^#{ req.query.query }", [ "i" ]

    @model
      .find( query )
      .select( "_id #{ field }" )
      .limit( limit )
      .exec ( err, docs ) =>
        return res.send( 500 ) if err

        res.json docs

  rescue: ( err, req, res ) ->
    res.json 500, errors: [ err.message ]

module.exports = RestController