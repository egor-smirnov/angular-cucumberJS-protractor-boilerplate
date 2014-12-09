require 'coffee-script'

exports.config =
    seleniumServerJar: '../node_modules/protractor/selenium/selenium-server-standalone-2.44.0.jar'
    framework: 'cucumber'
    baseUrl: 'http://localhost:49010/index-e2e.html'
    specs: [
        '../test/features/*.feature'
    ]

    capabilities:
        browserName: 'chrome'

    cucumberOpts:
        require: 'test/features/steps/*Steps.coffee',
        format: 'pretty'

    jasmineNodeOpts :
        showColors : true
        defaultTimeoutInterval: 40000
        isVerbose : true
        includeStackTrace : true