'use strict'

describe 'TestApp', ->
    describe 'AuctionBid', ->

        auctionBid = null
        httpBackend = null
        successFn = null
        successResponse = null
        errorFn = null
        errorResponse = null
        auctionBidsMock = [
            {time: 1415485860, bidValue: 1000, userId: 1, name: 'Egor Smirnov'}
            {time: 1415485870, bidValue: 1000, userId: 2, name: 'Ivan Ivanov'}
            {time: 1415485880, bidValue: 1000, userId: 3, name: 'John Doe'}
        ]

        beforeEach angular.mock.module 'testApp'

        beforeEach angular.mock.inject (AuctionBid, $httpBackend) ->

            auctionBid = AuctionBid
            httpBackend = $httpBackend

        describe 'Place bid for item', ->

            beforeEach ->

                successFn = (result) ->
                    successResponse = result

                errorFn = (result) ->
                    errorResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionBid = null

            it 'should handle success response correctly', ->

                httpBackend.whenGET('items/10/bids').respond auctionBidsMock

                auctionBid.getAllBidsForItem(10).then successFn

                httpBackend.flush()

                expect(successResponse).to.have.length 3
                expect(successResponse[0]).to.eql auctionBidsMock[0]
                expect(successResponse[1]).to.eql auctionBidsMock[1]
                expect(successResponse[2]).to.eql auctionBidsMock[2]

            it 'should handle error response correctly', ->

                httpBackend.whenGET('items/1/bids').respond 404,
                    message: 'No bids found'

                auctionBid.getAllBidsForItem(1).catch errorFn

                httpBackend.flush()

                expect(errorResponse.data.message).to.equal 'No bids found'
                expect(errorResponse.status).to.equal 404