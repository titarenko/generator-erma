define ["Marionette", "moment"], (Marionette, moment) ->
	
	itemView = Marionette.ItemView.extend
		tagName: "tr"
		template: "#<%= collectionName %>-composite-item-template"

	Marionette.CompositeView.extend
		template: "#<%= collectionName %>-composite-template"
		itemView: itemView
		itemViewContainer: "tbody"
