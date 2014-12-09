'use strict'

describe 'TestApp', ->
    describe 'HomeController', ->

        controller = null
        scope = null

        beforeEach angular.mock.module 'testApp'

        beforeEach angular.mock.inject ($controller, $rootScope) ->

            scope = $rootScope.$new()
            controller = $controller 'TestApp.HomeController', {
                $scope: scope
            }

        it 'should have correct greetings scope variable', ->

            expect(controller.greetings).to.equal 'hello'