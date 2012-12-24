class Witness.View extends Backbone.View

  initialize: ->

  getTemplate: ( template ) ->
    jade.templates[ template ? @template ? @options?.template ]

  render: ( params ) ->
    @$el.html @getTemplate()?( _.extend( {}, params, @model?.toJSON() ) )

    @