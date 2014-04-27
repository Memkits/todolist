
try
  storage = JSON.parse (localStorage.getItem 'todolist')
window.onbeforeunload = ->
  localStorage.setItem 'todolist', (JSON.stringify storage)

Vue.directive 'focus-editable',
  bind: -> setTimeout =>
    range = document.createRange()
    sel = window.getSelection()
    target = @el
    range.setStartBefore target
    range.setEndAfter target
    sel.removeAllRanges();
    sel.addRange(range);
    @el.focus()

menu = new Vue
  el: '#menu'
  data:
    now: storage.now or []
    my: storage.my or []
    work: storage.work or []
    done: storage.done or []
    view: storage.view or 'my'
  computed: {}
  methods:
    newIn: (target) ->
      @[target].unshift
        title: ''
        content: ''
        from: target
    move: (index, from, target) ->
      task = @[from].splice(index, 1)[0]
      @[target].unshift task

    focus: (target, index) ->
      task = @[target].splice(index, 1)[0]
      @[target].unshift task

    rm: (target, index) ->
      @[target].splice index, 1

    stop: (event) ->
      event.preventDefault()
      console.log 'stop'