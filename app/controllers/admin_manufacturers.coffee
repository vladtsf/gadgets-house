AdminController = require "./admin"

class AdminManufacturers extends AdminController

  initialize: ->

  model: require "../models/manufacturer"
  fields: [ "name" ]

  validation:
    "name":
      required: on
      msg: "Поле не может быть пустым"

module.exports = AdminManufacturers