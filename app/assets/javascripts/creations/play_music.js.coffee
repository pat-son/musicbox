$ ->
  if namespace.controller is "creations" and namespace.action in ["show"]
    board = $("#note-board")
    tracker = $("#tracker")
    tracker.css("height": board.height())
    offset = board.offset()
    polySynth = new Tone.PolySynth(5, Tone.Synth).toMaster()
    playInterval = 0
    noteIndex = 0

    addNote = (noteX, noteY, col, row) ->
      newNote = $('<div class="note" data-col="' + col + '" data-row="' + row + '"></div>')
      newNote.css({top: noteY, left: noteX})
      board.append(newNote)

    for col of allNotes
      for row in allNotes[col]
        addNote(parseInt(col) * 30, row * 20, col, row)

    keys = {}
    $(".note-row").each (i) ->
      keys[i] = $(this).attr("id")

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
      tracker.animate({left: "+=30px"}, 250, "linear", (-> return))
      if note
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