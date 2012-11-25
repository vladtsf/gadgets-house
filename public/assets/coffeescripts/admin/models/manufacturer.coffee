class Witness.models.Manufacturer extends Backbone.Model

  idAttribute: "_id"

  initialize: ->
    @validation = do =>
      name:
        required: on
        msg: "Поле не может быть пустым"

  url: -> "/admin/manufacturers/#{ @get( "_id" ) ? "" }"