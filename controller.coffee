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

  app.get '/problems/:id/edit', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      res.render('edit.ejs', {locals:{problem:problem}})

  app.get '/problems/:id/delete', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err) ->
      res.redirect "/"

  app.post '/problems/:id/edit', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      problem.description = req.body.description
      problem.input = req.body.input
      problem.output = req.body.output
      problem.save (err) ->
        console.log('edit failed') if err
      res.render('edit.ejs', {locals:{problem:problem}})

  app.get '/problems/:id/solve', (req, res) ->
    id = req.params.id
    models.Problem.findById id, (err, problem) ->
      res.render('solve.ejs', {locals:{problem:problem}})

  app.post '/problems/:id/solve', (req, res) ->
    ide = new ideone.Ideone(user, pass);
    ide.execute(parseInt(req.body.lang),
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



