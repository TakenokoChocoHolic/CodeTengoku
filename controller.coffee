models = require './models'

exports.start = (app) ->
  app.get '/', (req, res) ->
    # Add new comment record for testing
    comment = new models.Comment()
    comment.body = "test"
    comment.date = new Date
    console.log(comment)
    comment.save (err) ->
      console.log('save.') if !err

    mes = "<p>hello world?</p>"
    res.render('index.ejs', {locals:{mes:mes}})

  app.get '/login', (req, res) ->
    res.render('login.ejs', {locals:{mes:''}})

  app.get '/problem', (req, res) ->
    res.render('problem.ejs', {locals:{mes:''}})

  app.get '/problem/:id', (req, res) ->
    problem =
      id : req.params.id
      title : "problem title"
      description_text : "explain the problem"
      first_message : "write your code"
      input : "1 2"
      output : "3"
    res.render('problem.ejs', {locals:{problem:problem}})

  app.get '/problem_set', (req, res) ->
    mes = "<p>Problem set!</p>"
    res.render('index.ejs', {locals:{mes:mes}})

  app.get '/funny_api', (req, res) ->
    res.render('funny_api.ejs', {locals:{mes:''}})
