'use strict';

module.exports = (function () {

    angular
        .module('testApp')
        .controller('TestApp.AuctionRoomController', require('./controllers/auctionRoomController'))
        .factory('AuctionItem', require('./models/auctionItem'))
        .factory('AuctionBidder', require('./models/auctionBidder'))
        .factory('AuctionBid', require('./models/auctionBid'));
})();