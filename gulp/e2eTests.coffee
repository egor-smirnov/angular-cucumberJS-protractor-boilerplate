'use strict'

module.exports = (gulp, $) ->

    gulp.task 'server-e2e', (cb) ->

        $.browserSync {
            server:
                baseDir: './'
            port: 49010
            open: false
        },
        cb

    gulp.task 'e2e', ['server-e2e'], (cb) ->

        gulp.src(["tests/features/**/*"], {read: false})

            .pipe $.protractor.protractor(
                configFile: 'test/protractor.conf.coffee'
            )

            .on 'error', (e) ->
                $.browserSync.exit()
                console.log e
                cb()

            .on 'end', ->

                $.browserSync.exit()
                cb()