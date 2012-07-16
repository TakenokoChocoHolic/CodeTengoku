models = require './models'
ideone = require './ideone.coffee'

user = 'exkazuu'
pass = 'almond-choco'

exports.start = (app) ->
  app.get '/', (req, res) ->
    models.Problem.find {}, (err, docs) ->
      mes = "<p>hello world?</p>"
      problems = docs
      res.render('index.ejs', {locals:{
          mes:mes,
          problems:problems
      }})

  app.get '/login', (req, res) ->
    res.render('login.ejs', {locals:{mes:''}})

  app.get '/problem', (req, res) ->
    res.render('problem.ejs', {locals:{mes:''}})

  app.get '/problem/:id', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, docs) ->
      res.render('problem.ejs', {locals:{problem:docs}})

  app.post '/problems/:id/run', (req, res) ->
    ide = new ideone.Ideone(user, pass);
    ide.execute(4,
                req.body.code,
                req.body.input,
                (success, out) ->
                        if !success
                            result = "fail"
                            return
                        if req.body.output.replace(/\s+$/, '') == out.replace(/\s+$/, '')
                            result = "ok"
                        else
                            result = "ng"
                        res.render('result.ejs', {locals:{
                                result:result,
                                out:out
                                ex:req.body.output
                        }})
                )

  app.get '/problem_set', (req, res) ->
    mes = "<p>Problem set!</p>"
    res.render('index.ejs', {locals:{mes:mes}})

  app.get '/debug', (req, res) ->
    console.log "load?"
    models.User.find {}, (err, docs) ->
      console.log "load!"
      console.log(docs)
    res.render('debug.ejs', {locals:{mes:'debug'}})

  app.post '/problems', (req, res) ->
    problem = new models.Problem
      title:       req.body.title
      description: req.body.description
      input:       req.body.input
      output:      req.body.output
      date:        new Date
    problem.save (err) ->
      console.log('save failed') if err
    res.render('debug.ejs', {locals:{mes:req.body.title}})
