$ ->
  if namespace.controller is "creations" and namespace.action is "new"
    mousePos = {}
    allNotes = {}
    mode = "add"
    board = $("#note-board")
    tracker = $("#tracker")
    tracker.css("height": board.height())
    offset = board.offset()
    polySynth = new Tone.PolySynth(5, Tone.Synth).toMaster()
    playInterval = 0
    noteIndex = 0

    keys = {}
    $(".note-row").each (i) ->
      keys[i] = $(this).attr("id")

    window.playNote = (note) ->
      polySynth.triggerAttackRelease(note, "2n");

    $("#play-button").click () ->
      playMusic()
      tracker.show()
      $(this).hide()
      $("#stop-button").show()

    $("#stop-button").click () ->
      stopMusic()

    playMusic = () ->
      noteIndex = 0
      tracker.stop()
      tracker.css({"left": "0px"})
      playInterval = setInterval(playNextNote, 250)

    playNextNote = () ->
      note = allNotes[noteIndex]
      tracker.stop()
      tracker.css({"left": String(noteIndex*30) + "px"})
      tracker.animate({left: "+=30px"}, 250, "linear", (-> return))
      if note
        note = note.slice()
        if note.length > 5
          note.splice(5, note.length - 5)
        letters = note.map (x) ->
          keys[x]
        polySynth.triggerAttackRelease(letters, "8n")
      noteIndex += 1

    stopMusic = () ->
      clearInterval(playInterval)
      tracker.hide()
      $("#stop-button").hide()
      $("#play-button").show()

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
          allNotes[col].splice(allNotes[col].indexOf(row), 1)
          if allNotes[col].length == 0
            delete allNotes[col]
          thisNote.remove()

    $(document).mousemove (e) ->
      mousePos = {
        left: (e.pageX - offset.left) + board.scrollLeft()
        top:  e.pageY - offset.top
      }
      $('.ghost').remove()
      [noteX, noteY, col, row] = nearestCell(mousePos.left, mousePos.top)
      if (not (allNotes[col] and row in allNotes[col])) and not (mode is "delete")
        ghost = $('<div class="note ghost"></div>')
        ghost.css({top: noteY, left: noteX})
        board.append(ghost)

    board.click () ->
      [noteX, noteY, col, row] = nearestCell(mousePos.left, mousePos.top)
      if allNotes[col] and row in allNotes[col]
        # do nothing
      else if mode is "add"
        addNote(noteX, noteY, col, row)
      

    addNote = (noteX, noteY, col, row) ->
      newNote = $('<div class="note" data-col="' + col + '" data-row="' + row + '"></div>')
      newNote.css({top: noteY, left: noteX})
      addNoteEvents(newNote)

      allNotes[col] ?= []
      allNotes[col].push(row)
      board.append(newNote)

    board.mouseleave () ->
      $('.ghost').remove()

    #
    # Toolbar
    #

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
      console.log allNotes

    $("#save-creation").click () ->
      $.ajax
        dataType: "text"
        url: "/creations"
        type: "POST"
        data:
          data: JSON.stringify(allNotes)
          name: $("#creation-name").val()
        success: (res) ->
          responseObject = JSON.parse(res)
          console.log responseObject
          window.location = responseObject.redirect
        error: (res) ->
          message = JSON.parse(res.responseText).message
          alert(message)