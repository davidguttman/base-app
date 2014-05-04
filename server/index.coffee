http = require 'http'

ecstatic = (require 'ecstatic') root: __dirname + '/../public'

server = http.createServer (req, res) ->
  ecstatic req, res

port = process.env.PORT or 3000
server.listen port

console.log 'Listening on port:', port
