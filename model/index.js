'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');
var inflection = require('inflection');
var fs = require('fs');

var ModelGenerator = module.exports = function ModelGenerator(args, options, config) {
  yeoman.generators.NamedBase.apply(this, arguments);
  var nameAndProperties = this.name.split(':');
  this.modelName = inflection.camelize(nameAndProperties[0], true);
  this.modelClassName = inflection.camelize(this.modelName);
  this.collectionName = inflection.pluralize(this.modelName);
  this.modelSlugName = inflection.dasherize(this.collectionName);
  this.collectionClassName = inflection.capitalize(this.collectionName);
  this.properties = nameAndProperties[1].split(',').map(function (p) {
    return {
      name: p,
      title: inflection.titleize(p)
    };
  });
};

util.inherits(ModelGenerator, yeoman.generators.NamedBase);

ModelGenerator.prototype.modules = function modules() {
  this.template('modules/models/_Model.coffee', 'modules/models/' + this.modelClassName + '.coffee');  
  this.template('modules/resources/_Resource.coffee', 'modules/resources/' + this.modelClassName + '.coffee');  
  fs.appendFileSync('modules/resources/index.coffee', "\t" + this.collectionName + ": require './" + this.modelClassName + "'");
};

ModelGenerator.prototype.publicFiles = function publicFiles() {
  var target = 'public/' + this.modelSlugName;
  this.mkdir(target);
  target += '/';
  this.template('public/_Collection.coffee', target + 'Collection.coffee');
  this.template('public/_Controller.coffee', target + 'Controller.coffee');
  this.template('public/_DetailView.coffee', target + 'DetailView.coffee');
  this.template('public/_EditorView.coffee', target + 'EditorView.coffee');
  this.template('public/_RemoveView.coffee', target + 'RemoveView.coffee');
  this.template('public/_ListView.coffee', target + 'ListView.coffee');
  this.template('public/_Model.coffee', target + 'Model.coffee');
  this.template('public/_routes.coffee', target + 'routes.coffee');
  fs.appendFileSync("public/routes.coffee", "\t\t" + this.modelName + 'Routes');
};

ModelGenerator.prototype.tests = function tests() {
  this.template('tests/modules/_Model.coffee', 'tests/modules/' + this.modelClassName + 'Tests.coffee');
};

ModelGenerator.prototype.views = function views() {
  var target = 'views/' + this.modelSlugName;
  this.mkdir(target);
  target += '/';
  this.template('views/_detail.jade', target + 'detail.jade');
  this.template('views/_editor.jade', target + 'editor.jade');
  this.template('views/_list.jade', target + 'list.jade');
  this.template('views/_remove.jade', target + 'remove.jade');
  this.copy('views/index.jade', target + 'index.jade');
  fs.appendFileSync("views/app.jade", "\tinclude " + this.collectionName + "/index");
  fs.appendFileSync("views/navbar.jade", "\t\t\tli: a(href='#" + this.collectionName + "') " + this.collectionClassName);
};
