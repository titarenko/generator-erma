define ["Marionette"], (Marionette) ->

	Marionette.CompositeView.extend
		template: "#<%= modelName %>-list-template"
		itemViewContainer: "tbody"
		itemView: Marionette.ItemView.extend
			template: "#<%= modelName %>-item-template"
