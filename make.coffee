
require 'shelljs/make'
command = (code) -> exec code, async: yes

target.dev = ->
  exec 'pkill -f doodle', ->
    command 'doodle index.html build/build.js log:yes'
  command 'jade -o ./ -wP page/index.jade'
  command 'coffee -o src/ -wbc coffee/'
  command 'watchify -o build/build.js -d src/main.js -v'