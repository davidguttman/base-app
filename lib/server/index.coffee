ejs             = require 'ejs'
express         = require 'express'
RedisStore      = (require 'connect-redis') express

bundle = require './bundle'

app = express()

app.configure ->
  app.use express.cookieParser()
  app.use express.session
    secret: "some secret"
    store: new RedisStore if process.env.NODE_ENV is 'production'
  app.use express.bodyParser()
  app.use express.static './public', {maxAge: 86400000}
  app.use express.logger 'dev'

app.set 'views', './views'
app.engine 'html', ejs.renderFile

app.get '/', (req, res) ->
  res.render 'index.ejs'

port = process.env.PORT or 3000

app.listen port

console.log "Express running on port #{port}"