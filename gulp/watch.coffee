'use strict'

module.exports = (gulp, $) ->

    gulp.task 'watch', ->
        gulp.watch 'app/js/**/**/*.js', ['js', $.browserSync.reload]