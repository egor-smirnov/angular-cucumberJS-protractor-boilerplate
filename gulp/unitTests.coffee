'use strict'

module.exports = (gulp, $) ->

    gulp.task 'test', ->

        $.karma.server.start(
            configFile: __dirname + '/../test/karma.conf.coffee'
            singleRun: true
        )

    gulp.task 'tdd', ->

        $.karma.server.start(
            configFile: __dirname + '/../test/karma.conf.coffee'
            singleRun: false
        )