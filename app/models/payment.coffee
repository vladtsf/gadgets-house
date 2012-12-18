mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
  commission:
    type: Number
    default: 0

module.exports = Payment = mongoose.model "Payment", schema