define ["../routing"], (routing) ->

	new routing.RouteCollection
		appRoutes:
			"home": url: "", action: "show"
			"<%= collectionName %>": url: "<%= collectionName %>", action: "show"
			"<%= collectionName %>-new": url: "<%= collectionName %>/new", action: "edit"
			"<%= collectionName %>-edit": url: "<%= collectionName %>/edit/:id", action: "edit"
			"<%= collectionName %>-show": url: "<%= collectionName %>/show/:id", action: "show"
			"<%= collectionName %>-remove": url: "<%= collectionName %>/remove/:id", action: "remove"
		controller: new <%= collectionClassName %>Controller
