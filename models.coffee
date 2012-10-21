mongoose = require('mongoose')

# Define schemas
Schema = mongoose.Schema

Comment = new Schema
  text: String
  date: Date

TestCase = new Schema
  input: String
  output: String

Submit = new Schema
  code: String
  comments: [Comment]
  date: Date

Problem = new Schema
  title: String
  description: String
  testCases: [TestCase]
  comments: [Comment]
  submits: [Submit]
  date: Date
  
User = new Schema
  mailAddress: String
  password: String
  name: String
  salt: String
  problems: [Problem]
  
schemas = [
  {name: "Problem", schema: Problem},
  {name: "TestCase", schema: TestCase},
  {name: "Submit", schema: Submit},
  {name: "User", schema: User},
  {name: "Comment", schema: Comment},
]


# Initialize the uri for MongoDB
uri = process.env.MONGOLAB_URI or 'mongodb://localhost/almond-choco'
console.log(uri)

# Set up a logger for mongoose
for s in schemas
  s["schema"].pre 'init', (next) ->
    console.log('before init')
    next()

  s["schema"].pre 'save', (next) ->
    console.log('before save')
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
