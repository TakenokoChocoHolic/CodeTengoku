assert = require 'assert'

user = 'exkazuu'
pass = 'almond-choco'

describe "Ideone", ->
  ideone = require '../ideone.coffee'

  describe '#constructor()', ->
    it 'should return a object', ->
      assert.notEqual new ideone.Ideone(user, pass), null

  describe '#isAvailable()', ->
    it 'should be available', (done) ->
      ide = new ideone.Ideone(user, pass)
      ide.isAvailable (success) ->
        assert.equal success, true
        done()

  describe '#execute()', ->
    it 'should execute Python code', ->
      ide = new ideone.Ideone(user, pass)
      ide.execute 4, "print 'it works!'", "", (success, output) ->
        assert.equal output, 'it works!'
        done()
