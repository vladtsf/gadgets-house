mongoose = require "mongoose"

schema = new mongoose.Schema
  name:
    type: String
    required: on
  category:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "Category"
  manufacturer:
    required: on
    type: mongoose.Schema.Types.ObjectId
    ref: "Manufacturer"
  price:
    type: Number
    default: null
  published:
    type: Boolean
    default: off
  onStock:
    type: Boolean
    default: on
  description:
    required: off
    type: String
  custom:
    type: Object
    default: {}
  photo:
    required: off
    type: mongoose.Schema.Types.ObjectId
    ref: "Image"
  photos: [
    type: mongoose.Schema.Types.ObjectId
    ref: "Image"
  ]

module.exports = Product = mongoose.model "Product", schema