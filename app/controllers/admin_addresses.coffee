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

  autocomplete: ( req, res ) ->
    limit = parseInt( req.query.limit ) || 10

    query = @model
      .find()
      .select( "name city street house building housing flat _id" )
      .limit( limit )
      .exec ( err, docs ) ->
        if err
          res.send 404
        else
          res.json docs: ( _id: doc._id, address: "#{doc.name}: #{doc.city} #{doc.street} #{doc.house} #{doc.building} #{doc.housing} #{doc.flat}" for own doc in docs )


  validation:
    name:
      required: on
      msg: "Имя адреса не может быть не заполнено"
    city:
      required: on
      msg: "Не указан город"

module.exports = AdminAddresses