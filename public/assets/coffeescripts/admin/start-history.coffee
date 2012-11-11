jQuery ->
  $.ajaxSetup
    headers:
      "X-CSRF-Token": $( "meta[name=\"csrf\"]" ).attr( "content" )

  Backbone.history.start()