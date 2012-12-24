mongoose = require "mongoose"

schema = new mongoose.Schema
  customer:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "User"
  address:
    required: off
    type: mongoose.Schema.Types.ObjectId
    ref: "Address"
  phoneNumber:
    type: String
    required: on
  shipmentType:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "Shipment"
  shipmentDate:
    type: Date
    default: -> Date.now() + 86400e3
  paymentType:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "Payment"
  items: [
    type: mongoose.Schema.Types.ObjectId
    ref: "Product"
  ]
  status:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "Status"
  note:
    type: String
    default: ""

module.exports = Order = mongoose.model "Order", schema