
Vue = require 'vue'

futures = [
  title: 'title is'
,
  title: 'second '
]
working = []
history = []

genId = (new Date).getTime().toString()

Vue.filter 'oppsite', (value) ->
  not value

menuView = new Vue
  el: '#menu'
  data:
    futures: futures
    working: working
    history: history
    mode: 'working'
  computed:
    futuresLength:
      $get: -> @futures.length
    workingLength:
      $get: -> @working.length
    historyLength:
      $get: -> @history.length
    isFutures: ->
      @mode is 'futures'
    isWorking: ->
      @mode is 'working'
    isHistory: ->
      @mode is 'history'
  methods:
    switchFutures: ->
      @mode = 'futures'
    switchWorking: (event) ->
      @mode = 'working'
    switchHistory: ->
      @mode = 'history'
    createTask: (event) ->
      editorView.$emit 'add'

editorView = new Vue
  el: '#editor'
  data:
    id: 'default'
    title: ''
    content: ''
    time: ''
    editing: no
    action: 'add'
  computed:
    isEditing:
      $get: ->
        @action isnt 'add'
  methods:
    updateTask: ->
      task =
        id: @id
        title: @title
        content: @content
        time: @time
      menuView.$emit 'update', task
      @editing = no
    removeTask: ->
      task =
        id: @id
      menuView.$emit 'remove', task
      @editing = no
    createTask: ->
      task =
        id: @id
        title: @title
        content: @content
        time: @time
      menuView.$emit 'create', task
      @editing = no
    dismiss: ->
      @editing = no

editorView.$on 'add', ->
  @$data.title = ''
  @$data.content = ''
  @$data.time = (new Date).toISOString()
  @$data.editing = yes
  @$data.action = 'add'
