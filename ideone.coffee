rpc = require './jsonrpc'
sys = require 'sys'

class JsonRpcWrapper
  constructor: ->
    @client = rpc.getClient(80, 'ideone.com')
    @path = '/api/1/service.json'
    @call = (method, params, callback) ->
      @client.call(method, params, callback, null, @path)

class Ideone
  constructor: (@user, @pass) ->
    @client = rpc.getClient(80, 'ideone.com')
    @path = '/api/1/service.json'

  call: (method, params, callback) ->
    @client.call(method, params, callback, null, @path)

  isAvailable: (callback) ->
    @call 'testFunction', [@user, @pass], (error, result) ->
      callback(result['error'] == 'OK')

  wait: ->
    wait = => @wait()
    @call 'getSubmissionStatus', [@user, @pass, @link], (error, result) =>
      if result['status'] != 0
        setTimeout(wait, 1000)
      else
        @details()

  details: ->
    @call 'getSubmissionDetails', [@user, @pass, @link, false, false, true, true, true], (error, result) =>
      @callback(true, result['output'])

  execute: (language, source, input, callback) ->
    @callback = callback
    @link = ''
    @call 'createSubmission', [@user, @pass, source, language, input, true, false], (error, result) =>
      if result['error'] == 'OK'
        @link = result['link']
        @wait()
      else
        console.log('failed to invoke createSubmission: ' + result['error'])
        callback(false, '')

exports.Ideone = Ideone
