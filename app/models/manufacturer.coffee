mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
    index:
      unique: on

module.exports = Manufacturer = mongoose.model "Manufacturer", schema