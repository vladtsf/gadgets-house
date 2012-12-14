class Witness.View extends Backbone.View

  initialize: ->

  getTemplate: ->
    jade.templates[ @template ? @options?.template ]

  render: ( params ) ->
    @$el.html @getTemplate()?( _.extend( {}, params, @model?.toJSON() ) )

    @