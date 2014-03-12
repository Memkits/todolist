
app = require './app'
Vue = require 'vue'

app.menu = new Vue
  el: '#menu'
  data: app.get 'menu'
  computed: {}
  methods:
    createTask: (event) ->
      @$data.working.unshift
        title: '..'
        content: '...'
      event.stopPropagation()
    doWork: (index) ->
      taskList = @$data.futures.splice index, 1
      @$data.working.unshift taskList[0]
    doFutures: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.futures.unshift taskList[0]
    doHistory: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.history.unshift
        action: 'history'
        title: taskList[0].title
        content: taskList[0].content
        finish: '...'
      @$data.history.splice 40
    doFocus: (index) ->
      taskList = @$data.working.splice index, 1
      @$data.working.unshift taskList[0]
    doRemove: (index) ->
      @$data.working.splice index, 1
