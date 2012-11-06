app = require '../../app'
mongoose = require 'mongoose'
db = app.settings.db

schema = new mongoose.Schema
  name: Object
  photos: Object
  gender: String
  vkId: Number

module.exports = User = mongoose.model 'User', schema
