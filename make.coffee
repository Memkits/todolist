
require 'shelljs/make'
fs = require 'fs'

{renderer} = require 'cirru-html'

station = require 'devtools-reloader-station'
station.start()

command = (code) -> exec code, async: yes

target.dev = ->
  fs.watch 'coffee', interval: 300, (type, filename) ->
    if type in ['create', 'change']
      exec "coffee -o js/ -bc coffee/#{filename}"
    else
      rm "coffee/#{filename}"
  fs.watch 'js', (type, name) ->
    exec 'browserify -o build/build.js -d js/menu.js', ->
      station.reload 'repo/todolist'

  fs.watch 'cirru/', interval: 200, target.html

target.html = ->
    file = 'cirru/index.cirru'
    render = renderer (cat file), '@filename': file
    render().to 'index.html'
    console.log 'wrote to index.html'
    station.reload 'repo/todolist'