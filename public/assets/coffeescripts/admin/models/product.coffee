class Witness.models.Product extends Backbone.Model

  idAttribute: "_id"

  initialize: ->
    @validation = do =>
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

  url: -> "/admin/products/#{ @get( "_id" ) ? "" }"