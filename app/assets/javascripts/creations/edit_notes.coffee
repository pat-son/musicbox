$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit"]
    mousePos = {}
    cc = 0 # current channel
    mode = "add"
    # 0 short, 1 medium, 2 long
    length = 1
    sharp = false

    # Function definitions

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
          channelNotes[col].splice(index, 1)
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
      board.addClass("sharp-mode")
      $("#sharp-notes").addClass("option-selected")

    sharpModeOff = ->
      sharp = false
      board.removeClass("sharp-mode")
      $("#sharp-notes").removeClass("option-selected")

    deleteModeOn = ->
      board.addClass("delete-mode")
      mode = "delete"
      $("#add-notes").removeClass("option-selected")
      $("#delete-notes").addClass("option-selected")

    deleteModeOff = ->
      board.removeClass("delete-mode")
      mode = "add"
      $("#delete-notes").removeClass("option-selected")
      $("#add-notes").addClass("option-selected")

    addGridLines = ->
      $(".note-row").addClass("grid-row")
      data.config.grid = true
      $("#grid-lines").addClass("option-selected")

    removeGridLines = ->
      $(".note-row").removeClass("grid-row")
      data.config.grid = false
      $("#grid-lines").removeClass("option-selected")
      
    shortModeOn = ->
      $("#short-note").addClass("option-selected")
      switch length
      	when 1 then $("#medium-note").removeClass("option-selected")
      	when 2 then $("#long-note").removeClass("option-selected")
      length = 0

    # Event handlers

    $(document).mousemove (e) ->
      $('.ghost').remove()
      [noteX, noteY, col, row] = board.nearestCell(board.mousePos.left, board.mousePos.top)
      noNote = true
      if channelNotes[col]
        for obj in channelNotes[col]
          if obj.row == row
            noNote = false
            break
      if noNote and mode is "add" and not tracker.moveTracker
        ghost = $('<div class="note ghost"></div>')
        ghost.css({top: noteY, left: noteX})
        board.append(ghost)

    board.click () ->
      [noteX, noteY, col, row] = board.nearestCell(board.mousePos.left, board.mousePos.top)
      if channelNotes[col] and row in channelNotes[col]
        # do nothing
      else if mode is "add" and not tracker.moveTracker
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
      deleteModeOff()
    
    $("#delete-notes").click (e) ->
      deleteModeOn()

    $("#sharp-notes").click (e) ->
      if sharp
        sharpModeOff()
      else
        sharpModeOn()

    $("#grid-lines").click (e) ->
      if data.config.grid
        removeGridLines()
      else
        addGridLines()

    $("#add-columns").click (e) ->
      if data.config.numCol + 50 <= 2000
        data.config.numCol += 50
        $(".note-row").width(data.config.numCol * 30)
      else
        flashMessage("Sorry, but the maximum amount of note columns is 2000.", "danger", 5000)

    keyDown = false
    textBoxFocused = false
    document.addEventListener("keydown", (e) ->
      if not keyDown and not textBoxFocused
        keyDown = true
        switch e.keyCode
          when 16 then sharpModeOn()
          when 8  then deleteModeOn()
    )

    document.addEventListener("keyup", (e) ->
      keyDown = false
      if not textBoxFocused
        switch e.keyCode
          when 16 then sharpModeOff()
          when 8  then deleteModeOff()
    )

    $(window).blur (e) ->
      if keyDown and mode is "delete"
        mode = "add"
        deleteModeOff()
      if keyDown and sharp == true
        sharp = false
        sharpModeOff()
      keyDown = false
      
    $("#short-note").click (e) ->
      shortModeOn()

    $("#creation-name").focus((e) -> textBoxFocused = true)
    $("#creation-name").blur((e) -> textBoxFocused = false)

    # Main

    if namespace.action is "edit"
      for note in initialNotes
        addNoteEvents(note)

    if data.config.grid
      addGridLines()