
app = {}

exports.app = app

try
  storage = JSON.parse (localStorage.getItem 'todolist-storage')

unless storage?
  storage = {}
  storage.editor = 
    id: ''
    title: ''
    content: ''
    time: ''
    editing: no
    action: 'create'
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
  storage.editor = exports.editor.$data
  storage.menu = exports.menu.$data
  localStorage.setItem 'todolist-storage', (JSON.stringify storage)