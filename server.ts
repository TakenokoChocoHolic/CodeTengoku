import express = module('express');
import controller = module('./controller');

var app = express.createServer();
app.configure(() => {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'secret' }));
});

controller.start(app);
var port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
