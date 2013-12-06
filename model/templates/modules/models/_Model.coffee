mongoose = require "mongoose"

OID = mongoose.Schema.Types.ObjectId

<%= modelName %>Schema = mongoose.Schema
	user: OID
	<% for (var p in properties) { %>
	<%= properties[p].name %>:
		type: String
		required: true
	<% } %>

<%= modelName %>Schema.statics.removeAll = (done) ->
	@collection.remove {}, {w: 0}, done

<%= modelName %>Schema.statics.getAll = (user, pageIndex, pageSize, done) ->
	@find(user: user)
		.skip(pageSize*pageIndex)
		.limit(pageSize)
		.exec done

<%= modelName %>Schema.statics.findById = (user, id, done) ->
	@findOne(user: user, _id: id).exec done

<%= modelName %>Schema.statics.updateById = (user, id, data, done) ->
	query = user: user, _id: id
	update =
		<% for (var p in properties) { %>
		<%= properties[p].name %>: data.<%= properties[p].name %>
		<% } %> 
	@update query, update, done

<%= modelName %>Schema.statics.removeById = (user, id, done) ->
	query = user: user, _id: id
	@remove query, done
		
module.exports = mongoose.model "<%= collectionName %>", <%= modelName %>Schema
