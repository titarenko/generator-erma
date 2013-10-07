define ["Backbone"], (Backbone) ->

	Backbone.Collection.extend
		url: "/<%= collectionName %>"
