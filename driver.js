'use strict';

var lambda = require("./index");

var event = {};
var context = {
  done: function(error, message) {
    console.log('[message] ' + message);
    console.log('[error] ' + error);
  }
};

lambda.handler(event, context);
