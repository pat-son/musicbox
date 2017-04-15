$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit"]
    mousePos = {}
    cc = 0 # current channel
    mode = "add"
    sharp = false
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
          index = 0
          for i in channelNotes[col]
            if i.row == row
              break
            index++
          channelNotes[col].splice(index, 1) # TODO: fix this so deleting notes works again
          if channelNotes[col].length == 0
            delete channelNotes[col]
          thisNote.remove()

    addNoteToBoard = (col, row) ->
      channelNotes[col] ?= []
      noteString = sequencer.keys[row]
      if sharp
        noteString = noteString[0] + "#" + noteString[1]
      channelNotes[col].push({note: noteString, col: col, row: row})
      note = board.addNote(col, row, noteString)
      addNoteEvents(note)
      sequencer.playOne(noteString)

    sharpModeOn = ->
      sharp = true

    sharpModeOff = ->
      sharp = false

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

    $(".key").click (e) ->
      key = $(this)
      noteString = key[0].dataset.note
      if sharp
        noteString = noteString[0] + "#" + noteString[1]
      sequencer.playOne(noteString)
      row = board.children().eq(key.index())
      row.css({"background-color": "red"})
      row.stop().animate({backgroundColor: "white"}, 300, ->)

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

    keyDown = false
    document.addEventListener("keydown", (e) ->
      if not keyDown
        keyDown = true
        console.log("keyDown", e.keyCode)
        switch e.keyCode
          when 16 then sharpModeOn()
    )

    document.addEventListener("keyup", (e) ->
      keyDown = false
      switch e.keyCode
        when 16 then sharpModeOff()
    )

    # Main

    if namespace.action is "edit"
      for note in initialNotes
        addNoteEvents(note)