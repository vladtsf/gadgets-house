mongoose = require "mongoose"
crypto = require "crypto"

schema = new mongoose.Schema
  email:
    type: String
    required: on
    index:
      unique: on
  password:
    type: String
    required: on
  roles: Array
  addresses: [
    type: mongoose.Schema.Types.ObjectId
    ref: "Address"
  ]

schema.pre "save", ( next ) ->
  # only hash the password if it has been modified (or is new)
  return next() unless @isModified( "password" )

  # Refresh password
  @password = @genPasswordHash( @password )

  # Next callback
  next()

schema.methods.genPasswordHash = ( password ) ->
  salt = crypto.createHash( "sha256" )
  salt.update( @email )
  pass = crypto.createHash( "sha256" )
  pass.update( "#{ password }#{ salt.digest( "base64" ) }" )
  pass.digest( "base64" )

schema.methods.checkPassword = ( password ) ->
  @password is @genPasswordHash( password )

module.exports = User = mongoose.model "User", schema