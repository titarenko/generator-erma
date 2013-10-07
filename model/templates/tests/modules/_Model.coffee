should = require "should"

describe "<%= modelClassName %>", ->

	describe "#save()", ->

		it "should persist model", (done) ->

			model = new <%= modelName %> <% for (var index in properties) { %>
				<%= properties[index] %>: "<%= properties[index] %>" <% } %>

			model.save (error) ->
				should.not.exist error
				model.findById model._id, (error, result) ->
					should.not.exist error <% for (var index in properties) { %>
					result.<%= properties[index] %>.should.eql "<%= properties[index] %>" <% } %>
					done()
