///<reference path='node/node.d.ts' />
var _: any = require('underscore');
var str: any = require('underscore.string');

// Mix in non-conflict functions to Underscore namespace if you want
_.mixin(str.exports());

function normalize(text: string): string {
    return _.trim(text.replace(/(\r\n)/g, '\n').replace(/(\r)/g, '\n'));
}

export function isCorrect(actual, expected) {
  console.log(normalize(expected));
  console.log(normalize(actual));
  return normalize(actual) === normalize(expected);
};
