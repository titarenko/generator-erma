define [
	"Backbone"
	"Marionette"
], (Backbone, 
	Marionette) ->

	###
	Defines a collection of routes for given controller.
	###
	RouteCollection: class RouteCollection
		
		###
		Constructs route collection instance.

		Arguments:

			appRoutes - hash of routes, for example 

				"route-name": url: "route-url", action: "controllerAction"
				"route-name-2": 
					url: "route-url-2", 
					action: "controllerAction2", 
					arg1: "arg1", 
					arg2: 10

			controller - instance of controller
		###
		constructor: ({@appRoutes, @controller}) ->
			Router = Marionette.AppRouter.extend
				appRoutes: @_getAppRoutes()
				controller: @_getController()
			@router = new Router

		###
		Navigates to given url.
		###
		navigate: (url) ->
			@router.navigate url, trigger: true

		_getAppRoutes: ->
			result = {}
			for name, route of @appRoutes when @appRoutes.hasOwnProperty name
				result[route.url] = route.action
			result

		_getController: ->
			result = {}
			for name, method of @controller # when @controller.hasOwnProperty name
				decorate = =>
					methodBody = method 
					result[name] = =>
						cleanArguments = Array::map.call arguments, (argument) ->
							if argument == "?" then null else argument
						methodBody.apply @controller, cleanArguments
				decorate()
			result

	###
	Defines route table.
	###
	RouteTable: class RouteTable

		###
		Constructs route table instance.

		Arguments:

			routes - array of RouteCollection instances
		###
		constructor: (@routes) ->
		
		###
		Starts routing mechanism (which watches current URL for hash changes).
		###
		start: ->
			Backbone.history.start()

		###
		Launches appropriate controller action using given route and parameters.
		###
		navigate: (name, parameters) ->
			parameters = {} unless parameters
			for router in @routes 
				route = router.appRoutes[name]
				return @_follow route, parameters if route

		_follow: (route, parameters) ->
			url = route.url
			@_extend parameters, route
			for name, value of parameters when parameters.hasOwnProperty name
				url = url.replace ":#{name}", value or "?"
			@routes[0].navigate url

		_extend: (base, source) ->
			for name, value of source when source.hasOwnProperty name
				base[name] = value unless base[name]
			base 
