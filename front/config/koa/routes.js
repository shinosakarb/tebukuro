"use strict"
var Router = require("koa-router")

var rootController = require("../../server/controllers/")

module.exports = function(app) {
  // register functions
  var router = new Router()

  router.get("/", function (ctx, next) {
    return rootController.index(ctx)
  })

/*
  router.get("/auth", authController.getCurrentUser)
  router.post("/auth", authController.signIn)

  router.all("/signout", authController.signOut)
  router.post("/signup", authController.createUser)

  // secured routes
  router.get("/value", secured, countController.getCount)
  router.get("/inc", secured, countController.increment)
  router.get("/dec", secured, countController.decrement)
*/
  app.use(router.routes())
}
