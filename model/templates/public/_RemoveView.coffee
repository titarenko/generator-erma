define ["Marionette"], (Marionette) ->

	Marionette.ItemView.extend
		template: "#<%= collectionName %>-remove-template"
		triggers:
			"click #remove": "remove"
			"click #cancel": "cancel"
		initialize: ->
			@listenTo @model, "change", @render
