
#done (:v-if view=='done')
  .task (:v-repeat done)
    .title $ :v-model "$value"
    .handlers $ span.button.remove
      :v-on "click:rm($index)"
      = Del
  .empty (:v-if done.length==0) $ span $ = "It is empty"