class Witness.views.ManufacturersList extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.Manufacturers( )

    @model.on "add", ( model, collection ) =>
      do ( model ) =>
        setTimeout =>
          @$el.find( ".b-list-is-empty" ).hide()
          @$el.find( ".b-manufacturers-list" ).append new Witness.views.ManufacturersListItem( model: model ).render().el

    @model.on "remove", ( model, collection ) =>
      unless collection.length
        @$el.find( ".b-list-is-empty" ).show()


  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

  add: ->
    @model.add new Witness.models.Manufacturer

  events:
    "click .b-add-button": "add"

  template: "manufacturers-list"