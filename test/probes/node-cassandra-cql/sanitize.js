exports.run = function (ctx, done) {
  var conf = ctx.ao.probes['node-cassandra-cql']
  conf.sanitizeSql = true
  ctx.cql.execute("SELECT * from foo where bar='1'", function (err) {
    conf.sanitizeSql = false
    done(err)
  })
}
