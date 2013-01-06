
log = -> console?.log?.apply? console, arguments
delay = (f, t) -> setTimeout t, f
q = (query) -> document.querySelector query

tasks = []
view = ""
prepare = ""

read_time = ->
  now = new Date
  m = now.getMonth() + 1
  d = now.getDate()
  h = now.getHours()
  mm = now.getMinutes()
  "#{m}-#{d} #{h}:#{mm}"

get_time = -> new Date().getTime().toString()

update = ->
  localStorage.tasks = JSON.stringify tasks
  count = 0
  for key, value of tasks
    if value.status.match /wait/
      count += 1
  if count > 20
    (q "#outline").innerText = "As many as #{count} tasks here"
  else if count > 1
    (q "#outline").innerText = "You have #{count} tasks left"
  else if count is 1
    (q "#outline").innerText = "Last #{count} tasks"
  else
    (q "#outline").innerText = "Great!"
  (q "title").innerText = "#{count} left"

load_task = ->
  try
    tasks = JSON.parse localStorage.tasks
  catch err
    tasks = {}
  update()
  tasks

make_item = (data) ->
  lilyturf.dom ->
    @div class: "task", id: data.id,
      @div class: "title", (@text data.title)
      @div class: "more",
        @span {}, (@text data.time)
        if data.tag? then @span {}, (@text data.tag)
        if data.status.match(/wait/)?
          @span class: "done", (@text "done")
        else if data.status.match(/done/)?
          @span class: "failed", (@text "failed")
        @span class: "detail", (@text "detail")

viewing = (elem) ->
  last = q ".viewing"
  if last?
    last.className = ""
  elem.className = "viewing"

window.onload = ->
  load_task()
  todo = q "#todo"
  tags = q "#tags"
  editor = q "#editor"

  title = q "#title"
  tag = q "#tag"
  content = q "#content"

  save = q "#save"
  cancel = q "#cancel"
  all = q "#all"
  done = q "#done"
  add = q "#add"
  wait = q "#wait"
  search = q "#search"

  save_task = ->
    data =
      title: title.value.trim()
      tag: tag.value.trim()
      content: content.value.trim()
      id: prepare
      time: read_time()
      status: "wait"

    if data.title.length > 3
      tasks[data.id] = data
      update()
      render /wait/
      editor.style.left = "-540px"

      title.value =  ""
      tag.value = ""
      content.value = ""

  render = (query) ->
    todo.innerHTML = ""
    for key, data of tasks
      if data.status.match query
        todo.appendChild (make_item data)

    if todo.innerHTML.trim() is ""
      todo.appendChild lilyturf.dom ->
        @div class: "empty", (@text "Empty")

  filter_tag = (query) ->
    todo.innerHTML = ""
    for key, data of tasks
      if data.title.match query
        todo.appendChild (make_item data)
      else if data.tag.match query
        todo.appendChild (make_item data)
      else if data.content.match query
        todo.appendChild (make_item data)

    if todo.innerHTML.trim() is ""
      todo.appendChild lilyturf.dom ->
        @div class: "empty", (@text "Empty")

  edit_item = (data) ->
    log data
    prepare = data.id
    title.value = data.title
    tag.value = data.tag
    content.value = data.content
    editor.style.left = "0px"

  save.onclick = ->
    save_task()
  all.onclick = ->
    viewing @
    view = "all"
    render //
    editor.style.left = "-540px"
  done.onclick = ->
    viewing @
    view = "done"
    render /done/
    editor.style.left = "-540px"
  add.onclick = ->
    prepare = get_time()
    title.value = ""
    tag.value = ""
    content.value = ""
    editor.style.left = "0px"
    (q "#title").focus()
  cancel.onclick = ->
    editor.style.left = "-540px"
  wait.onclick = ->
    viewing @
    view = "wait"
    render /wait/
  search.addEventListener "input", ->
    filter_tag (RegExp @value)
  wait.click()

  todo.onclick = (click) ->
    elem = click.target
    if elem.className is "done"
      id = elem.parentNode.parentNode.id
      tasks[id].status = "done"
      update()
      render /wait/
    else if elem.className is "failed"
      id = elem.parentNode.parentNode.id
      tasks[id].status = "wait"
      update()
      render /wait/
    else if elem.className is "detail"
      id = elem.parentNode.parentNode.id
      prepare = get_time()
      edit_item tasks[id]
      (q "#title").focus()