$ ->
  if namespace.controller is "creations" and namespace.action is "show"
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
          responseObject = JSON.parse(res)
          comment = $(responseObject.comment_html)
          $("#comment-section").prepend(comment)
          console.log comment.find(".delete-comment-icon")
          attachDeleteClicks(comment.find(".delete-comment-icon"))
        error: (res) ->
          message = JSON.parse(res.responseText).message
          alert(message)

    attachDeleteClicks = (icon) ->
      icon.click ->
        comment = $(this).parents(".comment")
        id = $(this)[0].dataset.id
        $.ajax
          dataType: "text"
          url: "/comments"
          type: "DELETE"
          data:
            id: id
          success: (res) ->
            comment.slideUp(400, -> comment.remove())
          error: (res) ->
            message = JSON.parse(res.responseText).message
            alert(message)

    $(".delete-comment-icon").each ->
      icon = $(this)
      attachDeleteClicks(icon)