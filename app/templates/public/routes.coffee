define [
	"routing"
	"home/Controller"
], (routing, 
	HomeController) ->

	new routing.RouteTable [
		new routing.RouteCollection
			appRoutes:
				"root": url: "", action: "showIndex"
			controller: new HomeController
	]
