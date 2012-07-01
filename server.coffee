express    = require 'express'
controller = require './controller'

app = express.createServer(express.logger())
app.configure ->
  app.use(express.bodyParser())
  app.use(express.methodOverride())

controller.start app
port = process.env.PORT or 5000
app.listen port, ->
  console.log "Listening on #{port}\nPress CTRL-C to stop server."
