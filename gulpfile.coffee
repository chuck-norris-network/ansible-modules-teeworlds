path             = require 'path'
gulp             = require 'gulp'
coffeelint       = require 'gulp-coffeelint'
excludeGitignore = require 'gulp-exclude-gitignore'
nsp              = require 'gulp-nsp'
browserify       = require 'browserify'
coffeeify        = require 'coffeeify'
source           = require 'vinyl-source-stream'
buffer           = require 'vinyl-buffer'
chmod            = require 'gulp-chmod'
insert           = require 'gulp-insert'

gulp.task 'build', () ->
  browserify({
    entries: ['./src/teeworlds_econ.coffee']
    extensions: ['.coffee', '.js']
    debug: false
    browserField: false
    builtins: false
    commondir: false
    insertGlobalVars:
      global: undefined
      process: undefined
  })
    .transform(coffeeify, {
      bare: true
    })
    .bundle()
    .pipe source('teeworlds_econ')
    .pipe buffer()
    .pipe insert.prepend('#!/usr/bin/env node\n')
    .pipe chmod(755)
    .pipe gulp.dest('./')

gulp.task 'static', () ->
  gulp.src '**/*.coffee'
    .pipe excludeGitignore()
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffeelint.reporter('fail')

gulp.task 'develop', () ->
  gulp.watch 'src/**/*.coffee', ['build']
  return

gulp.task 'nsp', (done) ->
  nsp { package: path.resolve('./package.json') }, done

gulp.task 'prepublish', ['static', 'nsp', 'build']
gulp.task 'default', ['static', 'build', 'develop']
