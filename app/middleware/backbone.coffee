backbone    = require( "backbone" )
_           = require( "underscore" )
validation  = require( "backbone-validation" )

_.extend( backbone.Model.prototype, validation.mixin )

module.exports = backbone