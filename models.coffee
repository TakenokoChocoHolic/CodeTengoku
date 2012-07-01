mongoose = require('mongoose')

# Define schemas
Schema = mongoose.Schema

commentSchema = new Schema
  text: String
  date: Date

testCaseSchema = new Schema
  inputText: String
  outputText: String

submitSchema = new Schema
  code: String
  comments: [commentSchema]
  date: Date

problemSchema = new Schema
  title: String
  description: String
  testCases: [testCaseSchema]
  comments: [commentSchema]
  submits: [submitSchema]
  date: Date
  
userSchema = new Schema
  mailAddress: String
  password: String
  name: String
  salt: String
  problems: [problemSchema]
  
schemas = [
  {name: "Problem", schema: problemSchema},
  {name: "TestCase", schema: testCaseSchema},
  {name: "Submit", schema: submitSchema},
  {name: "User", schema: userSchema},
  {name: "Comment", schema: commentSchema},
]


# Initialize the uri for MongoDB
uri = process.env.MONGOLAB_URI or 'mongodb:#localhost/mongo_data'
console.log(uri)

# Set up a logger for mongoose
for s in schemas
  s["schema"].pre 'init', (next) ->
    console.log('initialized')
    next()

  s["schema"].pre 'save', (next) ->
    console.log('pre save.')
    next()


# Connect MongoDB (mongodb:#[hostname]/[dbname])
mongoose.connect(uri)
for s in schemas
   mongoose.model(s["name"], s["schema"])

# Initialize model accessors
exports.Comment = mongoose.model('Comment')
exports.TestCase = mongoose.model('TestCase')
exports.Submit = mongoose.model('Submit')
exports.Problem = mongoose.model('Problem')
exports.User = mongoose.model('User')
