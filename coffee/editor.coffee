
app = require './app'
Vue = require 'vue'

genId = -> (new Date).getTime().toString()

Vue.directive 'autofocus',
  update: (editing) ->
    if editing then setTimeout =>
        @el.focus()

app.editor = new Vue
  el: '#editor'
  data: app.get 'editor'
  computed: {}
  methods:
    updateTask: ->
      app.menu.$emit 'update',
        id: @id
        title: @title
        content: @content
        time: @time
      @editing = no
    removeTask: ->
      task =
        id: @id
      app.menu.$emit 'remove', task
      @editing = no
    createTask: ->
      app.menu.$emit 'create',
        id: @id
        title: @title
        content: @content
        time: @time
      @editing = no
    dismiss: ->
      @editing = no


app.editor.$on 'create', ->
  @$data.title = ''
  @$data.id = genId()
  @$data.content = ''
  @$data.time = (new Date).toISOString()
  @$data.editing = yes
  @$data.action = 'create'

app.editor.$on 'update', (task) ->
  @$data.title = task.title
  @$data.content = task.content
  @$data.id = task.id
  @$data.time = (new Date).toISOString()
  @$data.editing = yes
  @$data.action = 'update'
