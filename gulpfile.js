var Builder = require('jspm').Builder;
var gulp = require('gulp');
var cleancss = require('gulp-clean-css');
var autoprefix = require('gulp-autoprefixer');

require('./src/vendor/object.assign.js');

function build(dest, options) {
    var builder = new Builder({ baseURL: './' });
    return builder.loadConfig('jspm.config.js')
        .then(function () {
            return builder.buildStatic(
                './main.js',
                'builds/' + dest + '/main.js',
                Object.assign({
                    minify: true,
                    sourceMaps: false
                }, (options || {}))
            )
        });
}

function buildEdit(dest, options) {
    var builder = new Builder({ baseURL: './' });
    return builder.loadConfig('jspm.config.js')
        .then(function () {
            return builder.buildStatic(
                './edit.js',
                'builds/' + dest + '/edit.js',
                Object.assign({
                    minify: true,
                    sourceMaps: false
                }, (options || {}))
            )
        });
}

function cleanCss(dest) {
    return gulp.src([
        './css/**/*.css'
    ])
        .pipe(autoprefix({
            browsers: ['last 2 versions'],
            cascade: false
        }))
        .pipe(cleancss())
        .pipe(gulp.dest('builds/' + dest));
}

function copyAssets(app, dest) {
    return gulp.src([
        './assets/common/**',
        './assets/' + app + '/**'
    ]).pipe(gulp.dest('builds/' + dest));
}

function copyDevAssets(app, dest) {
    return gulp.src([
        './dev-assets/common/**',
        './dev-assets/' + app + '/**'
    ]).pipe(gulp.dest('builds/' + dest));
}

function copyBuild(buildName, to) {
    return gulp.src(['builds/' + buildName + '/**']).pipe(gulp.dest(to));
}

gulp.task('dev:dev-assets', [], function () { return copyDevAssets('index', 'dev'); });
gulp.task('dev:assets', [], function () { return copyAssets('index', 'dev'); });
gulp.task('dev:css', [], function () { return cleanCss('dev'); });
gulp.task('dev:code', [], function () { return build('dev', { minify: false }); });
gulp.task('dev', ['dev:assets', 'dev:code', 'dev:css', 'dev:dev-assets']);

gulp.task('dev-edit:assets', [], function () { return copyAssets('edit', 'dev-edit'); });
gulp.task('dev-edit:dev-assets', [], function () { return copyDevAssets('edit', 'dev-edit'); });
gulp.task('dev-edit:css', [], function () { return cleanCss('dev-edit'); });
gulp.task('dev-edit:code', [], function () { return buildEdit('dev-edit', { minify: false }); });
gulp.task('dev-edit', ['dev-edit:assets', 'dev-edit:code', 'dev-edit:css', 'dev-edit:dev-assets']);

gulp.task('watch', ['dev'], function () {
    gulp.watch(['./assets/**'], ['dev:assets']);
    gulp.watch(['./dev-assets/**'], ['dev:dev-only-assets']);
    gulp.watch(['./css/**'], ['dev:css']);
    gulp.watch(['./src/**'], ['dev:code']);
});

gulp.task('dist:assets', [], function () { return copyAssets('index', 'dist'); });
gulp.task('dist:css', [], function () { return cleanCss('dist'); });
gulp.task('dist:code', [], function () { return build('dist'); });
gulp.task('dist', ['dist:assets', 'dist:code', 'dist:css']);

gulp.task('dist-edit:assets', [], function () { return copyAssets('edit', 'dist-edit'); });
gulp.task('dist-edit:css', [], function () { return cleanCss('dist-edit'); });
gulp.task('dist-edit:code', [], function () { return buildEdit('dist-edit'); });
gulp.task('dist-edit', ['dist-edit:assets', 'dist-edit:code', 'dist-edit:css']);