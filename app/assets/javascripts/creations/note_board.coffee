$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit", "show"]
    window.data ?= {}
    if $.isEmptyObject(data)
      data.config = {}
      data.channels = []
      data.channels[0] = {notes: {}, options: {}}
    window.channelNotes = data.channels[0].notes
    window.board = $("#note-board")
    window.tracker = $("#tracker")
    tracker.css("height": board.height())

    # Function definitions

    board.addNote = (col, row) ->
      newNote = $('<div class="note" data-col="' + col + '" data-row="' + row + '"></div>')
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
      tracker.hide()
      $(this).hide()
      $("#play-button").show()

    # Main

    for col of channelNotes
      for note in channelNotes[col]
        board.addNote(note.col, note.row)
