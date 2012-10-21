models = require './models'
ideone = require './ideone.coffee'
judge = require './judge.coffee'

user = 'exkazuu'
pass = 'almond-choco'

exports.start = (app) ->
  app.get '/', (req, res) ->
    models.Problem.find {}, (err, docs) ->
      console.log 'failed to find Problem.' if err
      res.render('index.ejs', {locals:{
        problems: docs
      }})

  app.get '/problems/new', (req, res) ->
    res.render('new.ejs', {locals:{ }})

  app.post '/problems/new', (req, res) ->
    problem = new models.Problem
      title:       req.body.title
      description: req.body.description
      testCases:   [
        new models.TestCase
          input:       req.body.input
          output:      req.body.output
      ]
      date:        new Date
    problem.save (err) ->
      console.log('failed to save Problem') if err
      res.redirect '/'

  app.get '/problems/:id/edit', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      console.log 'failed to find Problem.' if err
      res.render('edit.ejs', {locals:{problem:problem}})

  app.get '/problems/:id/delete', (req, res) ->
    id = req.params.id
    models.Problem.remove { _id: id }, (err) ->
      console.log 'failed to remove Problem.' if err
      res.redirect "/"

  app.post '/problems/:id/edit', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      console.log 'failed to find Problem.' if err
      problem.description = req.body.description
      problem.input = req.body.input
      problem.output = req.body.output
      problem.save (err) ->
        console.log 'failed to update Problem.' if err
        res.render('edit.ejs', {locals:{problem:problem}})

  app.get '/problems/:id/solve', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      console.log 'failed to find Problem.' if err
      res.render('solve.ejs', {locals:{problem:problem}})

  app.post '/problems/:id/solve', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      console.log 'failed to find Problem.' if err
      ide = new ideone.Ideone(user, pass)
      ide.execute(parseInt(req.body.lang),
        req.body.code, problem.testCases[0].input,
        (success, out) ->
          if !success
            result = 'failed to execute'
          else if judge.isCorrect(req.body.testCases[0].output, out)
            result = 'OK'
          else
            result = 'NG'
          res.render('result.ejs', {locals:{
            result: result,
            out:    out,
            ex:     req.body.output
          }})
      )

  app.get '/debug', (req, res) ->
    console.log "load?"
    models.User.find {}, (err, docs) ->
      console.log "load!"
      console.log(docs)
    res.render('debug.ejs', {locals:{mes:'debug'}})
