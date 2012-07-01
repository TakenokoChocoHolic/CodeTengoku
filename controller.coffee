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
    res.render('debug.ejs', {locals:{mes:"No.#{req.params.id} problem."}})

  app.get '/problem_set', (req, res) ->
    mes = "<p>Problem set!</p>"
    res.render('index.ejs', {locals:{mes:mes}})

  app.get '/funny_api', (req, res) ->
    res.render('funny_api.ejs', {locals:{mes:''}})

  app.get '/debug', (req, res) ->
    console.log(req.query)
    res.render('debug.ejs', {locals:{mes:'debug'}})

  app.post '/problems', (req, res) ->
    problem = new models.Problem
    problem.title = req.body.title
    problem.description = req.body.description
    problem.date = new Date
    res.render('debug.ejs', {locals:{mes:req.body.title}})
