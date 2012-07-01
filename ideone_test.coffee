ideone = require './ideone.coffee'

user = 'exkazuu'
pass = 'almond-choco'

ide = new ideone.Ideone(user, pass)
ide.isAvailable (success) ->
  console.log(success)

ide.execute 4, 'print \'it works!\'', '', (success, output) ->
  console.log(success)
  console.log(output)
