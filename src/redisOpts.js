// @format
var url = process.env.REDIS_URL || 'redis://127.0.0.1:6379/';
var redisDatabase = process.env.REDIS_DB || 0;
if (typeof(redisDatabase) === 'string') {
  redisDatabase = parseInt(redisDatabase);
}
var redisOpts = require('redis-url').parse(url);

module.exports = {
  host: redisOpts.hostname,
  port: redisOpts.port,
  password: redisOpts.password,
  options: {db: redisDatabase},
};
