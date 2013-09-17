express = require 'express'
mongoose = require 'mongoose'
require "express-resource"
config = require './config'
Security = require "./modules/Security"
Log = require "./modules/Log"
Resources = require "./modules/Resources"

mongoose.connect config.mongoUrl, (error) ->
	Log.error error if error
	Log.info "Mongoose connected to #{config.mongoUrl}."

app = express()

app.set "view engine", "jade"
app.set "views", __dirname + "/views"

app.use express.bodyParser()
app.use express.cookieParser config.sessionSecret
app.use express.cookieSession()

app.use "/", express.static __dirname + "/build/lib"
app.use "/img", express.static __dirname + "/build/lib"
app.use "/", express.static __dirname + "/build"
app.use "/", express.static __dirname + "/public/images"

Security.for app

app.get "/", (req, res) ->
	if req.isAuthenticated()
		res.redirect "/app"
	else
		res.render "landing"

app.get "/app", (req, res) ->
	if req.isAuthenticated()
		res.render "app"
	else
		res.redirect "/"

for name, implementation of Resources
	Security.protect "/#{name}"
	app.resource name, implementation

app.listen config.port, -> 
	Log.info "Listening on #{config.port}..."
