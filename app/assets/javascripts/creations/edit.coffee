$ ->
  if namespace.controller is "creations" and namespace.action is "edit"
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
        url: "/creations/" + namespace.id
        type: "PATCH"
        data:
          data: JSON.stringify(data)
          name: $("#creation-name").val()
        success: (res) ->
          flashMessage("Creation saved successfully.", "success", 2500)
        error: (res) ->
          message = JSON.parse(res.responseText).message
          flashMessage(message, "danger", 5000)