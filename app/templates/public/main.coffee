require.config
	
	paths:

		jquery: "lib/jquery"
		
		bootstrap: "lib/bootstrap"

		doT: "lib/doT"
		
		underscore: "lib/underscore"
		Backbone: "lib/backbone"
		Validation: "lib/backbone-validation"
		Marionette: "lib/backbone.marionette"

		Spin: "lib/spin"
		
		moment: "lib/moment"
		highcharts: "lib/highcharts.src"
		d3: "lib/d3"

		linq: "lib/linq"

		datepicker: "lib/bootstrap-datepicker"
		tagsinput: "lib/jquery.tagsinput"

		autoNumeric: "lib/autoNumeric"

	shim:

		jquery: exports: "$"
		underscore: exports: "_"
		bootstrap: deps: ["jquery"]
		Marionette: 
			deps: ["Backbone"]
			exports: "Marionette"
		Backbone: 
			deps: ["underscore", "jquery"]
			exports: "Backbone"
		Validation: deps: ["Backbone"]
		datepicker: deps: ["bootstrap", "jquery"]
		tagsinput: deps: ["jquery"]
		moment: exports: "moment"
		d3: exports: "d3"
		autoNumeric: deps: ["jquery"]

require [
	"app"
], (app) ->
	
	app.start()
