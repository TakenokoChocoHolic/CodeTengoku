models = require './models'
ideone = require './ideone.coffee'

user = 'exkazuu'
pass = 'almond-choco'

exports.start = (app) ->
  app.get '/', (req, res) ->
    # Add new comment record for testing
    comment = new models.Comment()
    comment.body = "test"
    comment.date = new Date
    console.log(comment)
    comment.save (err) ->
      console.log('save.') if !err

    problems = [1, 2, 3, 4, 5]
    mes = "<p>hello world?</p>"

    res.render('index.ejs', {locals:{
        mes:mes,
        problems:problems
    }})


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

  app.post '/problems/:id/run', (req, res) ->
    ide = new ideone.Ideone(user, pass);
    ide.execute(4,
                req.body.code,
                req.body.input,
                (success, out) ->
                        if !success
                            result = "fail"
                            return
                        if req.body.output == out
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

  app.get '/funny_api', (req, res) ->
    res.render('funny_api.ejs', {locals:{mes:''}})

  app.get '/debug', (req, res) ->
    console.log "load?"
    models.User.find {}, (err, docs) ->
      console.log "load!"
      console.log(docs)
    res.render('debug.ejs', {locals:{mes:'debug'}})

  app.post '/problems', (req, res) ->
    problem = new models.Problem
    problem.title = req.body.title
    problem.description = req.body.description
    problem.date = new Date
    console.log(problem)
    problem.save (err) ->
      console.log('save failed')
    res.render('debug.ejs', {locals:{mes:req.body.title}})
