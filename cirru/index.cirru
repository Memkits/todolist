doctype

html
  head
    title $ = Todo List
    meta $ :charset utf-8
    link (:rel stylesheet) $ :href: css/style.css
    link (:rel icon) (:href png/todolist.png) $ :type image/x-icon
    script $ :src bower_components/vue/dist/vue.js
    script (:defer) $ :src build/build.js
  @partial menu.cirru