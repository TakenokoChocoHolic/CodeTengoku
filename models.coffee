mongoose = require('mongoose')

# Initialize the uri for MongoDB
uri = process.env.MONGOLAB_URI or 'mongodb://localhost/almond-choco'
console.log("DB Connecting: " + uri)
# Connect MongoDB (mongodb:#[hostname]/[dbname])
db = mongoose.createConnection(uri)
console.log("DB Connected: " + uri)

# Define schemas
Schema = mongoose.Schema

CommentSchema = new Schema
  text: String
  date: Date

TestCaseSchema = new Schema
  input: String
  output: String

SubmitSchema = new Schema
  code: String
  comments: [CommentSchema]
  date: Date

ProblemSchema = new Schema
  title: String
  description: String
  testCases: [TestCaseSchema]
  comments: [CommentSchema]
  submits: [SubmitSchema]
  date: Date
  
UserSchema = new Schema
  mailAddress: String
  password: String
  name: String
  salt: String
  problems: [ProblemSchema]
  
schemas = [
  ProblemSchema,
  TestCaseSchema,
  SubmitSchema,
  UserSchema,
  CommentSchema
]

# Set up a logger for mongoose
for schema in schemas
  schema.pre 'save', (next) ->
    console.log('before save')
    next()

# Initialize model accessors
exports.Comment = db.model('Comment', CommentSchema)
exports.TestCase = db.model('TestCase', TestCaseSchema)
exports.Submit = db.model('Submit', SubmitSchema)
exports.Problem = db.model('Problem', ProblemSchema)
exports.User = db.model('User', UserSchema)
