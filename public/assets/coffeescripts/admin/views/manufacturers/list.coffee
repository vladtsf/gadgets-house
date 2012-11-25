class Witness.views.ManufacturersList extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.Manufacturers( )

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

    # @pager ?= new Witness.views.CategoriesPager()
    # @pager.setElement( @$el.find( ".b-categories__pagination" ) )
    # @pager.render( { offset, count } = @model )


  template: "manufacturers-list"