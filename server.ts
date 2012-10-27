var express: any = require('express');
import controller = module('./controller');

var app = express.createServer();
app.configure(() => {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'secret' }));
});

app.dynamicHelpers({
  session: function(req, res) {
    return req.session;
  }
});

controller.start(app);
var port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
