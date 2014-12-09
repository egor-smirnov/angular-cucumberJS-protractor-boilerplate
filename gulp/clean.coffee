'use strict'

module.exports = (gulp, $) ->

    gulp.task 'clean', (done) ->
        $.del 'dist', done