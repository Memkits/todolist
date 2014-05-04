
#todo (:v-if view=='todo')
  #add (:v-on "click: add()") $ = +
  .empty (:v-if doing.length==0) $ span $ = "Personal list is empty"
  .task (:v-repeat todo)
    input.title $ :v-model title
    input.content $ :v-model content
    .handlers
      span.button
        :v-on "click: move($index,'doing')"
        = Do
      span.button
        :v-on "click: move($index,'done')"
        = Done
      span.button
        :v-on "click: focus($index)"
        = Focus
      span.button.remove
        :v-on "click: rm($index)"
        = Del