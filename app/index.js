'use strict';

var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');

var ErmaGenerator = module.exports = function ErmaGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(ErmaGenerator, yeoman.generators.Base);

ErmaGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'name',
    message: 'Project name'
  }, {
    name: 'author',
    message: 'Author nickname'
  }, {
    name: "authorName",
    message: "Author name"
  }, {
    name: "description",
    message: "Project description"
  }, {
    name: "keywords",
    message: "Keywords"
  }];

  this.prompt(prompts, function (props) {
    this.name = props.name;
    this.author = props.author;
    this.authorName = props.authorName;
    this.description = props.description;
    this.keywords = props.keywords;
    cb();
  }.bind(this));
};

ErmaGenerator.prototype.app = function app() {
  this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('_package.json', 'package.json');
  this.copy('travis.yml', '.travis.yml');
};
