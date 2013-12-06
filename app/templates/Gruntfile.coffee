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

				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/css/bootstrap-theme.css"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/css/bootstrap.css"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/fonts/glyphicons-halflings-regular.eot"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/fonts/glyphicons-halflings-regular.svg"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/fonts/glyphicons-halflings-regular.ttf"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/fonts/glyphicons-halflings-regular.woff"
				"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.2/js/bootstrap.js"

				"http://cdnjs.cloudflare.com/ajax/libs/animate.css/3.0.0/animate.min.css"

				"http://raw.github.com/olado/doT/master/doT.js"
				
				"http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.5/require.js"
				
				"http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore.js"
				"http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone.js"
				"http://cdnjs.cloudflare.com/ajax/libs/backbone.validation/0.8.2/backbone-validation.js"
				"http://cdnjs.cloudflare.com/ajax/libs/backbone.marionette/1.0.1-bundled/backbone.marionette.js"

				"http://fgnass.github.io/spin.js/dist/spin.js"

				"http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.0.0/moment.js"

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

	grunt.registerTask "copy", "Copies landing.css to public folder.", ->
		grunt.file.copy "public/landing.css", "build/landing.css"

	grunt.registerTask "install", ["curl-dir"]
	grunt.registerTask "build", ["cssmin", "copy", "coffee", "requirejs"]
	grunt.registerTask "start", "watch"
	grunt.registerTask "default", ["start"]
