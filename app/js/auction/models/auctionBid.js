'use strict';

/**
 * @namespace Auction.Services
 * @ngdoc service
 * @name TestAppAuctionBid
 * @description
 * # AuctionBid
 * AngularJS factory responsible for representation of bids for auction item
 */

(function () {

    function factoryFn($http) {

        return {
            placeBidForItem: placeBidForItem,
            getAllBidsForItem: getAllBidsForItem
        };

        function placeBidForItem(itemId, userId) {

            return $http.post('items/' + itemId + '/bids', {userId: userId}).then(function (result) {
                return result.data;
            });
        }

        function getAllBidsForItem(itemId) {

            return $http.get('items/' + itemId + '/bids').then(function (result) {
                return result.data;
            });
        }
    }

    factoryFn.$inject = ['$http'];

    module.exports = factoryFn;
})();