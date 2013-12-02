define [
	"Marionette"
	"routes"
	"bus"
	"jquery"
	"doT"
], (Marionette, 
	routes,
	bus,
	$,
	doT) ->
	
	app = new Marionette.Application

	# main region of SPA
	app.addRegions
		viewport: "#viewport"

	# wiring doT rendering engine with Marionette
	Marionette.TemplateCache::compileTemplate = doT.template

	# navigation events handling
	app.addInitializer ->
		bus.on "show", (view) -> app.viewport.show view
		bus.on "navigate", (route) -> routes.navigate route

	# jQuery validator configuration (for proper interaction with Twitter Bootstrap form elements)
	app.addInitializer ->
		$.validator.setDefaults
			highlight: (element) ->
				$(element).closest('.control-group').removeClass('success').addClass('error')
			success: (element) ->
    			element.text('OK!').addClass('valid').closest('.control-group').removeClass('error').addClass('success')

	# launch of routing system	
	app.addInitializer ->
		routes.start()

	app
