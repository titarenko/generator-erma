handler = require "./handler"
<%= modelClassName %> = require "../models/<%= modelClassName %>"

module.exports = 
	index: handler (user, done) ->
		<%= modelClassName %>.getAll user, 0, 10, done

	show: handler (user, params, done) ->
		<%= modelClassName %>.findById user, params.<%= modelName %>, done

	create: handler (user, params, done) ->
		model = new <%= modelClassName %> 
			user: user
			<% for (var p in properties) { %>
			<%= properties[p].name %>: params.<%= properties[p].name %>
			<% } %>
		model.save done

	update: handler (user, params, done) ->
		<%= modelClassName %>.updateById user, params.<%= modelName %>, params, done

	destroy: handler (user, params, done) ->
		<%= modelClassName %>.removeById user, params.<%= modelName %>, done
