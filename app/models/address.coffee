mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
  city:
    type: String
    required: on
  street:
    type: String
    required: off
  house:
    type: String
    required: off
  building:
    type: String
    required: off
  housing:
    type: String
    required: off
  flat:
    type: String
    required: off

module.exports = Address = mongoose.model "Address", schema