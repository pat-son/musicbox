$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit", "show"]
    class window.Sequencer
      constructor: (@keys) ->
        @synth = new Tone.PolySynth(5, Tone.Synth).toMaster()
        @intervalId = 0
        @noteIndex = 0
        @time = 250
        @numCol = 100
        @startNote = 0

      play: (notes, tracker) ->
        $("#note-board").stop().scrollLeft((tracker.offset().left + $("#note-board").scrollLeft() - $("#note-board").offset().left) - 0.5 * $("#note-board").width())
        @noteIndex = @startNote
        tracker.stop().css({"left": @startNote * 30})
        ref = this
        @intervalId = setInterval((-> playNextNote.call(ref, notes, tracker)), @time)

      stop: (tracker) ->
        clearInterval(@intervalId)
        $("#stop-button").hide()
        tracker.stop().css({"left": @startNote * 30})
        $("#note-board").stop().scrollLeft((tracker.offset().left + $("#note-board").scrollLeft() - $("#note-board").offset().left) - 0.5 * $("#note-board").width())
        $("#play-button").show()

      playOne: (note) ->
        @synth.triggerAttackRelease(note, "8n")

      playNextNote = (notes, tracker) ->
        note = notes[@noteIndex]
        tracker.stop().css({"left": String(@noteIndex*30) + "px"})
        tracker.animate({left: "+=30px"}, @time, "linear", (-> return))
        scroll = (tracker.offset().left + $("#note-board").scrollLeft() - $("#note-board").offset().left) - 0.5 * $("#note-board").width()
        $("#note-board").stop().scrollLeft(scroll)
        if scroll > 0
          $("#note-board").animate({scrollLeft: "+=30px"}, @time, "linear", (-> return))
        if note
          note = note.slice()
          if note.length > 5
            note.splice(5, note.length - 5)
          letters = note.map (x) ->
            x.note
          @synth.triggerAttackRelease(letters, "8n")
        @noteIndex += 1
        if @noteIndex >= @numCol
          @stop(tracker)

    
    keys = {}
    $(".note-row").each (i) ->
      keys[i] = $(this).attr("id")

    window.sequencer = new Sequencer(keys)
