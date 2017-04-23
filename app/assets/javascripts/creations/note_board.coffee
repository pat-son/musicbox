$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit", "show"]
    window.data ?= {}
    if $.isEmptyObject(data)
      data.config = { numCol: 100, maxCol: 2000, grid: false}
      data.channels = []
      data.channels[0] = {notes: {}, options: {}}
    
    window.channelNotes = data.channels[0].notes
    window.board = $("#note-board")
    board.mousePos = {}
    sequencer.numCol = data.config.numCol
    $(".note-row").width(data.config.numCol * 30)
    window.tracker = $("#tracker")
    tracker.css("height": board.height())
    tracker.moveTracker = false

    # Function definitions

    board.addNote = (col, row, note = "") ->
      newNote = $('<div class="note" data-col="' + col + '" data-row="' + row + '"></div>')
      newNote.html(note)
      newNote.css({top: row * 20, left: col * 30})
      board.append(newNote)
      newNote

    board.nearestCell = (x, y) ->
      cellX = Math.floor(x/30)
      cellY = Math.floor(y/20)
      [cellX * 30, cellY * 20, cellX, cellY]

    startMoveTracker = ->
      tracker.moveTracker = true
      $("#tracker-button").addClass("option-selected")

    stopMoveTracker = ->
      tracker.moveTracker = false
      $("#tracker-button").removeClass("option-selected")

    # Event handlers

    $(document).mousemove (e) ->
      board.mousePos = {
        left: (e.pageX - board.offset().left) + board.scrollLeft()
        top:  e.pageY - board.offset().top
      }
      if tracker.moveTracker
        [noteX, noteY, col, row] = board.nearestCell(board.mousePos.left, board.mousePos.top)
        tracker.css({"left": col * 30})

    board.click (e) ->
      if tracker.moveTracker
        e.stopImmediatePropagation()
        stopMoveTracker()
        [noteX, noteY, col, row] = board.nearestCell(board.mousePos.left, board.mousePos.top)
        sequencer.startNote = col

    $("#play-button").click () ->
      sequencer.play(channelNotes, tracker)
      $(this).hide()
      $("#stop-button").show()

    $("#stop-button").click () ->
      sequencer.stop(tracker)

    $("#tracker-button").click () ->
      if tracker.moveTracker
        stopMoveTracker()
      else
        startMoveTracker()


    # Main

    window.initialNotes = []
    for col of channelNotes
      for note in channelNotes[col]
        initialNotes.push board.addNote(note.col, note.row, note.note)
    sequencer.numCol = data.config.numCol

    $('[data-toggle="tooltip"]').tooltip(); 

