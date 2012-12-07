AdminController = require( "./admin" )

require( "underscore" ).extend require( "../middleware/backbone" ).Validation.patterns,
  "machine-name": /^[a-z\d]+$/
  "starts-with-word": /^[^\d]/


class AdminCategories extends AdminController

  initialize: ->

  model: require "../models/category"
  fields: [ "machineName", "name", "fields" ]

  validation:
    machineName: [
      required: on
      msg: "Поле не может быть пустым"
    ,
      pattern: "machine-name"
      msg: "Поле должно состоять из латинских символов и цифр"
    ,
      pattern: "starts-with-word"
      msg: "Поле не должно начинаться с цифры"
    ]
    name:
      required: on
      msg: "Поле не может быть пустым"

module.exports = AdminCategories