///<reference path='node/node.d.ts' />

import express = module('express')
import controller = module('./controller')

var app = express.createServer();
app.configure(function() {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
});

controller.start(app);
var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on #{port}\nPress CTRL-C to stop server.");
});