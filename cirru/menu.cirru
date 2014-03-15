
#menu
  :class mode-{{mode}}

  #futures
    .cover
      :v-on "click: mode='futures'"
      :v-show "mode != 'futures'"
      .text
        span.count
          :v-model futures.length
        span
          = futures Tasks
    .list
      :v-show "mode == 'futures'"
      .task
        :v-repeat futures
        .title
          :v-model title
        .content
          :v-model content
        .handlers
          span.button
            :v-on "click: doFocusFutures($index)"
            = focus
          span.button
            :v-on= "click: doWork($index)"
            = work
      .empty
        :v-show "futures.length == 0"
        span
          = futures is empty

  #working
    .cover
      :v-on "click: mode='working'"
      :v-show "mode != 'working'"
      .text
        span.count
          :v-model working.length
        span
          = working tasks
    .list
      :v-show "mode == 'working'"
      #task-creator
        #add
          :v-on click:createTask
          = +
      .task
        :v-repeat working
        .title
          :v-model title
          :contenteditable
          :v-focus-editable
        .content
          :v-model content
          :contenteditable
        .handlers
          span.button
            :v-on "click: doFocus($index)"
            = focus
          span.button
            :v-on "click: doFutures($index)"
            = futures
          span.button
            :v-on "click: doHistory($index)"
            = history
          span.button
            :v-on "click: doRemove($index)"
            = remove
      .empty
        :v-show "working.length == 0"
        span $ = working is empty

  #history
    .cover
      :v-on "click: mode='history'"
      :v-show "mode != 'history'"
      .text
        span.count
          :v-model history.length
        span $ = history records
    .list
      :v-show "mode == 'history'"
      .record
        :v-repeat history
        .action (:v-model action)
        .title (:v-model title)
        .content (:v-model content)
      .empty
        :v-show "history.length == 0"
        span $ = history is empty