mongoose = require "mongoose"

<%= modelName %>Schema = mongoose.Schema <% for (var index in properties) { %>
	<%= properties[index] %>: String <% } %>

<%= modelName %>Schema.statics.removeAll = (done) ->
	@collection.remove {}, {w: 0}, done

module.exports = mongoose.model "<%= collectionName %>", <%= modelName %>Schema
