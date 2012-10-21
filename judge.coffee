_  = require 'underscore'

# Import Underscore.string to separate object, because there are conflict functions (include, reverse, contains)
_.str = require 'underscore.string'

# Mix in non-conflict functions to Underscore namespace if you want
_.mixin _.str.exports()

normalize = (text) ->
  _.trim text.replace(/(\r\n)/g, '\n').replace(/(\r)/g, '\n')

isCorrect = (actual, expected) ->
  normalize(actual) == normalize(expected)

exports.isCorrect = isCorrect
