'use strict';

const request = require('request-promise');

exports.handler = function(event, context) {
  context.done(null, 'IP');
}
