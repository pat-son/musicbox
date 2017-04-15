$ ->
  if namespace.controller is "creations" and namespace.action is "new"
    $("#save-creation").click () ->
      $.ajax
        dataType: "text"
        url: "/creations"
        type: "POST"
        data:
          data: JSON.stringify(data)
          name: $("#creation-name").val()
        success: (res) ->
          responseObject = JSON.parse(res)
          console.log responseObject
          window.location = responseObject.redirect
        error: (res) ->
          message = JSON.parse(res.responseText).message
          alert(message)