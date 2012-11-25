class Witness.views.CategoriesList extends Witness.View

  initialize: ( options, _id ) ->
    @model = new Witness.models.Categories( )

  destroy: ->
    @remove()

  render: ->
    Witness.View::render.apply( @, arguments )

    @pager ?= new Witness.views.CategoriesPager()
    @pager.setElement( @$el.find( ".b-categories__pagination" ) )
    @pager.render( { offset, count } = @model )


  template: "categories-list"