AdminController = require "./admin"

class AdminPayment extends AdminController

  initialize: ->

  model: require "../models/payment"
  fields: [
    "name"
    "commission"
  ]

  validation:
    name:
      required: on
      msg: "Поле не может быть пустым"
    commission:
      required: off
      pattern: "number"
      msg: "Комиссия должна быть числом"

module.exports = AdminPayment