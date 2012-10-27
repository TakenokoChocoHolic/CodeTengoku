var express: any = require('express');
import controller = module('./controller');

var app = express();
app.configure(() => {
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'secret' }));
});

// for only express 2 (not 3)
app.dynamicHelpers({
    req: function(req, res) {
      return req;
    }
  , session: function(req, res) {
      return req.session;
    }
  , user_id: function(req, res) {
      return req.session.user_id;
    }
});

controller.start(app);
var port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
});
