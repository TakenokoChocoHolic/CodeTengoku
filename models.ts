///<reference path='node/node.d.ts' />
var mongoose: any = require('mongoose');

// Initialize the uri for MongoDB
var uri = process.env.MONGOLAB_URI || 'mongodb://localhost/almond-choco'
console.log("DB Connecting: " + uri)
// Connect MongoDB (mongodb:#[hostname]/[dbname])
var db = mongoose.createConnection(uri)
console.log("DB Connected: " + uri)

// Define schemas
var Schema = mongoose.Schema

var CommentSchema = new Schema({
  text: String,
  date: Date
});

var TestCaseSchema = new Schema({
  input: String,
  output: String
});

var SubmitSchema = new Schema({
  code: String,
  comments: [CommentSchema],
  date: Date,
});

var ProblemSchema = new Schema({
  title: String,
  description: String,
  testCases: [TestCaseSchema],
  comments: [CommentSchema],
  submits: [SubmitSchema],
  date: Date,
});

var UserSchema = new Schema({
  mailAddress: String,
  password: String,
  name: String,
  salt: String,
  problems: [ProblemSchema]
});

var schemas = [
  ProblemSchema,
  TestCaseSchema,
  SubmitSchema,
  UserSchema,
  CommentSchema
]

// Set up a logger for mongoose
schemas.forEach(schema => {
  schema.pre ('save', next => {
    console.log('before save')
    next()
  });
});

// Initialize model accessors
export var Comment = db.model('Comment', CommentSchema);
export var TestCase = db.model('TestCase', TestCaseSchema);
export var Submit = db.model('Submit', SubmitSchema);
export var Problem = db.model('Problem', ProblemSchema);
export var User = db.model('User', UserSchema);
