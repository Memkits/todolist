#work (:v-if "view == 'work'")
  #add (:v-on "click: newIn('work')") $ = +
  .empty (:v-if "work.length == 0")
    span $ = No work tasks
  .task (:v-repeat work)
    input.title (:v-model title) $ :v-on "keydown: stop | key enter"
    input.content (:v-model content) $ :v-on "keydown: stop | key enter"
    .handlers
      span.button (:v-on "click: focus('work', $index)") $ = focus
      span.button (:v-on= "click: move($index, 'work', 'now')") $ = work