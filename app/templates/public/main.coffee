require.config
	
	paths:

		jquery: "lib/jquery"
		validate: "lib/jquery.validate"
		
		bootstrap: "lib/bootstrap"

		doT: "lib/doT"
		
		underscore: "lib/underscore"
		Backbone: "lib/backbone"
		Marionette: "lib/backbone.marionette"

		Spin: "lib/spin"
		
		moment: "lib/moment"
		highcharts: "lib/highcharts.src"

		linq: "lib/linq"

		datepicker: "lib/bootstrap-datepicker"
		tagsinput: "lib/jquery.tagsinput"

		autoNumeric: "lib/autoNumeric"

		crypt: "lib/sjcl"

	shim:

		jquery: exports: "$"
		underscore: exports: "_"
		validate: deps: ["jquery"]
		bootstrap: deps: ["jquery"]
		Marionette: 
			deps: ["Backbone"]
			exports: "Marionette"
		Backbone: 
			deps: ["underscore", "jquery"]
			exports: "Backbone"
		datepicker: deps: ["bootstrap", "jquery"]
		tagsinput: deps: ["jquery"]
		moment: exports: "moment"
		autoNumeric: deps: ["jquery"]
		crypt: exports: "sjcl"

require [
], (app) ->
	
	app.start()
