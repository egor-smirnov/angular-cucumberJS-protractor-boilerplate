'use strict'

gulp = require 'gulp'
$ = require('gulp-load-plugins')(
    pattern: ['gulp-*', 'run-sequence', 'del', 'karma', 'browser-sync']
)

require('./gulp')(gulp, $)

gulp.task 'default', ->
    $.runSequence 'clean', 'build', 'serve'