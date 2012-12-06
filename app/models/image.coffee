mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
    index:
      unique: off
  uploaded:
    type: Date
    default: Date.now

module.exports = Image = mongoose.model "Image", schema