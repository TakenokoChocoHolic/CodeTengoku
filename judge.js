var _ = require('underscore');
var str = require('underscore.string');
_.mixin = str.exports();
var normalize = function (text) {
    return _.trim(text.replace(/(\r\n)/g, '\n').replace(/(\r)/g, '\n'));
};
exports.isCorrect = function (actual, expected) {
    console.log(normalize(expected));
    console.log(normalize(actual));
    return normalize(actual) == normalize(expected);
};

