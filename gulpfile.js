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

exports.default = gulp.parallel(
    function () { return copyDevAssets('index', 'dev'); },
    function () { return copyAssets('index', 'dev'); },
    function () { return cleanCss('dev'); },
    function () { return build('dev', { minify: false }); }
)

exports['dev-edit'] = gulp.parallel(
    function () { return copyDevAssets('edit', 'dev-edit'); },
    function () { return copyAssets('edit', 'dev-edit'); },
    function () { return cleanCss('dev-edit'); },
    function () { return build('dev-edit', { minify: false }); }
)

exports.dist = gulp.parallel(
    function () { return copyAssets('index', 'dist'); },
    function () { return cleanCss('dist'); },
    function () { return build('dist', { minify: false }); }
)

exports['dist-edit'] = gulp.parallel(
    function () { return copyAssets('edit', 'dist-edit'); },
    function () { return cleanCss('dist-edit'); },
    function () { return build('ddistev-edit', { minify: false }); }
)