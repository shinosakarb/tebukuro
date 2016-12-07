"use strict"

const middleware = require('koa-webpack')
const config = require('../webpack/webpack.dev.config.js')

module.exports = function(app) {
  app.use(middleware({
    config: config,
    dev: {
      noInfo: false,
      quiet: false,
      watchOptions: {
        aggregateTimeout: 300,
        poll: true
      },
      stats: {
        colors: true
      }
    }
  }))
}
