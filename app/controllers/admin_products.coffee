AdminController = require "./admin"

class AdminProducts extends AdminController

  initialize: ->

  model: require "../models/product"
  populate: [
    # "photo"
    # "photos"
    "manufacturer"
    "category"
  ]
  fields: [
    "name"
    "category"
    "manufacturer"
    "price"
    "published"
    "onStock"
    "description"
    "custom"
    "photo"
    "photos"
  ]

  validation:
    name:
      required: on
      msg: "Поле не может быть пустым"
    category:
      required: on
      msg: "Выберите категорию"
    manufacturer:
      required: on
      msg: "Выберите производителя"
    price:
      required: off
      pattern: "number"
      msg: "Цена должна быть числом"

  # create: ( req, res ) ->
  #   console.log req.body
  #   return unless @validate()

  #   changeset = {}

  #   for own field in @fields when field isnt "_id" and req.body[ field ]?
  #     changeset[ field ] = req.body[ field ]

  #   for own

  #   new @model( changeset ).save ( err, doc ) =>
  #     console.log err
  #     return res.send( 500 ) if err

  #     res.json doc

module.exports = AdminProducts