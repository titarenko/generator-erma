Log = require "../Log"

extend = (target) ->
	sources = Array::slice.call arguments, 1
	for source in sources
		for name, value of source when source.hasOwnProperty name
			target[name] = value
	target

getParams = (logic, req, done) ->
	switch logic.length
		when 1
			[done]
		when 2
			[req.user._id, done]
		when 3
			[req.user._id, extend(req.query, req.body, req.params), done]

handler = (logic) ->
	(req, res) ->
		logic.apply @, getParams logic, req, (error, result) ->
			if error
				Log.error JSON.stringify ip: req.connection.remoteAddress, error: error
				res.statusCode = 500
				res.end error
			else
				res.json result

module.exports = handler
