
window.onbeforeunload = ->
  storage.menu = exports.menu.$data
  delete storage.edit
  localStorage.setItem 'todolist-storage', (JSON.stringify storage)