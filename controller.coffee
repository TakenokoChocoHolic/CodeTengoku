models = require './models'
ideone = require './ideone.coffee'
judge = require './judge.coffee'
$ = require 'JQDeferred'

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
    input = []
    output = []
    for i in [1..10]
      console.log req.body['output1']?
      if req.body['output' + i]?
        input.push req.body['input' + i]
        output.push req.body['output' + i]
      else
        break

    testCases = []
    for i in [0..output.length - 1]
      testCase = new models.TestCase(input: input[i], output: output[i])
      console.log testCase
      testCase.save (err) ->
        console.log()
      testCases.push testCase
     # input = (req.body["input" + i] for i in [1..10] if req.body["input" + i])
    # output = (req.body["output" + i] for i in [1..10] if req.body["output" + i])
    console.log testCases

    problem = new models.Problem
      title:       req.body.title
      description: req.body.description
      date:        new Date
    console.log problem
    problem.save (err) ->
      console.log('failed to save Problem') if err
      models.Problem.findById problem.id, (err, problem) ->
        console.log problem
        res.redirect '/'

  app.get '/problems/:id/edit', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      console.log problem
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
      judgeDeferred = (iTestCases) ->
        dfd = $.Deferred()
        ide.execute(parseInt(req.body.lang),
          req.body.code, problem.testCases[iTestCases].input,
          (success, out) ->
            return dfd.resolve("out") if success else dfd.reject()
            if !success
              result = 'failed to execute'
            else if judge.isCorrect(out, problem.testCases[iTestCases].output)
              result = 'OK'
            else
              result = 'NG'
            res.render('result.ejs', {locals:{
              result: result,
              out:    out,
              ex:     req.body.output
            }})
        )
        dfd.promise()
      $.when(judgeDeferred(0))
        .done (out1) -> console.log(out1)
        .fail -> console.log("fail")

  app.get '/debug', (req, res) ->
    console.log "load?"
    models.User.find {}, (err, docs) ->
      console.log "load!"
      console.log(docs)
    res.render('debug.ejs', {locals:{mes:'debug'}})

  app.get '/login', (req, res) ->
    res.render('login.ejs', {locals:{ }})

  app.post '/login', (req, res) ->
    req.session.user_id = req.body.user_id
    res.redirect('/')

  app.get '/logout', (req, res) ->
    delete req.session.user_id
    res.redirect('/')
