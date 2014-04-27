#my (:v-if "view == 'my'")
  #add (:v-on "click: newIn('my')") $ = +
  .empty (:v-if "my.length == 0")
    span $ = "Personal list empty"
  .task (:v-repeat my)
    input.title (:v-model title) $ :v-on "keydown: stop"
    input.content (:v-model content) $ :v-on "keydown: stop"
    .handlers
      span.button (:v-on "click: focus('my', $index)") $ = focus
      span.button (:v-on "click: move($index, 'my', 'now')") $ = do