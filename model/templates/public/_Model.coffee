define ["Backbone"], (Backbone) ->

	Backbone.Model.extend
		urlRoot: "/<%= collectionName %>"
