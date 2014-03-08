
app = require './app'
Vue = require 'vue'

app.menu = new Vue
  el: '#menu'
  data: app.get 'menu'
  computed: {}
  methods:
    createTask: (event) ->
      app.editor.$emit 'create'
      event.stopPropagation()
    doWork: (index) ->
      taskList = @$data.futures.splice index, 1
      @$data.working.unshift taskList[0]
    doEditFutures: (index) ->
      app.editor.$emit 'update', @$data.futures[index]
    doFutures: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.futures.unshift taskList[0]
    doEditWorking: (index) ->
      app.editor.$emit 'update', @$data.working[index]
    doHistory: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.history.unshift
        action: 'history'
        title: taskList[0].title
        content: taskList[0].content
        finish: '...'

app.menu.$on 'create', (task) ->
  @$data.working.unshift task

app.menu.$on 'remove', (task) ->
  for value, index in @$data.futures
    if value.id is task.id
      @$data.futures.splice index, 1
  for value, index in @$data.working
    if value.id is task.id
      @$data.working.splice index, 1

app.menu.$on 'update', (task) ->
  for value in @$data.futures
    if value.id is task.id
      value.title = task.title
      value.content = task.content
  for value in @$data.working
    if value.id is task.id
      value.title = task.title
      value.content = task.content
