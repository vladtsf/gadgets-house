mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
    index:
      unique: off
  mime:
    type: String
  size:
    width: Number
    height: Number
  uploaded:
    type: Date
    default: Date.now

module.exports = Image = mongoose.model "Image", schema