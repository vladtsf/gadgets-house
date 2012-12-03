async = require( "async" )
AdminController = require( "./admin" )
knox = require "knox"
app = require "../bootstrap"

class AdminBlobs extends AdminController

  Blob = require "../models/blob"
  amazon = knox.createClient( app.settings.amazonS3 )

  initialize: ->

  list: ( req, res ) ->
    offset = parseInt( req.query.offset ) || 0
    limit = parseInt( req.query.limit ) || 10

    Blob
      .count()
      .exec ( err, count ) ->
        Blob
          .find()
          .sort( "-uploaded" )
          .skip( offset )
          .limit( limit )
          .exec ( err, blobs ) ->
            if err
              res.send 404
            else
              res.json { offset, limit, count, blobs }

  show: ( req, res ) ->
    Blob
      .findOne( _id: req.route.params.id )
      .exec ( err, blob ) =>
        return res.send( 503 ) if err
        return res.send( 404 ) unless blob

        res.json
          _id: blob._id
          name: blob.name
          uploaded: +blob.uploaded
          link: "#{ app.settings.amazonCloudFont }/blobs/#{ blob._id }"

  del: ( req, res ) ->
    async.parallel [
        ( callback ) =>
          Blob.remove _id: req.route.params.id, callback
        ( callback ) =>
          amazon.deleteFile "/blobs/#{ req.route.params.id }", callback
    ], ( err, results ) =>
      return res.send( 503 ) if err

      res.json {}

  create: ( req, res ) ->
    return res.send( 400 ) unless req.files.image?

    blob = new Blob( name: req.files.image.filename )

    async.parallel [
        ( callback ) =>
          blob.save callback
        ( callback ) =>
          amazon.putFile req.files.image.path, "/blobs/#{ blob._id }", callback
    ], ( err, results ) =>
      return res.send( 503 ) if err

      res.json blob

module.exports = AdminBlobs