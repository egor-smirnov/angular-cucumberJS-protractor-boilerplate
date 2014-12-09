'use strict'

module.exports = (gulp, $) ->

    gulp.task 'serve', ['watch'], ->
        $.browserSync
            server:
                baseDir: './'