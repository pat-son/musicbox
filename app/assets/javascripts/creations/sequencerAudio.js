// $(document).ready(function() {
// 
//   if(namespace.controller == "creations" && namespace.action == "sequence") {
//     var notes = {};
//     var trebbleNotes = ['D4', 'E4', 'F4', 'G4', 'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5'];
//     var bassNotes = ['A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'A4', 'B4', 'C4'];
//     var xStart = 100;
//     var count = 0;
//     var OFFSET = 50;
//     var noteStack = [];
// 
//     function init() {
//         notes[67] = -28;
//         notes[65] = -21;
//         notes[64] = -12;
//         notes[62] = -5;
//         notes[60] = 4;
//         notes[59] = 11;
//         notes[57] = 20;
//         notes[55] = 27;
//         notes[53] = 35;
//         notes[52] = 42;
//         notes[50] = 50;
//         notes[47] = 82;
//         notes[45] = 90;
//         notes[43] = 98;
//         notes[41] = 106;
//         notes[40] = 114;
//         notes[38] = 122;
//         notes[36] = 130;
//         notes[35] = 138;
//         notes[33] = 146;
//     }
//     init();
// 
//     /*
//     function initEventHandlers() {
//         var aLow = documentlgetElementeById('a-low');
//         var bLow = documentlgetElementeById('b-low');
//         var cLow = documentlgetElementeById('e-low');
//         var dLow = documentlgetElementeById('d-low');
//         var eLow = documentlgetElementeById('e-low');
//         var fLow = documentlgetElementeById('f-low');
//         var gLow = documentlgetElementeById('g-low');
// 
//         var aMedium = documentlgetElementeById('a-medium');
//         var bMedium = documentlgetElementeById('b-medium');
//         var cMedium = documentlgetElementeById('e-medium');
//         var dMedium = documentlgetElementeById('d-medium');
//         var eMedium = documentlgetElementeById('e-medium');
//         var fMedium = documentlgetElementeById('f-medium');
//         var gMedium = documentlgetElementeById('g-medium');
// 
//         var aHigh = documentlgetElementeById('a-high');
//         var bHigh = documentlgetElementeById('b-high');
//         var cHigh = documentlgetElementeById('e-high');
//         var dHigh = documentlgetElementeById('d-high');
//         var eHigh = documentlgetElementeById('e-high');
//         var fHigh = documentlgetElementeById('f-high');
//         var gHigh = documentlgetElementeById('g-high');
// 
//         if(aLow.addEventListener) {
//             aLow.addEventListener('click', function(event) {
//                 event.addNote('a3');
//             });
//             //...
//         } else {
//             aLow.attachEvent('click', function(event) {
//                 event.preventDefault();
//                 addNote('a3');
//             });
//             //...
//         }
// 
//     }
//     */
// 
//     $("#a-low").click(function() {playNote(33);});
//     $("#b-low").click(function() {playNote(35);});
//     $("#c-low").click(function() {playNote(36);});
//     $("#d-low").click(function() {playNote(38);});
//     $("#e-low").click(function() {playNote(40);});
//     $("#f-low").click(function() {playNote(41);});
//     $("#g-low").click(function() {playNote(43);});
//     $("#a-medium").click(function() {playNote(45);});
//     $("#b-medium").click(function() {playNote(47);});
//     $("#c-medium").click(function() {playNote(48);});
//     $("#d-medium").click(function() {playNote(50);});
//     $("#e-medium").click(function() {playNote(52);});
//     $("#f-medium").click(function() {playNote(53);});
//     $("#g-medium").click(function() {playNote(55);});
//     $("#a-high").click(function() {playNote(57);});
//     $("#b-high").click(function() {playNote(59);});
//     $("#c-high").click(function() {playNote(60);});
//     $("#d-high").click(function() {playNote(62);});
//     $("#e-high").click(function() {playNote(64);});
//     $("#f-high").click(function() {playNote(65);});
//     $("#g-high").click(function() {playNote(67);});
// 
//     $("#a-low").dblclick(function() {addNote(33);});
//     $("#b-low").dblclick(function() {addNote(35);});
//     $("#c-low").dblclick(function() {addNote(36);});
//     $("#d-low").dblclick(function() {addNote(38);});
//     $("#e-low").dblclick(function() {addNote(40);});
//     $("#f-low").dblclick(function() {addNote(41);});
//     $("#g-low").dblclick(function() {addNote(43);});
//     $("#a-medium").dblclick(function() {addNote(45);});
//     $("#b-medium").dblclick(function() {addNote(47);});
//     $("#c-medium").dblclick(function() {addNote(48);});
//     $("#d-medium").dblclick(function() {addNote(50);});
//     $("#e-medium").dblclick(function() {addNote(52);});
//     $("#f-medium").dblclick(function() {addNote(53);});
//     $("#g-medium").dblclick(function() {addNote(55);});
//     $("#a-high").dblclick(function() {addNote(57);});
//     $("#b-high").dblclick(function() {addNote(59);});
//     $("#c-high").dblclick(function() {addNote(60);});
//     $("#d-high").dblclick(function() {addNote(62);});
//     $("#e-high").dblclick(function() {addNote(64);});
//     $("#f-high").dblclick(function() {addNote(65);});
//     $("#g-high").dblclick(function() {addNote(67);});
// 
//     $("#undo-button").click(function() {undoNote();});
//     $("#play-button").click(function() {play();});
// 
// 
//     function playNote(note) {
//         
//         //Josh, play the note! :)
//         //playNoteAudio(note);
//     }
// 
//     var notePoint = 0;
//     var intervalID;
//     function play() {
//         //for(var i = 0; i < noteStack.length; i++) {
//             ; //Josh, play note noteStack[i];
//             notePoint = 0;
//             intervalID = setInterval(playStack, 500);
//         //}
//     }
// 
//     function playStack() {
//       playNote(noteStack[notePoint]);
//       notePoint++;
//       if (notePoint === noteStack.length) {
//           clearInterval(intervalID);
//       }
//     }
// 
// 
//     function addNote(note) {
//         noteStack.push(note);
//         var canvas = document.getElementById('myCanvas');
//         var context = canvas.getContext('2d');
// 
// 
// 
//         make_base();
// 
//         function make_base() {
//             var base_image = new Image();
//             base_image.src = images["eighth_note_scaled"];
//             base_image.onload = function(){
//                 context.drawImage(base_image, xStart + (count * OFFSET), notes[note]);
//                 count++;
//             };
//         }
//     }
// 
// 
//     function drawNote(note) {
//         var canvas = document.getElementById('myCanvas');
//         var context = canvas.getContext('2d');
// 
// 
// 
//         make_base();
// 
//         function make_base() {
//             var base_image = new Image();
//             base_image.src = images["eighth_note_scaled"];
//             base_image.onload = function(){
//                 context.drawImage(base_image, xStart + (count * OFFSET), notes[note]);
//                 count++;
//             };
//         }
//     }
// 
//     function undoNote() {
// 
//         console.log('@undo note');
// 
//         var image = $('canvas');
//         $(image).remove(); //replaceWith(canvas);
// 
//         var trueImg = $('img');
//         var canvas = document.createElement("canvas");
//         canvas.setAttribute('id', 'myCanvas');
//         canvas.setAttribute('class', 'coveringCanvas');
// 
//         $(canvas).insertAfter( $(trueImg) );
// 
//         canvas.width = 650;
//         canvas.height = 230;
//         var newImg = new Image();
//         newImg.src = images["grand_staff"];
//         canvas.getContext("2d").drawImage(newImg, 0, 0);
// 
// 
// 
//         noteStack.pop();
//         count = 0;
// 
//         for(var i = 0; i < noteStack.length; i++) {
//             drawNote(noteStack[i]);
//         }
// 
//         //addNote('C3');
//     }
// 
// 
//     function reset() {
//         while(noteStack.length > 0) {
//             noteStack.pop()
//         }
// 
//         undo();
//     }
//   } 
// });
$(document).ready(function() {
	
	//a creation page that allows the ability to edit
	if (namespace.controller === "creations" && 
	["new", "edit", "show"].indexOf(namespace.action) > -1) {
	
		// all instruments supported by our sequencer
	   // CLASSIC/REST 0, AM 1, DUO 2, MEMBRANE 3, MONO 4 
	   var instruments = [new Tone.Synth().toMaster(),
		  new Tone.AMSynth().toMaster(), new Tone.DuoSynth().toMaster(),
		  new Tone.MembraneSynth().toMaster(), new Tone.MonoSynth().toMaster()];

	   // chord version of instruments
	   var chords = [new Tone.PolySynth(3, Tone.Synth).toMaster(),
		  new Tone.PolySynth(3, Tone.AMSynth).toMaster(),
		  new Tone.PolySynth(3, Tone.DuoSynth).toMaster(),
		  new Tone.PolySynth(3, Tone.MembraneSynth).toMaster(),
		  new Tone.PolySynth(3, Tone.MonoSynth).toMaster()];



	   //global initial tempo - SLOW 250, MEDIUM 300, FAST 350
	   Tone.Transport.bpm.value = 250;


	   /**
		* sequencer note object
		* @param {number} instrument is an index in the instruments array
		* @param {array} notes contains all pitches to be played (length is 1,2,or3)
		* @param {string} duration is either 1n, 2n, or 4n
		* @returns {window.onload.SequencerNote} note object
		*/
	   function SequencerNote(instrument, notes, duration) {
		  this.instrument = instrument;
		  // if notes.length > 1 -> then it's a chord
		  // C1 is a rest
		  this.notes = notes;
		  this.duration = duration;   
	   };

	   // array of SequencerNotes containing the song
	   var sequencer = [];

	   /**
		* playNote(2, ["C4", "D4", "E4"], "1n", "0"); 
		* plays a whole note chord using duo synth
		* @param {number} instrument
		* @param {array} notes
		* @param {string} duration
		* @param {string} offset make sure notes are played in sequence
		* @returns {undefined}
		*/
	   window.playNote = function(instrument, notes, duration, offset) {
		  offset += " + 0.3";
		  // if more than one note -> then it's a chord
		  if (notes.length > 1) {
			 // chord
			 /*
			 var typeOfInstrument;
			 switch (instrument) {
				case 0:
				   typeOfInstrument = Tone.Synth;
				   break;
				case 1:
				   typeOfInstrument = Tone.AMSynth;
				   break;
				case 2:
				   typeOfInstrument = Tone.DuoSynth;
				   break;
				case 3:
				   typeOfInstrument = Tone.MembraneSynth;
				   break;
				case 4:
				   typeOfInstrument = Tone.MonoSynth;
				   break;
			 }
			 */


			 //play the chord
			 chords[instrument].triggerAttack(notes, offset, 1);
			 chords[instrument].triggerRelease(notes, offset + " + " + duration);
			 //console.log(offset);

		  } else {

			 // solo note
			 instruments[instrument].triggerAttack(notes[0], offset, 1);
			 instruments[instrument].triggerRelease(offset + " + " + duration);
			 //console.log(offset);
		  }
	   };


	   /**
		* Loops through sequencer array and plays all SequencerNote objects
		* 
		*/
	   window.playSequencer = function() {

		  // keeps track of when a note should be played
		  var lengthString = "1.5"; // - add constant offset of 1.5 second

		  // play twice
		  for (var i = 0; i < sequencer.length * 2; i++) {

			 var seqNote = sequencer[i % sequencer.length];
			 // - rest - > play C1 and set volume to 0 must be regular synth
			 if (seqNote.notes[0] === "C1") {

				// play note now instead of adding 
				// rest playback functionality to playNote()
				instruments[0].triggerAttack("C4", lengthString + " + 0.3", 0);
				//console.log(lengthString + " + 0.3");
				lengthString += " + " + seqNote.duration; // update
				instruments[0].triggerRelease(lengthString + " + 0.3");



			 } else {


				playNote(seqNote.instrument, seqNote.notes,
						seqNote.duration, lengthString);
				lengthString += " + " + seqNote.duration; // update

			 }
		  }
	   };
   
	   /**
		* adds a sequencer note to the sequencer array
		* @param {number} instrument
		* @param {array} notes
		* @param {string} duration
		* 
		*/
	   window.addNote = function(instrument, notes, duration) {
		  sequencer.push(new SequencerNote(instrument, notes, duration));
	   };
   
	   /**
		* removes the last note in the sequencer
		* 
		*/
	   window.undo = function() {
		  if (sequencer.length > 0) {
			 sequencer.pop();
		  }
	   };
   
	   /**
		* 
		* @param {number} tempo - 0 slow, 1 medium, 2 fast
		* @returns {undefined}
		*/
	   window.changeTempo = function(tempo) {
		  switch (tempo) {
			 case 0:
				Tone.Transport.bpm.value = 250;
				break;
			 case 1:
				Tone.Transport.bpm.value = 300;
				break;
			 case 2:
				Tone.Transport.bpm.value = 350;
				break;
		  }
	   };
   
	   // start time
	   Tone.Transport.start();
   
   
   /*
	   addNote(0, ["C4", "E4"], "4n");
	   addNote(2, ["C4"], "4n");
	   addNote(0, ["C4", "D4"], "1n");
	   addNote(2, ["C4"], "4n");
	   addNote(0, ["C4"], "2n");
	   addNote(3, ["C4"], "4n");
	   addNote(0, ["C4"], "4n");
	   addNote(1, ["C4"], "1n");
	   addNote(3, ["C4"], "4n");
   
	   playSequencer(); 
	
	 */
	
	
	}
});

