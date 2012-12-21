AdminController = require "./admin"

class AdminOrders extends AdminController

  initialize: ->

  model: require "../models/order"
  fields: [
    "name"
    "address"
    "phoneNumber"
    "shipmentType"
    "shipmentDate"
    "paymentType"
    "items"
    "status"
    "note"
  ]

  validation:
    name:
      required: on
      msg: "Поле не может быть пустым"
    address:
      required: on
      msg: "Не указан адрес"
    phoneNumber:
      required: on
      msg: "Не указан номер телефона"
    shipmentType
      required: on
      msg: "Не указан способ доставки"
    shipmentDate
      required: on
      msg: "Не указана дата доставки"
    items:
      required: on
      msg: "Не перечислены товары"
    paymentType
      required: on
      msg: "Не указан способ оплаты"

module.exports = AdminOrders