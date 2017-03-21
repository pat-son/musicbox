var intervalID;
var noteQueue = [48, 50, 52, 53, 55, 57, 59, 60];

function playNotes(velocity, delay) {
   var note = noteQueue.shift();

   MIDI.noteOn(0, note, velocity, delay); //ocarina
   MIDI.noteOff(0, note, delay + 0.2);
   MIDI.noteOn(1, note, velocity, delay); //piano
   MIDI.noteOff(1, note, delay + 0.2);

   if (noteQueue.length === 0) {
      clearInterval(intervalID);
   }
}


window.onload = function () {

   MIDI.loadPlugin({
      soundfontUrl: "./js/midi-js-soundfonts/FluidR3_GM/",
      //soundfontUrl: "./js/MIDIjs/examples/soundfont/", //better sounding
      instrument: ["synth_drum", "acoustic_grand_piano"],
      onprogress: function (state, progress) {
         //console.log(state, progress);
      },
      onsuccess: function () {
         MIDI.programChange(0, MIDI.GM.byName["synth_drum"].number); //used to play different instruments
         MIDI.programChange(1, MIDI.GM.byName["acoustic_grand_piano"].number);
         //var note = 50; // the MIDI note
         var velocity = 127; // how hard the note hits
         var delay = 0; // play one note every quarter second
         MIDI.setVolume(0, 127);
         MIDI.setEffects({
            type: "Overdrive",
            outputGain: 1000, // 0 to 1+
            drive: 1, // 0 to 1
            curveAmount: 1, // 0 to 1
            algorithmIndex: 4, // 0 to 5, selects one of our drive algorithms
            bypass: 0
         });

         playNotes(0, velocity, delay);
         intervalID = setInterval(playNotes, 500, velocity, delay);
      }
   });
};
