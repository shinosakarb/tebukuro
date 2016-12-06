"use strict"

const middleware = require('koa-webpack')
const config = require('../webpack/webpack.dev.config.js')

module.exports = function(app) {
  app.use(middleware({
    config: config,
    dev: {
      // display no info to console (only warnings and errors)
      noInfo: false,

      // display nothing to the console
      quiet: false,

      // switch into lazy mode
      // that means no watching, but recompilation on every request
      //lazy: true,

      // watch options (only lazy: false)
      watchOptions: {
        aggregateTimeout: 300,
        poll: true
      },

      // public path to bind the middleware to
      // use the same as in webpack
      //publicPath: "/assets/",

      // custom headers
      // headers: { "X-Custom-Header": "yes" },

      // options for formating the statistics
      stats: {
        colors: true
      }
    },
    hot: {
      // log: console.log,
      // path: '/__webpack_hmr',
      // timeout: 2000
      // heartbeat: 10 * 1000
    }
  }))
}
