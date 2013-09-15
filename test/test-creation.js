/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;


describe('erma generator', function () {
  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('erma:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates expected files', function (done) {
    var expected = [
      '.travis.yml',
      'Gruntfile.coffee',
      'package.json'
    ];

    helpers.mockPrompt(this.app, {
      'name': 'name',
      'author': 'bob',
      'authorName': 'Sponge Bob',
      'description': 'Test project',
      'keywords': '"test", "project"'
    });
    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFiles(expected);
      done();
    });
  });
});
