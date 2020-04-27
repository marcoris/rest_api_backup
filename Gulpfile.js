// Initialize modules
const gulp = require('gulp'),
    bump = require('gulp-bump'),
    ftp = require('vinyl-ftp'),
    gutil = require('gulp-util'),
    conventionalChangelog = require('gulp-conventional-changelog'),
    conventionalGithubReleaser = require('conventional-github-releaser'),
    git = require('gulp-git'),
    prompt = require('gulp-prompt'),
    replace = require('gulp-replace'),
    fs = require('fs');

require('dotenv').config();

// Bump version x.x.1 package.json
function bumpPatchPackage() {
    return gulp.src(['./package.json', './README.md'])
        .pipe(bump({
            type: 'patch'
        }))
        .pipe(gulp.dest('./'));
}

// Bump version x.1.x package.json
function bumpMinorPackage() {
    return gulp.src(['./package.json', './README.md'])
        .pipe(bump({
            type: 'minor'
        }))
        .pipe(gulp.dest('./'));
}

// Bump version 1.x.x package.json
function bumpMajorPackage() {
    return gulp.src(['./package.json', './README.md'])
        .pipe(bump({
            type: 'major'
        }))
        .pipe(gulp.dest('./'));
}

// Changelog
function changelog() {
    return gulp.src('CHANGELOG.md', {
        buffer: true
    })
        .pipe(conventionalChangelog({
            preset: 'angular',
            outputUnreleased: true
        }))
        .pipe(gulp.dest('./'));
}

// Commit changes
function commitChanges() {
    return gulp.src('.')
        .pipe(git.add())
        .pipe(git.commit('Bumped version number'));
}

// Push changes
function pushChanges(done) {
    git.push('origin', 'master', done);
}

// Create new tag
function createNewTag(done) {
    var version = JSON.parse(fs.readFileSync('./package.json', 'utf8')).version;
    git.tag(version, 'Created Tag for version: ' + version, function(error) {
        if (error) {
            return done(error);
        }
        git.push('origin', 'master', {
            args: '--tags'
        }, done);
    });
}

// Github release
function githubRelease(done) {
    conventionalGithubReleaser({
        type: 'oauth',
        token: process.env.GITHUB_TOKEN,
        url: 'https://api.github.com'
    }, {
        preset: 'angular'
    }, done);
}

// Releases the project with version bump prompt
function release() {
    var gitStuff = gilp.series(changelog, commitChanges, pushChanges, createNewTag, githubRelease);
    var runPatch = gulp.series(bumpPatchPackage, gitStuff);
    var runMinor = gulp.series(bumpMinorPackage, gitStuff);
    var runMajor = gulp.series(bumpMajorPackage, gitStuff);

    return gulp.src('./gulpfile.js')
        .pipe(prompt.prompt({
            type: 'checkbox',
            name: 'bump',
            message: 'What type of bump would you like to do?',
            choices: ['patch', 'minor', 'major']
        }, function(res) {
            if (res.bump[0] == 'major') {
                runMajor();
            } else if (res.bump[0] == 'minor') {
                runMinor();
            } else {
                runPatch();
            }
        }));
}

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
        .pipe(replace('@@host', process.env.DB_HOST))
        .pipe(replace('@@dbname', process.env.DB_NAME))
        .pipe(replace('@@dbpass', process.env.DB_PASS))
        .pipe(conn.newer('.'))
        .pipe(conn.dest('.'));
}

exports.release = gulp.series(release);
exports.deploy = gulp.series(deploy);
