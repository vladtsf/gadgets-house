class Witness.views.ProductsList extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.Products( )

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

    @pager ?= new Witness.views.ProductsPager()
    @pager.setElement( @$el.find( ".b-products__pagination" ) )
    @pager.render( { offset, count } = @model )

  template: "products-list"