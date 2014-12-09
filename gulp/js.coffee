'use strict'

module.exports = (gulp, $) ->

    gulp.task 'js', ->
        gulp.src 'app/js/app.js'
            .pipe $.plumber()
            .pipe $.browserify({ debug: true})
            .pipe gulp.dest 'dist/js'