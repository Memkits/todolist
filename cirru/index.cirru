
doctype
html
  head
    title
      = Todo List)
    meta
      :charset utf-8
    link
      :rel stylesheet
      :href: page/style.css
    link
      :rel icon
      :href page/todolist.png
      :type image/x-icon
    script
      :defer
      :src build/build.js
  body#app
    @partial menu.cirru