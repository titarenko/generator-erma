handler = require "./handler"
User = require "../models/User"

module.exports =
	index: handler (user, done) ->
		if user.isAdmin
			User.findAll done
		else
			done null, []
