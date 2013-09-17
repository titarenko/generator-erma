User = require '../../modules/User'
should = require 'should'

describe "User", ->

	beforeEach (done) ->
		User.removeAll done

	describe "#getOrCreateByGoogleId()", ->

		it "should create user if there is no such one", (done) ->
			
			params = 
				googleId: "gooid"
				email: "user@gmail.com"
			
			User.getOrCreateByGoogleId params, (error, user) ->

				should.not.exist error

				user.googleId.should.eql "gooid"
				user.email.should.eql "user@gmail.com"

				User.count (error, count) ->
					count.should.eql 1
					done()

		it "should return user if there is one", (done) ->

			params =
				googleId: "gooid2"
				email: "user2@gmail.com"

			(new User params).save (error) ->
 
				User.getOrCreateByGoogleId params, (error, user) ->
					user.email.should.eql "user2@gmail.com"

					User.count (error, count) ->
						count.should.eql 1
						done()
