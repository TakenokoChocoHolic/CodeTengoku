normalize = (text) ->
  text.replace(/(\r\n)/g, '\n').replace(/(\r)/g, '\n')

isCorrect = (actual, expected) ->
  normalize(actual) == normalize(expected)

exports.judge = judge
