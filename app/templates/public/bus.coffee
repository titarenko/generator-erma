define [
	"Backbone"
], (Backbone) ->

	# app's message delivery bus 
	bus = {}
	_.extend bus, Backbone.Events
	bus
