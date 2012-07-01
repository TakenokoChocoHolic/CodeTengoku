mongoose = require('mongoose')

# Define schemas
Schema = mongoose.Schema
commentSchema = new Schema
  body :String
  date :Date


# Initialize the uri for MongoDB
uri = process.env.MONGOLAB_URI or 'mongodb:#localhost/mongo_data'
console.log(uri)

# Set up a logger for mongoose
commentSchema.pre 'init', (next) ->
  console.log('initialized')
  next()

commentSchema.pre 'save', (next) ->
  console.log('pre save.')
  next()


# Connect MongoDB (mongodb:#[hostname]/[dbname])
mongoose.connect(uri)
mongoose.model('Comment', commentSchema)

# Initialize model accessors
Comment = mongoose.model('Comment')

exports.Comment = Comment
