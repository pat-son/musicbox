$ ->
  if namespace.controller is "creations" and namespace.action is "new"
    $("#save-creation").click () ->
      if $.isEmptyObject(channelNotes)
        notice = $('<div class="alert alert-danger"></div>')
        message = "You cannout save a song without any notes."
        notice.html(message)
        $(".main-content").prepend(notice)
        setTimeout((-> notice.slideUp()), 5000)
        return
      $.ajax
        dataType: "text"
        url: "/creations"
        type: "POST"
        data:
          data: JSON.stringify(data)
          name: $("#creation-name").val()
        success: (res) ->
          responseObject = JSON.parse(res)
          window.location = responseObject.redirect
        error: (res) ->
          message = JSON.parse(res.responseText).message
          alert(message)