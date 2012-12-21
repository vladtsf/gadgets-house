AdminController = require "./admin"

class AdminAddresses extends AdminController

  initialize: ->

  model: require "../models/address"
  fields: [
    "name"
    "city"
    "street"
    "house"
    "building"
    "housing"
    "flat"
  ]

  validation:
    name:
      required: on
      msg: "Имя адреса не может быть не заполнено"
    city:
      required: on
      msg: "Не указан город"

module.exports = AdminAddresses