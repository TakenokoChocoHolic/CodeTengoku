express = require 'express'

app = express.createServer(express.logger())

mes = "<p>hello world?</p>"
app.get '/', (req, resp) ->
  resp.render 'index.ejs', locals: mes:mes

port = process.env.PORT or 5000

app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."