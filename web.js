var express = require('express');

var app = express.createServer(express.logger());

app.get('/', function(req, res) {
    var mes = "<p>hello world?</p>";
    res.render('index.ejs', {locals:{mes:mes}});
});

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});
