ready = ->
  $("#blog_content").keyup ->
    $("p#length_check").html(count_length)
    
  count_length = ->
    msg = $("#blog_content").val().replace(/(\r\n|\r|\n)/g, "").length + "文字"
    return msg
    
$(document).ready(ready)
$(document).on('turbolinks:load', ready)