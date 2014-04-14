
doctype
html
  head
    title
      = Todo List
    meta
      :charset utf-8
    link
      :rel stylesheet
      :href: css/style.css
    link
      :rel icon
      :href png/todolist.png
      :type image/x-icon
    script
      :defer
      :src build/build.js
  body#app
    @partial menu.cirru