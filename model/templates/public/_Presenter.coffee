define [
	"bus"
	"Collection"
	"Model"
	"CollectionView"
	"EditorView"
	"DisplayView"
], (bus, Collection, Model, CollectionView, EditorView, DisplayView) ->

	class <%= modelName %>Presenter

		create: ->
			model = new Model
			view = new EditorView model: model
			bus.trigger "show", view

		index: ->
			collection = new Collection
			view = new CollectionView collection: collection
			collection.fetch()
			bus.trigger "show", view

		show: (id) ->
			model = new Model id: id
			view = new DisplayView model: model
			model.fetch()
			bus.trigger "show", view			

		edit: (id) ->
			model = new Model id: id
			view = new EditorView model: model
			model.fetch()
			bus.trigger "show", view
