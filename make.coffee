
require 'shelljs/make'
command = (code) -> exec code, async: yes
fs = require 'fs'
net = require 'net'

station = require 'devtools-reloader-station'

station.start()

target.dev = ->
  exec 'pkill -f doodle', ->
    command 'doodle index.html build/build.js log:yes'
  fs.watch 'view', interva: 300, ->
    exec 'jade -o ./ view/index.jade'
  fs.watch 'coffee', interval: 300, (type, filename) ->
    if type in ['create', 'change']
      exec "coffee -o src/ -bc coffee/#{filename}"
    else
      rm "coffee/#{filename}"
  fs.watch 'src', (type, name) ->
    exec 'browserify -o build/build.js -d src/menu.js', ->
      station.reload 'repo/todolist'