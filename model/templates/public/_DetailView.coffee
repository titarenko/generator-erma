define ["Marionette"], (Marionette) ->

	Marionette.ItemView.extend
		template: "#<%= collectionName %>-detail-template"
		initialize: ->
			@listenTo @model, "change", @render
