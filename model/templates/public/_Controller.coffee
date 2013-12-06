define [
	"./Collection"
	"./Model"
	"./ListView"
	"./DetailView"
	"./EditorView"
	"./RemoveView"
	"bus"], (Collection, Model, ListView, DetailView, EditorView, RemoveView, bus) ->

	class Controller

		show: (id) ->
			model = if id? then new Model id: id else new Collection
			view = if id? then new DetailView model: model else new ListView collection: model 
			bus.trigger "show", view
			model.fetch cache: false

		edit: (id) ->
			model = new Model id: id
			view = new EditorView model: model
			view.on "save", ->
				model.save {}, success: ->
					bus.trigger "navigate", "<%= collectionName %>"
			view.on "cancel", ->
				bus.trigger "navigate", "<%= collectionName %>"
			bus.trigger "show", view
			model.fetch cache: false if id?

		remove: (id) ->
			model = new Model id: id
			view = new RemoveView model: model
			view.on "cancel", ->
				bus.trigger "navigate", "<%= collectionName %>"
			view.on "remove", ->
				model.destroy success: ->
					bus.trigger "navigate", "<%= collectionName %>"
			bus.trigger "show", view
			model.fetch cache: false
