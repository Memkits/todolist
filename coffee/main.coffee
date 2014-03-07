
Vue = require 'vue'

futures = [
  title: 'title is'
,
  title: 'second '
]
working = []
history = []

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
    addTask: ->
      editorView.$emit 'add'

editorView = new Vue
  el: '#editor'
  data:
    title: ''
    content: ''
    time: ''
    editing: no

editorView.$on 'add', ->
  @$data.title = ''
  @$data.content = ''
  @$data.time = (new Date).toISOString()
  @$data.editing = yes