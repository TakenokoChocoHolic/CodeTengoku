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
    res.render('problem.ejs', {locals:{mes:"No.#{req.params.id} problem."}})

  app.get '/problem_set', (req, res) ->
    mes = "<p>Problem set!</p>"
    res.render('index.ejs', {locals:{mes:mes}})

  app.get '/funny_api', (req, res) ->
    res.render('funny_api.ejs', {locals:{mes:''}})
