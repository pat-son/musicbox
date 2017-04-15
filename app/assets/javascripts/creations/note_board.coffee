$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit", "show"]
    window.data ?= {}
    if $.isEmptyObject(data)
      data.config = { numCol: 100, maxCol: 2000}
      data.channels = []
      data.channels[0] = {notes: {}, options: {}}
    
    window.channelNotes = data.channels[0].notes
    window.board = $("#note-board")
    sequencer.numCol = data.config.numCol
    $(".note-row").width(data.config.numCol * 30)
    window.tracker = $("#tracker")
    tracker.css("height": board.height())

    # Function definitions

    board.addNote = (col, row, note = "") ->
      newNote = $('<div class="note" data-col="' + col + '" data-row="' + row + '"></div>')
      newNote.html(note)
      newNote.css({top: row * 20, left: col * 30})
      board.append(newNote)
      newNote

    # Event handlers

    $("#play-button").click () ->
      sequencer.play(channelNotes, tracker)
      tracker.show()
      $(this).hide()
      $("#stop-button").show()

    $("#stop-button").click () ->
      sequencer.stop()

    # Main

    window.initialNotes = []
    for col of channelNotes
      for note in channelNotes[col]
        initialNotes.push board.addNote(note.col, note.row, note.note)

