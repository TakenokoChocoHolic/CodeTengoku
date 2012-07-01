var express = require('express');
var mongoose = require('mongoose');

// Define schemas
var Schema = mongoose.Schema;
var commentSchema = new Schema({
    body :String,
    date :Date
});

// Initialize the uri for MongoDB
var uri = process.env.MONGOLAB_URI || 'mongodb://localhost/mongo_data';
console.log(uri);

// Set up a logger for mongoose
commentSchema.pre('init', function(next) {
    console.log('initialized');
    next();
});

commentSchema.pre('save', function(next) {
    console.log('pre save.');
    next();
});

// Connect MongoDB
app.configure(function() {
    //mongodb://[hostname]/[dbname]
    mongoose.connect(uri);
    mongoose.model('Comment', commentSchema);
});

// Initialize model accessors
var Comment = mongoose.model('Comment');

var app = express.createServer(express.logger());

app.get('/', function(req, res) {
    // Add new comment record for testing
    var comment = new Comment();
    comment.body = sanitizedMsg;
    comment.date = date;
    comment.save(function(err) { 
        if ( !err ) console.log('save.');
    });

    var mes = "<p>hello world?</p>";
    res.render('index.ejs', {locals:{mes:mes}});
});


app.get('/problem_set', function(req, res) {
    var mes = "<p>Problem set!</p>";
    res.render('index.ejs', {locals:{mes:mes}});
});

app.get('/funny_api/', function(req, res) {
    res.render('funny_api.ejs', {locals:{mes:''}});
});

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
