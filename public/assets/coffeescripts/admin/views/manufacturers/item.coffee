class Witness.views.ManufacturersListItem extends Witness.View

  initialize: ->
    @model.on "destroy", @destroy, @

  options:
    tagName: "li"

  destroy: ->
    @remove()

  change: ( event ) ->
    isChanged = @model.get( "name" ) is val = _.trim ( $ event.currentTarget ).val()

    @$el.find( ".b-save-changes" ).attr "disabled", isChanged or val.length is 0

  del: ->
    @model.destroy()

  save: ( event ) ->
    @model.set "name", ( @$el.find ".b-name-field" ).val()
    @model.save().then =>
      ( @$el.find ".b-save-changes" ).attr "disabled", on

    off

  events:
    "keyup .b-name-field": "change"
    "click .b-remove-item": "del"
    "submit form": "save"

  template: "manufacturers-item"