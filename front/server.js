var koa = require('koa')
var app = new koa()

require("./config/koa")(app)
// Routes
require("./config/koa/routes")(app)
require("./config/koa/webpack")(app)

var server = app.listen(4000)
