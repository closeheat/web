var gulp = require('gulp');
var surge = require('gulp-surge')
var jade = require('gulp-jade');
var sass = require('gulp-sass');
var coffeeify = require('gulp-coffeeify');
var gutil = require('gulp-util');

var dirs = {
  src: './src',
  dist: './dist',
};

var paths = {
  jade: ['**/*.jade'],
  coffee: ['**/*.coffee'],
  scss: ['**/*.scss'],
  images: ['**/*.png', '**/*.svg', '**/*.jpg', '**/*.gif'],
  extras: [
    '**/*.js',
    '**/*.eot',
    '**/*.ttf',
    '**/*.woff',
    '**/*.xml',
    '**/*.txt',
    'manifest.json',
    'robots.txt',
    'favicon.ico'
  ],
};

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('build', function() {
  gulp.src(paths.jade, { cwd: dirs.src })
    .pipe(jade())
    .pipe(gulp.dest(dirs.dist))

  gulp.src(paths.scss, { cwd: dirs.src })
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(dirs.dist))

   gulp.src(paths.coffee, { cwd: dirs.src })
    .pipe(coffeeify())
    .pipe(gulp.dest(dirs.dist));

   gulp.src(paths.images, { cwd: dirs.src })
     .pipe(gulp.dest(dirs.dist));

   gulp.src(paths.extras, { cwd: dirs.src })
     .pipe(gulp.dest(dirs.dist));
});

gulp.task('deploy', [], function () {
  return surge({
    project: './dist',
    domain: 'closeheat.com'
  })
});
