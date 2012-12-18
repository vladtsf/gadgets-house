AdminController = require "./admin"

class AdminShipment extends AdminController

  initialize: ->

  model: require "../models/shipment"
  fields: [
    "name"
    "price"
  ]

  validation:
    name:
      required: on
      msg: "Поле не может быть пустым"
    price:
      required: off
      pattern: "number"
      msg: "Цена должна быть числом"

module.exports = AdminShipment