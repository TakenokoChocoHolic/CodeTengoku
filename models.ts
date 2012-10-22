var mongoose: any = require('mongoose');

var Schema = mongoose.Schema

var SComment = new Schema({
  text: String,
  date: Date
});

var STestCase = new Schema({
  input: String,
  output: String
});

var SSubmit = new Schema({
  code: String,
  comments: [SComment],
  date: Date,
});

var SProblem = new Schema({
  title: String,
  description: String,
  testCases: [STestCase],
  comments: [SComment],
  submits: [SSubmit],
  date: Date,
});

var SUser = new Schema({
  mailAddress: String,
  password: String,
  name: String,
  salt: String,
  problems: [SProblem]
});


var schemas = [
  {name: "Problem", schema: SProblem},
  {name: "TestCase", schema: STestCase},
  {name: "Submit", schema: SSubmit},
  {name: "User", schema: SUser},
  {name: "Comment", schema: SComment},
];


// Initialize the uri for MongoDB
var uri = process.env.MONGOLAB_URI || 'mongodb://localhost/almond-choco';
console.log(uri);

// Set up a logger for mongoose
for (var i=0; i<schemas.length; i++) {
    var s = schemas[i];
    s["schema"].pre('init', (next) => {
        console.log('before init');
        next();
    });

    s["schema"].pre('save', (next) => {
        console.log('before save');
        next();
    });
}


// Connect MongoDB (mongodb:#[hostname]/[dbname])
mongoose.connect(uri);
for (var i=0; i<schemas.length; i++) {
    var s = schemas[i];
    mongoose.model(s["name"], s["schema"]);
}

// Initialize model accessors
export var Comment = mongoose.model('Comment');
export var TestCase = mongoose.model('TestCase');
export var Submit = mongoose.model('Submit');
export var Problem = mongoose.model('Problem');
export var User = mongoose.model('User')

