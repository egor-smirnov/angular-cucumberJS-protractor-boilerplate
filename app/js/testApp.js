(function () {

    'use strict';
    /**
     * @ngdoc overview
     * @name testApp
     * @description
     * # testApp
     * Main module for test application
     */

    angular
        .module('testApp', ['ui.router'])
        .config(require('./config/routes'))
        .value('CURRENT_USER', {
            id: 1,
            name: 'Egor Smirnov'
        });

    require('./home');
    require('./auction');
})();