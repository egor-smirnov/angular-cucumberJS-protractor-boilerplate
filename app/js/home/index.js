'use strict';

module.exports = (function () {

    angular
        .module('testApp')
        .controller('TestApp.HomeController', require('./controllers/homeController'));
})();