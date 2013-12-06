define ["Backbone", "Validation"], (Backbone) ->

	Backbone.Model.extend
		urlRoot: "/<%= collectionName %>"
		defaults:
			<% for (var p in properties) { %>
			<%= properties[p].name %>: ''
			<% } %>
		validation:
			<% for (var p in properties) { %>
			<%= properties[p].name %>:
				required: true
			<% } %>
