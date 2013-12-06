define [
	"Marionette"
	"routes"
	"bus"
	"jquery"
	"doT"
	"Validation"
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

	# animation for region content change event
	Marionette.Region::open = (view) ->
		openClass = "fadeInLeft animated"
		animationEndEvent = "webkitAnimationEnd onAnimationEnd"
		@$el
			.html(view.el)
			.addClass(openClass)
			.one(animationEndEvent, => @$el.removeClass(openClass))

	# validation errors display mechanism for Bootstrap
	Backbone.Validation.callbacks =
		valid: (view, attr, selector) ->
			$el = view.$('[name=' + attr + ']')
			$group = $el.closest('.form-group')

			$group.removeClass('has-error')
			$group.find('.help-block').html('').addClass('hidden')

		invalid: (view, attr, error, selector) ->
			$el = view.$('[name=' + attr + ']')
			$group = $el.closest('.form-group')

			$group.addClass('has-error')
			attentionSeeker = "shake animated"
			$group
				.find('.help-block')
				.html(error)
				.removeClass("hidden")
				.addClass(attentionSeeker)
				.one("webkitAnimationEnd onAnimationEnd", -> $group.find(".help-block").removeClass(attentionSeeker))

	# navigation events handling
	app.addInitializer ->
		bus.on "show", (view) -> app.viewport.show view
		bus.on "navigate", (route) -> routes.navigate route

	# launch of routing system	
	app.addInitializer ->
		routes.start()

	app
