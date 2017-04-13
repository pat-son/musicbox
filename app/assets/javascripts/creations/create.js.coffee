$ ->
  if namespace.controller is "creations" and namespace.action is "new"
    mousePos = {}
    board = $("#note-board")
    offset = board.offset()

    nearestCell = (x, y) ->
      cellX = Math.floor(x/30)
      cellY = Math.floor(y/20)
      [cellX * 30, cellY * 20]

    addNoteEvents = (note) ->
      note.click (e) ->
        e.stopPropagation()
        console.log "note clicked"

    $(document).mousemove (e) ->
      mousePos = {
        left: (e.pageX - offset.left) + board.scrollLeft()
        top:  e.pageY - offset.top
      }
      $('.ghost').remove()
      ghost = $('<div class="note ghost"></div>')
      [noteX, noteY] = nearestCell(mousePos.left, mousePos.top)
      ghost.css({top: noteY, left: noteX})
      board.append(ghost)

    board.click () ->
      console.log "board clicked"
      [noteX, noteY] = nearestCell(mousePos.left, mousePos.top)
      newNote = $('<div class="note"></div>')
      newNote.css({top: noteY, left: noteX})
      addNoteEvents(newNote)
      board.append(newNote)

    board.mouseleave () ->
      $('.ghost').remove()

    