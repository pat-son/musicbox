$ ->
  if namespace.controller is "creations" and namespace.action is "show"
    console.log("Show creation")

    $("#post-comment").click ->
      content = $("#comment-box").val()
      $.ajax
        dataType: "text"
        url: "/comments/create"
        type: "POST"
        data:
          content: content
          creation_id: namespace.id
        success: (res) ->
          $("#comment-box").val("")
          console.log res
          responseObject = JSON.parse(res)
          comment = $(responseObject.comment_html)
          $("#comment-section").prepend(comment)
        error: (res) ->
          message = JSON.parse(res.responseText).message
          alert(message)