express = require('express')
mongoose = require('mongoose')

// Define schemas
Schema = mongoose.Schema
commentSchema = new Schema
  body :String
  date :Date


// Initialize the uri for MongoDB
uri = process.env.MONGOLAB_URI or 'mongodb://localhost/mongo_data'
console.log(uri)

// Set up a logger for mongoose
commentSchema.pre 'init', (next) ->
  console.log('initialized')
  next()

commentSchema.pre 'save', (next) ->
  console.log('pre save.')
  next()


// Connect MongoDB (mongodb://[hostname]/[dbname])
mongoose.connect(uri)
mongoose.model('Comment', commentSchema)

// Initialize model accessors
Comment = mongoose.model('Comment')

app = express.createServer(express.logger())

app.get '/', (req, res) ->
  // Add new comment record for testing
  comment = new Comment()
  comment.body = sanitizedMsg
  comment.date = date
  comment.save (err) ->
    console.log('save.') if !err

  mes = "<p>hello world?</p>"
  res.render('index.ejs', {locals:{mes:mes}})

app.get '/problem_set', (req, res) ->
  mes = "<p>Problem set!</p>"
  res.render('index.ejs', {locals:{mes:mes}})

app.get '/funny_api/', (req, res) ->
  res.render('funny_api.ejs', {locals:{mes:''}})


port = process.env.PORT or 5000

app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."
