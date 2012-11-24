mongoose = require "mongoose"

schema = new mongoose.Schema
  "name":
    type: String
    required: on
  "machineName":
    type: String
    required: on
    index:
      unique: on
  fields: [
    "name": String
    "machineName": String
    "multiline": Boolean
  ]

module.exports = Category = mongoose.model "Category", schema