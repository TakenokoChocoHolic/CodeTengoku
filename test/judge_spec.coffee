assert = require 'assert'

describe 'judge', ->
  judge = require '../judge.coffee'

  describe '#isCorrect()', ->
    it 'should return true', ->
      assert.equal judge.isCorrect("1", "1"), true
      assert.equal judge.isCorrect("1\r\n2", "1\r2\r\n"), true
      assert.equal judge.isCorrect("1\r\n\r\n", "1"), true
