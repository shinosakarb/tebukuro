"use strict"

const views = require("koa-views")

module.exports = function(app) {
  app.use(views(__dirname + '/../../server/views', {
    map: {
      html: 'pug'
    }
  }))
}
