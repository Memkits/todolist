
try
  storage = JSON.parse (localStorage.getItem 'todolist')

focusTo = (target) ->
  range = document.createRange()
  sel = window.getSelection()
  range.setStartBefore target
  range.setEndAfter target
  sel.removeAllRanges();
  sel.addRange(range);
  target.focus()

app = new Vue
  el: '#app'
  data:
    doing: storage.doing or []
    todo: storage.todo or []
    done: storage.done or []
    view: storage.view or 'doing'
  computed: {}
  methods:
    add: ->
      @[@view].unshift ''
      setTimeout ->
        focusTo document.querySelector('#list .title')

    move: (index, target) ->
      task = @[@view].splice(index, 1)[0]
      @[target].unshift task

    focus: (index) ->
      task = @[@view].splice(index, 1)[0]
      @[@view].unshift task

    rm: (index) ->
      @[@view].splice index, 1

    stop: (event) ->
      event.preventDefault()
      console.log 'stop'

save = ->
  localStorage.setItem 'todolist', (JSON.stringify app.$data)
window.onbeforeunload = save
window.onblur = save

window.onkeydown = (event) ->
  if event.keyCode is 65
    if document.activeElement.id is 'app'
      app.add()