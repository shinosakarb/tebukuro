"use strict"

exports.index = function(ctx) {
  return ctx.render("basic", {
    youAreUsingPug: true,
    version: '0.0.1',
  })
}
