passport = require 'passport'
User = require './User'
GoogleStrategy = require("passport-google-oauth").OAuth2Strategy
config = require "../config"

passport.serializeUser (user, done) ->
	done null, user?._id?.toString()

passport.deserializeUser (id, done) ->
	done null, new User _id: id

guard = (req, res, next) ->
	if req.isAuthenticated()
		next()
	else
		res.statusCode = 403
		res.end()

module.exports = class Security

	@for: (expressApp) ->
		@app = expressApp

		@app.use passport.initialize()
		@app.use passport.session()
		
		passport.use new GoogleStrategy
			clientID: config.googleAppId
			clientSecret: config.googleAppSecret
			callbackURL: config.googleAppRedirect,
			(accessToken, refreshToken, profile, done) ->
				User.getOrCreateByGoogleId
					googleId: profile._json.id 
					email: profile._json.email,
					done
		
		authenticate = passport.authenticate "google",
			successRedirect: '/app'
			failureRedirect: '/'
			scope: ['https://www.googleapis.com/auth/userinfo.email']

		@app.get "/login/google", authenticate

		@app.get config.googleRedirectRoute, passport.authenticate("google"), (req, res) ->
			res.redirect "/app"

		@app.get "/logout", (req, res) ->
			req.logout()
			res.redirect "/"

	@protect: (path) -> 
		@app.all path, guard
