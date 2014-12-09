'use strict'

module.exports = (gulp, $) ->

    require('./clean')(gulp, $)
    require('./build')(gulp, $)
    require('./watch')(gulp, $)
    require('./serve')(gulp, $)
    require('./js')(gulp, $)
    require('./unitTests')(gulp, $)
    require('./e2eTests')(gulp, $)