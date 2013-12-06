define ["Marionette", "Validation"], (Marionette) ->

	Marionette.ItemView.extend
		template: "#<%= collectionName %>-editor-template"
		ui:
			<% for (var p in properties) { %>
			<%= properties[p].name %>: "#<%= properties[p].name %>"
			<% } %>
			editor: "#<%= collectionName %>-editor"
		events:
			"click #save": "save"
		triggers:
			"click #cancel": "cancel"
		initialize: ->
			Backbone.Validation.bind @, Backbone.Validation.callbacks
			@listenTo @model, "change", @render
		save: (ev) ->
			ev.preventDefault()
			@model.set
				<% for (var p in properties) { %>
				<%= properties[p].name %>: @ui.<%= properties[p].name %>.val()
				<% } %>
			@trigger "save" if @model.isValid true
		remove: ->
			Backbone.Validation.unbind @
			Backbone.View::remove.apply @, arguments
