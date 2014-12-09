'use strict';

(function () {

    module.exports = ['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {

        /**
         * @namespace Config.Routes
         * @ngdoc overview
         * @name testAppRoutes
         * @description
         * # testApp Routes
         * Defines routes used for application
         */

        $urlRouterProvider.otherwise('/');

        $stateProvider.state('home', {
            url: '/',
            templateUrl: 'app/partials/home.html',
            controller: 'TestApp.HomeController',
            controllerAs: 'vm'
        });

        $stateProvider.state('auction-room', {
            url: '/auction-room',
            templateUrl: 'app/partials/auction-room.html',
            controller: 'TestApp.AuctionRoomController',
            controllerAs: 'vm',
            resolve: {
                currentAuctionItem: ['AuctionItem', function (AuctionItem) {
                    return AuctionItem.getCurrentItem();
                }]
            }
        });
    }];
})();