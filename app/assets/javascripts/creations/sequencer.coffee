$ ->
  if namespace.controller is "creations" and namespace.action in ["new", "edit", "show"]
    class window.Sequencer
      constructor: (@keys) ->
        @polySynth = new Tone.PolySynth(5, Tone.Synth).toMaster()
        @intervalId = 0
        @noteIndex = 0
        @time = 250

      play: (notes, tracker) ->
        @noteIndex = 0
        tracker.stop()
        tracker.css({"left": "0px"})
        ref = this
        @intervalId = setInterval((-> playNextNote.call(ref, notes, tracker)), @time)

      stop: ->
        clearInterval(@intervalId)

      playOne: (note) ->
        @polySynth.triggerAttackRelease(note, "8n")

      playNextNote = (notes, tracker) ->
        note = notes[@noteIndex]
        tracker.stop()
        tracker.css({"left": String(@noteIndex*30) + "px"})
        tracker.animate({left: "+=30px"}, 250, "linear", (-> return))
        if note
          note = note.slice()
          if note.length > 5
            note.splice(5, note.length - 5)
          letters = note.map (x) ->
            x.note
          @polySynth.triggerAttackRelease(letters, "8n")
        @noteIndex += 1

    
    keys = {}
    $(".note-row").each (i) ->
      keys[i] = $(this).attr("id")

    window.sequencer = new Sequencer(keys)
      