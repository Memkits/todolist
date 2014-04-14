
body#app
  #menu
    #sidebar
      :class "view-{{view}}"
      .category.now
        :v-on "click: (view='now')"
        span.count (:v-model now.length)
        = "for now"
      .category.my
        :v-on "click: (view='my')"
        span.count (:v-model my.length)
        = "with me"
      .category.work
        :v-on "click: (view='work')"
        span.count (:v-model work.length)
        = "at work"
      .category.done
        :v-on "click: (view='done')"
        span.count (:v-model done.length)
        = "done"

    #list
      @partial now.cirru
      @partial work.cirru
      @partial my.cirru
      @partial done.cirru