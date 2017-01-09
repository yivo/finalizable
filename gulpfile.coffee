gulp    = require 'gulp'
concat  = require 'gulp-concat'
coffee  = require 'gulp-coffee'
iife    = require 'gulp-iife-wrap'
plumber = require 'gulp-plumber'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  gulp.src('source/finalizable.coffee')
  .pipe plumber()
  .pipe iife(global: 'Finalizable', dependencies: [{global: 'Object', native: true}])
  .pipe concat('finalizable.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('finalizable.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
