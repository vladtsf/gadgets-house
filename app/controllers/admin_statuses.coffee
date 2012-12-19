AdminController = require "./admin"

class AdminStatuses extends AdminController

  initialize: ->

  model: require "../models/status"
  fields: [
    "name"
  ]

  validation:
    name:
      required: on
      msg: "Поле не может быть пустым"

module.exports = AdminStatuses