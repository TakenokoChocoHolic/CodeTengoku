var express = require('express');

var app = express.createServer(express.logger());

app.get('/', function(req, res) {
    var mes = "<p>hello world?</p>";
    res.render('index.ejs', {locals:{mes:mes}});
});


app.get('/problem_set', function(req, res) {
    var mes = "<p>Problem set!</p>";
    res.render('index.ejs', {locals:{mes:mes}})
});

app.get('/funny_api/', function(req, res) {
    res.render('funny_api.ejs', {});
});

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
