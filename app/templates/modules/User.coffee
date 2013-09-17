mongoose = require 'mongoose'

OID = mongoose.Schema.Types.ObjectId

userSchema = mongoose.Schema
	email: String
	googleId: String
	registeredAt: 
		type: Date
		default: -> new Date
	lastSeenAt: Date
	ips: [String]

userSchema.statics.getOrCreateByGoogleId = (params, done) ->
	query = googleId: params.googleId
	options = upsert: true, "new": true
	sort = {}
	update = $set: 
		googleId: params.googleId
		email: params.email
	@collection.findAndModify query, sort, update, options, done

userSchema.statics.removeAll = (done) ->
	@collection.remove {}, {w: 0}, done

userSchema.methods.touch = (id, ip, done) ->
	update =
		$set: lastSeenAt: new Date()
		$addToSet: ips: ip
	@collection.update {_id: id}, update, {safe: true}, done

module.exports = mongoose.model "users", userSchema
