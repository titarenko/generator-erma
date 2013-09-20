mongoose = require 'mongoose'
sinon = require 'sinon'

clock = null

before ->
	connectionString = process.env.CONNECTION_STRING or "mongodb://localhost/<%= name %>-test"
	mongoose.connect connectionString
	clock = sinon.useFakeTimers()

after ->
	mongoose.connection.close()
	clock.restore()
