'use strict'

describe 'TestApp', ->
    describe 'AuctionBidder', ->

        auctionBidder = null
        httpBackend = null
        successFn = null
        successResponse = null
        errorFn = null
        errorResponse = null
        auctionBiddersMock = [
            {userId: 1, name: 'Egor Smirnov'}
            {userId: 2, name: 'Ivan Ivanov'}
            {userId: 3, name: 'John Doe'}
        ]

        beforeEach angular.mock.module 'testApp'

        beforeEach angular.mock.inject (AuctionBidder, $httpBackend) ->

            auctionBidder = AuctionBidder
            httpBackend = $httpBackend

        describe 'Get Bidders', ->

            beforeEach ->

                successFn = (result) ->
                    successResponse = result

                errorFn = (result) ->
                    errorResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionBidder = null

            it 'should handle success response correctly', ->

                httpBackend.whenGET('items/10/bidders').respond auctionBiddersMock

                auctionBidder.getAllBiddersForItem(10).then successFn

                httpBackend.flush()

                expect(successResponse).to.have.length 3
                expect(successResponse[0]).to.eql auctionBiddersMock[0]
                expect(successResponse[1]).to.eql auctionBiddersMock[1]
                expect(successResponse[2]).to.eql auctionBiddersMock[2]

            it 'should handle error response correctly', ->

                httpBackend.whenGET('items/10/bidders').respond 404,
                    message: 'No bidders found'

                auctionBidder.getAllBiddersForItem(10).catch errorFn

                httpBackend.flush()

                expect(errorResponse.data.message).to.equal 'No bidders found'
                expect(errorResponse.status).to.equal 404