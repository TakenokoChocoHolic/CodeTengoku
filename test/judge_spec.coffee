assert = require 'assert'

describe 'judge', ->
  judge = require '../judge.coffee'

  describe '#isCorrect()', ->
    it 'should return true', ->
      assert.equal judge.isCorrect("1", "1"), true
