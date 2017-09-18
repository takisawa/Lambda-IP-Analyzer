'use strict';

var lambda = require("./index");

var event = {};
var context = {
  done: function(error, message) {
    console.log('[context.done]');
    console.log('[message] ' + message);
    console.log('[error] ' + error);
  },
  fail: function(error) {
    console.log('[context.fail]');
    console.log('[error] ' + error);
  }
};

lambda.handler(event, context);
