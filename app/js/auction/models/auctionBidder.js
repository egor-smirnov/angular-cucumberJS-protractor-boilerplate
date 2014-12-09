'use strict';

/**
 * @namespace Auction.Services
 * @ngdoc service
 * @name TestAppAuctionBidder
 * @description
 * # AuctionBidder
 * AngularJS factory responsible for representation of bidder for auction item
 */

(function () {

    function factoryFn($http) {

        return {
            getAllBiddersForItem: getAllBiddersForItem
        };

        function getAllBiddersForItem(itemId) {

            return $http.get('items/' + itemId + '/bidders').then(function (result) {
                return result.data;
            });
        }
    }

    factoryFn.$inject = ['$http'];

    module.exports = factoryFn;
})();