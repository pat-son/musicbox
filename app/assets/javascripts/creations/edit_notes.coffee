$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit"]
    mousePos = {}
    cc = 0 # current channel
    mode = "add"
    offset = board.offset()

    # Function definitions

    nearestCell = (x, y) ->
      cellX = Math.floor(x/30)
      cellY = Math.floor(y/20)
      [cellX * 30, cellY * 20, cellX, cellY]

    addNoteEvents = (note) ->
      note.click (e) ->
        e.stopPropagation()
        if mode is "delete"
          thisNote = $(this)
          col = thisNote[0].dataset.col
          row = parseInt(thisNote[0].dataset.row)
          channelNotes[col].splice(channelNotes[col].indexOf(row), 1)
          if channelNotes[col].length == 0
            delete channelNotes[col]
          thisNote.remove()

    addNoteToBoard = (col, row) ->
      channelNotes[col] ?= []
      noteString = sequencer.keys[row]
      channelNotes[col].push({note: noteString, col: col, row: row})
      note = board.addNote(col, row)
      addNoteEvents(note)
      sequencer.playOne(sequencer.keys[row])

    # Event handlers

    $(document).mousemove (e) ->
      mousePos = {
        left: (e.pageX - offset.left) + board.scrollLeft()
        top:  e.pageY - offset.top
      }
      $('.ghost').remove()
      [noteX, noteY, col, row] = nearestCell(mousePos.left, mousePos.top)
      noNote = true
      if channelNotes[col]
        for obj in channelNotes[col]
          if obj.row == row
            noNote = false
            break
      if noNote and not (mode is "delete")
        ghost = $('<div class="note ghost"></div>')
        ghost.css({top: noteY, left: noteX})
        board.append(ghost)

    board.click () ->
      [noteX, noteY, col, row] = nearestCell(mousePos.left, mousePos.top)
      if channelNotes[col] and row in channelNotes[col]
        # do nothing
      else if mode is "add"
        addNoteToBoard(col, row)

    $("#add-notes").click (e) ->
      board.removeClass("delete-mode")
      mode = "add"
      $(".option-selected").removeClass("option-selected")
      $(this).addClass("option-selected")
    
    $("#delete-notes").click (e) ->
      board.addClass("delete-mode")
      mode = "delete"
      $(".option-selected").removeClass("option-selected")
      $(this).addClass("option-selected")
      console.log channelNotes
      console.log data

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