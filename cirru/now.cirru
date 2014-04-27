#now (:v-if "view == 'now'")
  .empty (:v-if "now.length == 0")
    span $ = currently free
  .task (:v-repeat now)
    input.title (:v-model title) $ :v-on "keydown: stop | key enter"
    input.content (:v-model content) $ :v-on "keydown: stop | key enter"
    .handlers
      span.button (:v-on "click: focus('now', $index)") $ = focus
      span.button (:v-on "click: move($index, 'now', from)") $ = delay
      span.button (:v-on "click: move($index, 'now', 'done')") $ = done
      span.button.remove (:v-on "click: rm('now', $index)") $ = del