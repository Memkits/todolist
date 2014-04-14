
app = {}

exports.app = app

try
  storage = JSON.parse (localStorage.getItem 'todolist-storage')

unless storage?
  storage = {}
  storage.menu = 
    futures: []
    working: []
    history: []
    mode: 'working'

exports.get = (key) ->
  storage[key]
exports.set = (key, value) ->
  storage[key] = value

window.onbeforeunload = ->
  storage.menu = app.menu.$data
  delete storage.edit
  localStorage.setItem 'todolist-storage', (JSON.stringify storage)