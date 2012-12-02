class Witness.models.Product extends Backbone.Model

  idAttribute: "_id"

  initialize: ->
    # @validation = do =>
    #   machineName: [
    #     required: on
    #     msg: "Поле не может быть пустым"
    #   ,
    #     pattern: "machine-name"
    #     msg: "Поле должно состоять из латинских символов и цифр"
    #   ,
    #     pattern: "starts-with-word"
    #     msg: "Поле не должно начинаться с цифры"
    #   ]
    #   name:
    #     required: on
    #     msg: "Поле не может быть пустым"

  url: -> "/admin/products/#{ @get( "_id" ) ? "" }"