'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');
var inflection = require('inflection');

var ModelGenerator = module.exports = function ModelGenerator(args, options, config) {
  yeoman.generators.NamedBase.apply(this, arguments);
  var nameAndProperties = this.name.split(':');
  this.modelName = inflection.camelize(nameAndProperties[0], true);
  this.modelClassName = inflection.camelize(this.modelName);
  this.modelSlugName = inflection.dasherize(this.modelName);
  this.collectionName = inflection.pluralize(this.modelName);
  this.properties = nameAndProperties[1].split(',');
};

util.inherits(ModelGenerator, yeoman.generators.NamedBase);

ModelGenerator.prototype.modules = function modules() {
  this.template('modules/_Model.coffee', 'modules/' + this.modelClassName + '.coffee');  
};

ModelGenerator.prototype.publicFiles = function publicFiles() {
  var target = 'public/' + this.modelSlugName;
  this.mkdir(target);
  target += '/';
  this.template('public/_Collection.coffee', target + 'Collection.coffee');
  this.template('public/_CollectionView.coffee', target + 'CollectionView.coffee');
  this.template('public/_DisplayView.coffee', target + 'DisplayView.coffee');
  this.template('public/_EditorView.coffee', target + 'EditorView.coffee');
  this.template('public/_Model.coffee', target + 'Model.coffee');
  this.template('public/_Presenter.coffee', target + 'Presenter.coffee');
};

ModelGenerator.prototype.tests = function tests() {
  this.template('tests/modules/_Model.coffee', 'tests/modules/' + this.modelClassName + 'Tests.coffee');
};

ModelGenerator.prototype.views = function views() {
  var target = 'views/' + this.modelSlugName;
  this.mkdir(target);
  target += '/';
  this.template('views/_display-template.jade', target + 'display-template.jade');
  this.template('views/_editor-template.jade', target + 'editor-template.jade');
  this.template('views/_item-template.jade', target + 'item-template.jade');
  this.template('views/_list-template.jade', target + 'list-template.jade');
};
