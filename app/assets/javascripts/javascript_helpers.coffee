window.flashMessage = (message, type, duration) ->
  node = $('<div class="alert alert-' + type + '"></div>')
  node.html(message)
  $(".main-content").prepend(node)
  setTimeout((-> node.slideUp()), duration)