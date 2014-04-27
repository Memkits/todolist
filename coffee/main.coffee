
try
  storage = JSON.parse (localStorage.getItem 'todolist')
window.onbeforeunload = ->
  localStorage.setItem 'todolist', (JSON.stringify app.$data)

focusTo = (target) ->
  setTimeout ->
    range = document.createRange()
    sel = window.getSelection()
    range.setStartBefore target
    range.setEndAfter target
    sel.removeAllRanges();
    sel.addRange(range);
    target.focus()
    console.log target

app = menu = new Vue
  el: '#menu'
  data:
    doing: storage.doing or []
    todo: storage.todo or []
    done: storage.done or []
    view: storage.view or 'doing'
  computed: {}
  methods:
    add: ->
      @todo.unshift
        title: ''
        content: ''

      focusTo document.querySelector('#todo .title')

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
