mongoose = require 'mongoose'

before ->
	connectionString = process.env.CONNECTION_STRING or "mongodb://localhost/<%= name %>-test"
	mongoose.connect connectionString

after ->
	mongoose.connection.close()
