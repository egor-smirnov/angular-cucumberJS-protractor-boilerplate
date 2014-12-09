'use strict'

describe 'TestApp', ->
    describe 'AuctionRoomController', ->

        controller = null
        scope = null

        currentAuctionItemMock = null

        auctionBiddersMock = [
            {userId: 1, name: 'Egor Smirnov'}
        ]

        beforeEach angular.mock.module 'testApp', ($provide) ->
            $provide.value 'CURRENT_USER',
                id: 1,
                name: 'Egor Smirnov'

            return

        beforeEach angular.mock.inject ($controller, $rootScope, $q) ->

            # currentActionItemMock is mocked controller resolve

            currentAuctionItemMock = {
                id: 10
                name: 'Cartier Paris, Collection Privée, Pasha de Cartier, 2000'
                picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
                description: 'This magnificent selection of Cartier jewelry, including the white gold ring...'
                currentBid: 20000
                nextBid: 40000
                placeBidOnCurrentItem: () ->
                    $q.when {}
                getBiddersForCurrentItem: () ->
                    $q.when auctionBiddersMock
            }

            scope = $rootScope.$new()
            controller = $controller 'TestApp.AuctionRoomController', {
                $scope: scope,
                currentAuctionItem: currentAuctionItemMock
            }

        it 'should have correctly resolved promise (with auctionItems) upon creation of controller', ->

            expect(controller.currentAuctionItem).to.eql currentAuctionItemMock

        it 'should have empty currentBidders upon creation of controller', ->

            expect(controller.currentBidders).to.eql []

        it 'should have null highestBidder upon creation of controller', ->

            expect(controller.highestBidder).to.be.null

        it 'should return item bidders upon placing the new bid', ->

            controller.placeBidOnCurrentItem()

            scope.$digest()

            expect(controller.currentBidders).to.eql auctionBiddersMock

        describe 'Only one bidder per bid step', ->

            beforeEach angular.mock.inject ($controller, $rootScope, $q) ->

                # currentActionItemMock is mocked controller resolve

                currentAuctionItemMock = {
                    # all other fields are not important for this case
                    placeBidOnCurrentItem: () ->
                        $q.when {}
                    getBiddersForCurrentItem: () ->
                        $q.when auctionBiddersMock
                }

                scope = $rootScope.$new()
                controller = $controller 'TestApp.AuctionRoomController', {
                    $scope: scope,
                    currentAuctionItem: currentAuctionItemMock
                }

            it 'should set highest bidder as user with id 1', ->

                controller.placeBidOnCurrentItem()

                scope.$digest()

                expect(controller.currentBidders).to.eql [{userId: 1, name: 'Egor Smirnov'}]
                expect(controller.highestBidder.userId).to.equal 1
                expect(controller.highestBidder.name).to.equal 'Egor Smirnov'

        describe 'Multiple bidders per bid step', ->

            beforeEach angular.mock.inject ($controller, $rootScope, $q) ->

                # currentActionItemMock is mocked controller resolve

                currentAuctionItemMock = {
                    # all other fields are not important for this case
                    placeBidOnCurrentItem: () ->
                        $q.when {}
                    getBiddersForCurrentItem: () ->
                        $q.when [
                            {userId: 1, name: 'Egor Smirnov'}
                            {userId: 2, name: 'Ivan Ivanov'}
                            {userId: 3, name: 'John Doe'}
                        ]
                    getBidsForCurrentItem: () ->
                        $q.when [
                            {time: 1415485860, bidValue: 1000, userId: 2, name: 'Ivan Ivanov'}
                            {time: 1415485870, bidValue: 1000, userId: 1, name: 'Egor Smirnov'}
                            {time: 1415485880, bidValue: 1000, userId: 3, name: 'John Doe'}
                        ]
                }

                scope = $rootScope.$new()
                controller = $controller 'TestApp.AuctionRoomController', {
                    $scope: scope,
                    currentAuctionItem: currentAuctionItemMock
                }

            it 'should set highest bidder as user with id 2', ->

                controller.placeBidOnCurrentItem()

                scope.$digest()

                expect(controller.currentBidders).to.eql [
                    {userId: 1, name: 'Egor Smirnov'}
                    {userId: 2, name: 'Ivan Ivanov'}
                    {userId: 3, name: 'John Doe'}
                ]
                expect(controller.highestBidder.userId).to.equal 2
                expect(controller.highestBidder.name).to.equal 'Ivan Ivanov'