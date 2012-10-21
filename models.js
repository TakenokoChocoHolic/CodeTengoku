var mongoose = require('mongoose');
var Schema = mongoose.Schema;
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
    comments: [
        SComment
    ],
    date: Date
});
var SProblem = new Schema({
    title: String,
    description: String,
    testCases: [
        STestCase
    ],
    comments: [
        SComment
    ],
    submits: [
        SSubmit
    ],
    date: Date
});
var SUser = new Schema({
    mailAddress: String,
    password: String,
    name: String,
    salt: String,
    problems: [
        SProblem
    ]
});
var schemas = [
    {
        name: "Problem",
        schema: SProblem
    }, 
    {
        name: "TestCase",
        schema: STestCase
    }, 
    {
        name: "Submit",
        schema: SSubmit
    }, 
    {
        name: "User",
        schema: SUser
    }, 
    {
        name: "Comment",
        schema: SComment
    }, 
    
];
var uri = process.env.MONGOLAB_URI || 'mongodb://localhost/almond-choco';
console.log(uri);
for(var i = 0; i < schemas.length; i++) {
    var s = schemas[i];
    s["schema"].pre('init', function (next) {
        console.log('before init');
        next();
    });
    s["schema"].pre('save', function (next) {
        console.log('before save');
        next();
    });
}
mongoose.connect(uri);
for(var i = 0; i < schemas.length; i++) {
    var s = schemas[i];
    mongoose.model(s["name"], s["schema"]);
}
exports.Comment = mongoose.model('Comment');
exports.TestCase = mongoose.model('TestCase');
exports.Submit = mongoose.model('Submit');
exports.Problem = mongoose.model('Problem');
exports.User = mongoose.model('User');

