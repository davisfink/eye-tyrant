'use strict';
/*
 *
 *  First time setup - DO THESE
 *
 * MAKE sure ruby compass is installed before hand:
 *
 *  http://compass-style.org/install/
 *
 * `brew install terminal-notifier`
 * `sudo npm install -g browser-sync gulp`
 * `npm install`
 * `gulp`
 */
var devPath = 'localhost:5000';

/* Required gulp plugins */

var gulp        = require('gulp'),
browserSync     = require('browser-sync'),
sass            = require('gulp-sass'),
autoprefixer    = require('gulp-autoprefixer'),
minifycss       = require('gulp-minify-css'),
del             = require('del'),
rename          = require('gulp-rename');

var $ = require('gulp-load-plugins')();


//all autoprefixer options

var prefixerOptions = [
    'last 2 version',
    'safari 5',
    'ie 8',
    'ie 9',
    'opera 12.1',
    'ios 6',
    'android 4'
];



function showError(err, file) {

    //show notification window
    //ouput SASS errors to command line

    $.notify.onError('Syntax error in ' +  file.path);
    console.log(err.message);
}

gulp.task('default', function () {
    gulp.start('watch');
});

gulp.task('browser-sync', function() {
    browserSync({
        proxy: devPath,
        open: false
    });
});


// All changes made to ruleset.xml, xslt templates, css, or scss will
// cause the site to reload at localhost:3000.

gulp.task('watch', ['browser-sync'], function () {
    /* our app scss files */
    gulp.watch('EyeTyrant-App/public/scss/**/*.scss', function(file) {
        gulp.src('EyeTyrant-App/public/scss/app.scss')
        .pipe(sass())
        .on('error', function(err){showError(err, file);})
    });

    //watch when css files are changed, and trigger browser sync to refresh any attached browsers

    gulp.watch('EyeTyrant-App/public/css/**/*.css', function(file) {
        gulp.src(file.path)
        .pipe(browserSync.reload({stream:true}));
    });
});
