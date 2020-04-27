// Initialize modules
const gulp = require('gulp');
const ftp = require('vinyl-ftp');
const gutil = require('gulp-util');
const replace = require('gulp-replace');

require('dotenv').config();

// Deploy
function deploy() {
    var conn = ftp.create({
        host: process.env.FTP_HOST,
        user: process.env.FTP_USER,
        password: process.env.FTP_PASS,
        parallel: 5,
        log: gutil.log
    });

    return gulp.src('./api/1.0/**/*', {
        base: '.',
        buffer: false
        })
        .pipe(replace('@@dbhost', process.env.DB_HOST))
        .pipe(replace('@@dbname', process.env.DB_NAME))
        .pipe(replace('@@dbpass', process.env.DB_PASS))
        .pipe(conn.newer('.'))
        .pipe(conn.dest('.'));
}

exports.deploy = gulp.series(deploy);
