var _: any = require('underscore');
var str: any = require('underscore.string');

// Mix in non-conflict functions to Underscore namespace if you want
_.mixin = str.exports();

var normalize = (text) => _.trim(text.replace(/(\r\n)/g, '\n').replace(/(\r)/g, '\n'));

export var isCorrect = (actual, expected) => {
  console.log(normalize(expected));
  console.log(normalize(actual));
  return normalize(actual) == normalize(expected);
};

