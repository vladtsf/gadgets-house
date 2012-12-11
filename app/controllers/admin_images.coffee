app = require "../bootstrap"
AdminController = require( "./admin" )
async = require( "async" )
fs = require "fs"
knox = require "knox"
mmmagic = require "mmmagic"
gm = require( "gm" ).subClass imageMagick: true
require "gm-buffer"

class AdminImages extends AdminController

  Image = require "../models/image"
  Magic = mmmagic.Magic
  amazon = knox.createClient( app.settings.amazonS3 )

  initialize: ->

  show: ( req, res ) ->
    Image
      .findOne( _id: req.route.params.id )
      .exec ( err, image ) =>
        return res.send( 503 ) if err
        return res.send( 404 ) unless image

        res.json
          _id: image._id
          mime: image.mime
          name: image.name
          uploaded: +image.uploaded
          size: image.size
          original: "#{ app.settings.amazonCloudFont }/images/#{ image._id }/original"
          thumb: "#{ app.settings.amazonCloudFont }/images/#{ image._id }/thumb"

  del: ( req, res ) ->
    async.parallel [
        ( callback ) =>
          Image.remove _id: req.route.params.id, callback
        ( callback ) =>
          amazon.deleteFile "/images/#{ req.route.params.id }", callback
    ], ( err, results ) =>
      return res.send( 503 ) if err

      res.json {}

  create: ( req, res ) ->
    return res.json( 400, success: off, error: "Bad request" ) unless req.files.qqfile?

    picture = gm( req.files.qqfile.path )

    if resized = req.route.params.width? or req.route.params.height?
      picture.resize req.route.params.width, req.route.params.height

    async.parallel [
      ( callback ) ->
        new Magic( mmmagic.MAGIC_MIME_TYPE ).detectFile req.files.qqfile.path, callback
      ( callback ) ->
        picture.buffer callback
      ( callback ) ->
        picture.identify callback
    ], ( err, results ) ->
        return res.json( 500, success: off, error: "Internal server error" ) if err

        image = new Image
          name: req.files.qqfile.filename
          mime: results[ 0 ]
          size: results[ 2 ][ 0 ]?.size

        async.parallel [
            ( callback ) ->
              image.save callback
            ( callback ) ->
              if resized
                amazon.putBuffer results[ 1 ], "/images/#{ image._id }/thumb", { "Content-Type": results[ 0 ] }, callback
              else
               callback()
            ( callback ) ->
              amazon.putFile req.files.qqfile.path, "/images/#{ image._id }/original", { "Content-Type": results[ 0 ] }, callback
        ], ( err, results ) =>
          return res.json( 500, success: off, error: "Internal server error" ) if err

          res.json
            _id: image._id
            mime: image.mime
            name: image.name
            uploaded: +image.uploaded
            size: image.size
            original: "#{ app.settings.amazonCloudFont }/images/#{ image._id }/original"
            thumb: "#{ app.settings.amazonCloudFont }/images/#{ image._id }/thumb"
            success: on

module.exports = AdminImages