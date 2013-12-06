define ["Backbone", "./Model"], (Backbone, Model) ->

	Backbone.Collection.extend
		url: "/<%= collectionName %>"
		model: Model
