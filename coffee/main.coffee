
Vue = require 'vue'

try
  futures = JSON.parse (localStorage.getItem 'futures')
  working = JSON.parse (localStorage.getItem 'working')
  history = JSON.parse (localStorage.getItem 'history')

futures ?= []
working ?= []
history ?= []

genId = -> (new Date).getTime().toString()

Vue.filter 'oppsite', (value) ->
  not value

app = {}

app.menuView = menuView = new Vue
  el: '#menu'
  data:
    futures: futures
    working: working
    history: history
    mode: 'working'
  computed: {}
  methods:
    createTask: (event) ->
      app.editorView.$emit 'create'
    doWork: (index) ->
      taskList = @$data.futures.splice index, 1
      @$data.working.unshift taskList[0]
    doEditFutures: (index) ->
      app.editorView.$emit 'update', @$data.futures[index]
    doFutures: (index) ->
      taskList = @$data.working.splice index, 1
      console.log taskList[0]
      @$data.futures.unshift taskList[0]
    doEditWorking: (index) ->
      app.editorView.$emit 'update', @$data.working[index]
    doHistory: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.history.unshift
        action: 'history'
        title: taskList[0].title
        content: taskList[0].content
        finish: '...'

app.editorView = editorView = new Vue
  el: '#editor'
  data:
    id: 'default'
    title: ''
    content: ''
    time: ''
    editing: no
    action: 'create'
  computed: {}
  methods:
    updateTask: ->
      menuView.$emit 'update',
        id: @id
        title: @title
        content: @content
        time: @time
      @editing = no
    removeTask: ->
      task =
        id: @id
      menuView.$emit 'remove', task
      @editing = no
    createTask: ->
      menuView.$emit 'create',
        id: @id
        title: @title
        content: @content
        time: @time
      @editing = no
    dismiss: ->
      @editing = no

editorView.$on 'create', ->
  @$data.title = ''
  @$data.id = genId()
  @$data.content = ''
  @$data.time = (new Date).toISOString()
  @$data.editing = yes
  @$data.action = 'create'

editorView.$on 'update', (task) ->
  @$data.title = task.title
  @$data.content = task.content
  @$data.id = task.id
  @$data.time = (new Date).toISOString()
  @$data.editing = yes
  @$data.action = 'update'
  console.log 'editing is', @$data.editing

menuView.$on 'create', (task) ->
  @$data.working.unshift task

menuView.$on 'remove', (task) ->
  for value, index in @$data.futures
    if value.id is task.id
      @$data.futures.splice index, 1
  for value, index in @$data.working
    if value.id is task.id
      @$data.futures.splice index, 1

menuView.$on 'update', (task) ->
  for value in @$data.futures
    if value.id is task.id
      value.title = task.title
      value.content = task.content
  for value in @$data.working
    if value.id is task.id
      value.title = task.title
      value.content = task.content

window.onbeforeunload = ->
  localStorage.setItem 'futures', (JSON.stringify futures)
  localStorage.setItem 'working', (JSON.stringify working)
  localStorage.setItem 'history', (JSON.stringify history)