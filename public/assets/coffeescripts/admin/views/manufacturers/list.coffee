class Witness.views.ManufacturersList extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.Manufacturers( )

    @model.on "add", ( model, collection ) =>
      do ( model ) =>
        setTimeout =>
          @$el.find( ".b-manufacturers-list" ).append new Witness.views.ManufacturersListItem( model: model ).render().el

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

  add: ->
    @model.add new Witness.models.Manufacturer

  events:
    "click .b-add-button": "add"

    # $holder = @$el.find( ".b-manufacturers-list" )

    # for own model in @model.models


    # @pager ?= new Witness.views.CategoriesPager()
    # @pager.setElement( @$el.find( ".b-categories__pagination" ) )
    # @pager.render( { offset, count } = @model )


  template: "manufacturers-list"