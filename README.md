# ERMA - Express-REST-Marionette Web Application Generator

generator-erma [![Build Status](https://secure.travis-ci.org/titarenko/generator-erma.png?branch=master)](https://travis-ci.org/titarenko/generator-erma) [![Code Climate](https://codeclimate.com/github/titarenko/generator-erma.png)](https://codeclimate.com/github/titarenko/generator-erma) [![Coverage Status](https://coveralls.io/repos/titarenko/generator-erma/badge.png)](https://coveralls.io/r/titarenko/generator-erma)

A generator for [Yeoman](http://yeoman.io).

[![NPM](https://nodei.co/npm/generator-erma.png?downloads=true&stars=true)](https://nodei.co/npm/generator-erma/)

## Getting Started

```
$ npm install -g generator-erma
```

## Purpose

### yo erma

Generates foundation source code of `express` application.

### yo erma:model model_name:property1,property2,...propertyN

Generates: 

* `mongoose` model
* `REST` resource
* `Backbone` model, collection, etc
* `Marionette` controller, views, etc
* `Jade`-`doT` templates

Updates base code of application, to plug-in just generated model.

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
