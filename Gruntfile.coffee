module.exports = (grunt) ->

	grunt.initConfig

		watch:
			coffee:
				files: "public/**/*.coffee"
				tasks: ["coffee", "requirejs"]
			css:
				files: ["public/**/*.css", "build/lib/**/*.css"]
				tasks: ["cssmin", "copy"]

		"curl-dir":
			"build/lib": [

				"http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.2/jquery.js"
				"http://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"

				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0-rc2/css/bootstrap.css"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0-rc2/js/bootstrap.js"

				"http://raw.github.com/olado/doT/master/doT.js"
				
				"http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.5/require.js"
				
				"http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore.js"
				"http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone.js"
				"http://cdnjs.cloudflare.com/ajax/libs/backbone.marionette/1.0.1-bundled/backbone.marionette.js"

				"http://fgnass.github.io/spin.js/dist/spin.js"

				"http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.0.0/moment.js"
				
				"http://cdnjs.cloudflare.com/ajax/libs/highcharts/3.0.2/highcharts.src.js"
				"http://cdnjs.cloudflare.com/ajax/libs/linq.js/2.2.0.2/linq.js"

			]

		coffee:
			target:
				options:
					bare: true
				files: [
					expand: true
					cwd: "public"
					src: ["**/*.coffee"]
					dest: "build"
					ext: ".js"
				]

		cssmin:
			styles:
				files:
					"build/style.css": ["public/**/*.css", "build/lib/**/*.css", "!public/landing.css"]

		requirejs:
			compile:
				options:
					name: "main"
					optimize: "none"
					baseUrl: "build"
					mainConfigFile: "build/main.js"
					out: "build/script.js"

	grunt.loadNpmTasks "grunt-curl"
	grunt.loadNpmTasks "grunt-contrib-cssmin"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"

	grunt.registerTask "copy", "Copies landing.css.", ->
		grunt.file.copy "public/landing.css", "build/landing.css"

	grunt.registerTask "install", ["curl-dir"]
	grunt.registerTask "build", ["cssmin", "copy", "coffee", "requirejs"]
	grunt.registerTask "start", "watch"
	grunt.registerTask "default", ["start"]
