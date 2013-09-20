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

	describe "#touch()", ->

		it "should update last visit time as well as collection of user IPs", (done) ->

			params =
				googleId: "id"
				email: "id@gmail.com"

			User.getOrCreateByGoogleId params, (error, user) ->
				User.touch user._id, "127.0.0.1", (error) ->
					User.findOne {_id: user._id}, (error, user) ->

						should.not.exist error

						user.lastSeenAt.should.eql new Date()

						user.ips.should.have.lengthOf 1
						user.ips[0].should.eql "127.0.0.1"

						done()

		it "should not duplicate existing IPs", (done) ->

			params =
				googleId: "id"
				email: "id@gmail.com"

			User.getOrCreateByGoogleId params, (error, user) ->
				User.touch user._id, "127.0.0.1", (error) ->
					User.touch user._id, "192.168.0.1", (error) ->
						User.touch user._id, "127.0.0.1", (error) ->
							User.findOne {_id: user._id}, (error, user) ->

								should.not.exist error

								user.ips.should.have.lengthOf 2
								user.ips.should.include "127.0.0.1"
								user.ips.should.include "192.168.0.1"
								
								done()
