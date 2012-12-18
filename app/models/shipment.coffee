mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
  price:
    type: Number
    default: 0

module.exports = Shipment = mongoose.model "Shipment", schema