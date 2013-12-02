'use strict';

var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var exec = require('child_process').exec;

var installFrontend = function installFrontend () {
  var self = this;
  self.log.info("Fetching dependencies and building front-end...");
  exec("grunt install", function () {
    exec("grunt build", function () {
      self.log.info("Done!");
    });
  });
};

var ErmaGenerator = module.exports = function ErmaGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'], callback: installFrontend.bind(this) });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(ErmaGenerator, yeoman.generators.Base);

ErmaGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  console.log(this.yeoman);

  var prompts = [{
    name: 'name',
    message: 'Project name (for ex., super-project)'
  }, {
    name: 'author',
    message: 'Author nickname (for ex., super-author)'
  }, {
    name: "authorName",
    message: "Author name (for ex., Super Author)"
  }, {
    name: "description",
    message: "Project description (for ex., The most awesome thing you've ever seen!)"
  }, {
    name: "keywords",
    message: "Keywords (for ex., \"keyword\", \"another expression\")"
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

ErmaGenerator.prototype.modules = function modules() {
  this.mkdir("modules");
  this.copy("modules/Log.coffee", "modules/Log.coffee");
  this.copy("modules/Resources.coffee", "modules/Resources.coffee");
  this.copy("modules/Security.coffee", "modules/Security.coffee");
  this.copy("modules/User.coffee", "modules/User.coffee");  
};

ErmaGenerator.prototype.public_ = function public_() {
  this.mkdir("public");
  this.mkdir("public/images");
  this.copy("public/images/back.jpg", "public/images/back.jpg");
  this.copy("public/landing.css", "public/landing.css");
  this.copy("public/style.css", "public/style.css");

  this.copy("public/app.coffee", "public/app.coffee");
  this.copy("public/bus.coffee", "public/bus.coffee");
  this.copy("public/main.coffee", "public/main.coffee");
  this.copy("public/routes.coffee", "public/routes.coffee");
  this.copy("public/routing.coffee", "public/routing.coffee");
};

ErmaGenerator.prototype.tests = function tests() {
  this.mkdir("tests");
  this.mkdir("tests/data");
  this.mkdir("tests/modules");
  this.copy("tests/modules/UserTests.coffee", "tests/modules/UserTests.coffee");
  this.template("tests/_index.coffee", "tests/index.coffee");
};

ErmaGenerator.prototype.views = function views() {
  this.mkdir("views");
  this.template("views/_landing.jade", "views/landing.jade");
  this.template("views/_master.jade", "views/master.jade");
  this.copy("views/app.jade", "views/app.jade");
};

ErmaGenerator.prototype.app = function app() {
  this.template('_config.coffee', 'config.coffee');
  this.template('_package.json', 'package.json');  
  this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
  this.copy("index.coffee", "index.coffee");
  this.copy('gitignore', '.gitignore');
  this.copy('gitattributes', '.gitattributes');
  this.copy('travis.yml', '.travis.yml');
  this.template("_README.md", "README.md");
};
