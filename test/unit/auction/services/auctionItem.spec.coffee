'use strict'

describe 'TestApp', ->
    describe 'AuctionItem', ->

        auctionItem = null
        auctionBidder = null
        auctionBid = null
        httpBackend = null
        successFn = null
        successResponse = null
        errorFn = null
        errorResponse = null
        auctionItemMock = {
            id: 10
            name: 'Cartier Paris, Collection Privée, Pasha de Cartier, 2000'
            picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
            description: 'This magnificent selection of Cartier jewelry, including the white gold ring...'
            currentBid: 20000
            nextBid: 40000
        }

        beforeEach angular.mock.module 'testApp'

        beforeEach angular.mock.inject (AuctionItem, AuctionBidder, AuctionBid, $httpBackend) ->

            auctionItem = AuctionItem
            auctionBidder = AuctionBidder
            auctionBid = AuctionBid
            httpBackend = $httpBackend

        describe 'Get Item', ->

            beforeEach ->

                successFn = (result) ->
                    successResponse = result

                errorFn = (result) ->
                    errorResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionItem = null

            it 'should handle success response correctly', ->

                httpBackend.whenGET('items').respond auctionItemMock

                auctionItem.getCurrentItem().then successFn

                httpBackend.flush()

                expect(successResponse.id).to.equal 10
                expect(successResponse.name).to.equal 'Cartier Paris, Collection Privée, Pasha de Cartier, 2000'
                expect(successResponse.picture).to.equal 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
                expect(successResponse.description).to.equal 'This magnificent selection of Cartier jewelry, including the white gold ring...'
                expect(successResponse.currentBid).to.equal 20000
                expect(successResponse.nextBid).to.equal 40000

            it 'should handle error response correctly', ->

                httpBackend.whenGET('items').respond 404,
                    message: 'No current item found'

                auctionItem.getCurrentItem().catch errorFn

                httpBackend.flush()

                expect(errorResponse.data.message).to.equal 'No current item found'
                expect(errorResponse.status).to.equal 404

            it 'should return cached version of item on subsequent requests', ->

                httpBackend.whenGET('items').respond auctionItemMock

                auctionItem.getCurrentItem().then successFn

                httpBackend.flush()

                expect(successResponse).to.include auctionItemMock
                expect(auctionItem.getCurrentItem()).to.include auctionItemMock

        describe 'Get bidders for item', ->

            beforeEach ->

                httpBackend.whenGET('items').respond auctionItemMock
                httpBackend.whenGET('items/10/bidders').respond []

                successFn = (result) ->
                    successResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionItem = null
                auctionBidder.getAllBiddersForItem.restore()

            it 'should call AuctionBidder factory upon calling of getBiddersForCurrentItem()', ->

                sinon.spy auctionBidder, 'getAllBiddersForItem'

                auctionItem.getCurrentItem().then successFn

                httpBackend.flush()

                auctionItem.getBiddersForCurrentItem()

                httpBackend.flush()

                expect(auctionBidder.getAllBiddersForItem.withArgs(10).calledOnce).to.be.true

        describe 'Get bids for item', ->

            beforeEach ->

                httpBackend.whenGET('items').respond auctionItemMock
                httpBackend.whenGET('items/10/bids').respond []

                successFn = (result) ->
                    successResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionItem = null
                auctionBid.getAllBidsForItem.restore()

            it 'should call AuctionBid factory upon calling of getBidsForCurrentItem()', ->

                sinon.spy auctionBid, 'getAllBidsForItem'

                auctionItem.getCurrentItem().then successFn

                httpBackend.flush()

                auctionItem.getBidsForCurrentItem()

                httpBackend.flush()

                expect(auctionBid.getAllBidsForItem.withArgs(10).calledOnce).to.be.true

        describe 'Place bid for item', ->

            beforeEach ->

                httpBackend.whenGET('items').respond auctionItemMock
                httpBackend.whenPOST('items/10/bids', {userId: 1}).respond
                    success: true

                successFn = (result) ->
                    successResponse = result

            afterEach ->

                httpBackend.verifyNoOutstandingExpectation()
                httpBackend.verifyNoOutstandingRequest()

                auctionItem = null
                auctionBid.placeBidForItem.restore()

            it 'should call AuctionBid factory upon calling of placeBidOnCurrentItem()', ->

                sinon.spy auctionBid, 'placeBidForItem'

                auctionItem.getCurrentItem().then successFn

                httpBackend.flush()

                auctionItem.placeBidOnCurrentItem(1)

                httpBackend.flush()

                expect(auctionBid.placeBidForItem.withArgs(10, 1).calledOnce).to.be.true