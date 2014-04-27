#doing (:v-if view=='doing')
  .empty (:v-if doing.length==0)
    span $ = currently free
  .task (:v-repeat doing)
    input.title $ :v-model title
    input.content $ :v-model content
    .handlers
      span.button (:v-on "click: focus($index)") $ = Focus
      span.button (:v-on "click: move($index,'todo')") $ = Delay
      span.button (:v-on "click: move($index,'done')") $ = Done
      span.button.remove (:v-on "click: rm($index)") $ = Del