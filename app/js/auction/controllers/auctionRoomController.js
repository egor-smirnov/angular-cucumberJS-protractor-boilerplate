'use strict';

/**
 * @namespace Auction.Controller
 * @ngdoc service
 * @name TestAppAuctionRoomController
 * @description
 * # AuctionRoomController
 * Controller responsible for showing current auction item picture / name etc. and controls for bidding
 */

(function () {

    function controllerFn(currentAuctionItem, CURRENT_USER) {

        var vm = this;

        vm.currentAuctionItem = currentAuctionItem;
        vm.currentBidders = [];
        vm.highestBidder = null;

        vm.placeBidOnCurrentItem = placeBidOnCurrentItem;

        function placeBidOnCurrentItem() {

            currentAuctionItem
                .placeBidOnCurrentItem(CURRENT_USER.id)
                .then(getAllBiddersForCurrentItemFn)
                .then(defineHighestBidderAndSetBids);
        }

        function getAllBiddersForCurrentItemFn() {

            return currentAuctionItem
                .getBiddersForCurrentItem()
                .then(function (bidders) {
                    vm.currentBidders = bidders;
                    return bidders;
                });
        }

        function defineHighestBidderAndSetBids(bidders) {

            // istanbul ignore else

            if (angular.isArray(bidders)) {

                // in case we have only one bidder, this is the highest bidder for current bid step, otherwise - do request

                if (bidders.length == 1) {

                    vm.highestBidder = bidders[0];
                    vm.currentBids = [
                        {userId: CURRENT_USER.id, name: CURRENT_USER.name}
                    ];

                } else {

                    currentAuctionItem
                        .getBidsForCurrentItem()
                        .then(function (bids) {

                            vm.highestBidder = {
                                userId: bids[0].userId,
                                name: bids[0].name
                            };
                            vm.currentBids = bids;
                        });
                }
            }
        }
    }

    controllerFn.$inject = ['currentAuctionItem', 'CURRENT_USER'];

    module.exports = controllerFn;
})();