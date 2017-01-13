gulp    = require 'gulp'
concat  = require 'gulp-concat'
coffee  = require 'gulp-coffee'
umd     = require 'gulp-umd-wrap'
plumber = require 'gulp-plumber'
fs      = require 'fs'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  dependencies = [
    {global: 'Object', native: true}
    {require: 'coffee-concerns'}
  ]
  
  header = fs.readFileSync('source/__license__.coffee')
  
  gulp.src('source/finalizable.coffee')
  .pipe plumber()
  .pipe umd({global: 'Finalizable', dependencies, header})
  .pipe concat('finalizable.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('finalizable.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
