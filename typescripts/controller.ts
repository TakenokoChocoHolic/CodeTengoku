import models = module('models');
import ideone = module('ideone');
import judge = module('judge');
var jqd: any = require('JQDeferred');

var user = 'exkazuu';
var pass = 'almond-choco';

export function start(app) {
    app.get('/', (req, res) => {
        models.Problem.find({}, (err, docs) => {
            if (err) console.log('failed to find Problem.');
            res.render('index.ejs', {locals:{ problems: docs }});
        });
    });

    app.get('/problems/new', (req, res) =>
        res.render('new.ejs', {locals:{ }});
    );

    app.post('/problems/new', (req, res) => {
        var problem = new models.Problem({
            title:       req.body.title,
            description: req.body.description,
            date:        new Date()
        });

        var inOuts = [];
        for (var i=1; i<=10; i++) {
            if (req.body['output' + i] != "") {
                inOuts.push([req.body['input' + i], req.body['output' + i]]);
            }
        }

        for (var i=0; i<inOuts.length-1; i++) {
            var testCase = new models.TestCase({input: inOuts[i][0], output: inOuts[i][1]});
            console.log(testCase);
            problem.testCases.push(testCase);
        }

        problem.save((err) => {
            if (err) console.log('failed to save Problem');
            models.Problem.findById(problem.id, (err, problem) => {
                console.log(problem);
                res.redirect('/');
            });
        });
    });

    app.get('/problems/:id/edit', (req, res) => {
        var id = req.params.id;
        models.Problem.findById(id, (err, problem) => {
            console.log(problem);
            if (err) console.log('failed to find Problem.');
            res.render('edit.ejs', {locals:{problem:problem}});
        });
    });

    app.get('/problems/:id/delete', (req, res) => {
        var id = req.params.id;
        models.Problem.remove({ _id: id }, (err) => {
            if (err) console.log('failed to remove Problem.');
            res.redirect("/");
        });
    });

    app.post('/problems/:id/edit', (req, res) => {
        var id = req.params.id;
        models.Problem.findById(id, (err, problem) => {
            if (err) console.log('failed to find Problem.');
            problem.description = req.body.description;
            problem.input = req.body.input;
            problem.output = req.body.output;
            problem.save((err) => {
                if (err) console.log('failed to update Problem.');
                res.render('edit.ejs', {locals:{problem:problem}});
            });
        });
    });

    app.get('/problems/:id/solve', (req, res) => {
        var id = req.params.id;
        models.Problem.findById(id, (err, problem) => {
            if (err) console.log('failed to find Problem.');
            res.render('solve.ejs', {locals:{problem:problem}});
        });
    });

    app.post('/problems/:id/solve', (req, res) => {
        var id = req.params.id;
        models.Problem.findById(id, (err, problem) => {
            if (err) console.log('failed to find Problem.');
            var ide = new ideone.Ideone(user, pass);
            var judgeDeferred = (iTestCases) => {
                var dfd = jqd.Deferred()
                ide.execute(parseInt(req.body.lang),
                    req.body.code, problem.testCases[iTestCases].input,
                    (success, out) => {
                        if (success) {
                            return dfd.resolve("out");
                        } else {
                            dfd.reject();
                        }
                        var result;
                        if (!success) {
                            result = 'failed to execute';
                        } else if (judge.isCorrect(out, problem.testCases[iTestCases].output)) {
                            result = 'OK';
                        } else {
                            result = 'NG';
                        }
                        res.render('result.ejs', {locals:{
                            result: result,
                            out:    out,
                            ex:     req.body.output
                        }});
                    }
                );
                return dfd.promise();
            };
            jqd.when(judgeDeferred(0))
                .done((out1) => console.log(out1))
                .fail(() => console.log("fail"))
        });
    });

    app.get('/debug', (req, res) => {
        console.log("load?");
        models.User.find({}, (err, docs) => {
            console.log("load!");
            console.log(docs);
        });
        res.render('debug.ejs', {locals:{mes:'debug'}});
    });

    app.get('/login', (req, res) => {
        res.render('login.ejs', {locals:{ }});
    });

    app.post('/login', (req, res) => {
        req.session.user_id = req.body.user_id;
        res.redirect('/');
    });

    app.get('/logout', (req, res) => {
        delete req.session.user_id;
    });
}
