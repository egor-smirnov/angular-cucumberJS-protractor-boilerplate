'use strict';

/**
 * @namespace Auction.Services
 * @ngdoc service
 * @name TestAppAuctionItem
 * @description
 * # AuctionItem
 * AngularJS factory responsible for representation of auction item
 */

(function () {

    function factoryFn($http, AuctionBidder, AuctionBid) {

        var currentItem = null;

        return {
            getCurrentItem: getCurrentItem,
            getBiddersForCurrentItem: getBiddersForCurrentItem,
            getBidsForCurrentItem: getBidsForCurrentItem,
            placeBidOnCurrentItem: placeBidOnCurrentItem
        };

        function getCurrentItem() {

            if (currentItem) {
                return currentItem;
            }

            return $http.get('items').then(function (result) {

                currentItem = result.data;
                currentItem.placeBidOnCurrentItem = placeBidOnCurrentItem;
                currentItem.getBiddersForCurrentItem = getBiddersForCurrentItem;
                currentItem.getBidsForCurrentItem = getBidsForCurrentItem;

                return result.data;
            });
        }

        function getBiddersForCurrentItem() {

            return AuctionBidder.getAllBiddersForItem(currentItem.id);
        }

        function getBidsForCurrentItem() {

            return AuctionBid.getAllBidsForItem(currentItem.id);
        }

        function placeBidOnCurrentItem(userId) {

            return AuctionBid.placeBidForItem(currentItem.id, userId);
        }
    }

    factoryFn.$inject = ['$http', 'AuctionBidder', 'AuctionBid'];

    module.exports = factoryFn;
})();