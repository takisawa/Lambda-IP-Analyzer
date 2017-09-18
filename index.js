'use strict';

const env = process.env;
const request = require('request-promise');

exports.handler = function(event, context) {
  sleep(parseInt(env.SLEEP_SEC))
    .then(function() { return request(env.RETURN_CLIENT_IP_URL) })
    .then(function(body) { context.done(null, body) })
    .catch(function(err) { context.fail(err) })
}

/**
 * 引数で指定された秒数 sleep する。
 * @param sec {number}
 * @return {Promise}
 */
function sleep(sec) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve('abc');
    }, sec * 1000);
  });
}
