module.exports = (config) ->

    config.set
        basePath: '../'
        browsers: ['PhantomJS']
        frameworks: [
            'mocha'
            'chai'
            'sinon'
            'browserify'
        ]
        files: [
            'node_modules/angular/angular.js'
            'node_modules/angular-mocks/angular-mocks.js'
            'node_modules/angular-ui-router/release/angular-ui-router.js'
            'app/js/testApp.js'
            'test/unit/**/**/*.coffee'
        ]
        preprocessors:
            'app/js/testApp.js': ['browserify']
            'test/unit/**/**/*.coffee': ['browserify']
        reporters: [
            'progress'
            'coverage'
        ]
        browserify: {
            debug: true
            extensions: ['.coffee']
            transform: ['coffeeify', 'browserify-istanbul']
        }
        coverageReporter:
            reporters: [
                {
                    type: 'html'
                    dir: 'coverage'
                }
                {
                    type: 'text-summary'
                }
            ]