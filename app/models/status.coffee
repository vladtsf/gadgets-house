mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on

module.exports = Status = mongoose.model "Status", schema