
#done (:v-if view=='done')
  .record (:v-repeat done)
    .title $ :v-model title
    .content $ :v-model content
    .handlers $ span.button.remove
      :v-on "click:rm($index)"
      = Del
  .empty (:v-if done.length==0) $ span $ = "It is empty"