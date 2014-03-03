
require 'shelljs/make'

target.dev = ->
  exec 'pkill -f doodle', ->
    exec 'doodle index.html build/build.js log:yes', async: yes
  exec 'jade -o index.html', async: yes
  exec 'coffee -o src/ -wbc coffee/', async: yes
  exec 'watchify -o build/build.js -d src/main.js -v', async: yes