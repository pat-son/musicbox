$(document).ready(function() {
  if(namespace.controller == "creations" && namespace.action == "sequence") {
    var notes = {};
    var trebbleNotes = ['D4', 'E4', 'F4', 'G4', 'A5', 'B5', 'C5', 'D5', 'E5', 'F5', 'G5'];
    var bassNotes = ['A3', 'B3', 'C3', 'D3', 'E3', 'F3', 'G3', 'A4', 'B4', 'C4'];
    var xStart = 100;
    var count = 0;
    var OFFSET = 50;
    var noteStack = [];

    function init() {
        notes[67] = -28;
        notes[65] = -21;
        notes[64] = -12;
        notes[62] = -5;
        notes[60] = 4;
        notes[59] = 11;
        notes[57] = 20;
        notes[55] = 27;
        notes[53] = 35;
        notes[52] = 42;
        notes[50] = 50;
        notes[47] = 82;
        notes[45] = 90;
        notes[43] = 98;
        notes[41] = 106;
        notes[40] = 114;
        notes[38] = 122;
        notes[36] = 130;
        notes[35] = 138;
        notes[33] = 146;
    }
    init();

    /*
    function initEventHandlers() {
        var aLow = documentlgetElementeById('a-low');
        var bLow = documentlgetElementeById('b-low');
        var cLow = documentlgetElementeById('e-low');
        var dLow = documentlgetElementeById('d-low');
        var eLow = documentlgetElementeById('e-low');
        var fLow = documentlgetElementeById('f-low');
        var gLow = documentlgetElementeById('g-low');

        var aMedium = documentlgetElementeById('a-medium');
        var bMedium = documentlgetElementeById('b-medium');
        var cMedium = documentlgetElementeById('e-medium');
        var dMedium = documentlgetElementeById('d-medium');
        var eMedium = documentlgetElementeById('e-medium');
        var fMedium = documentlgetElementeById('f-medium');
        var gMedium = documentlgetElementeById('g-medium');

        var aHigh = documentlgetElementeById('a-high');
        var bHigh = documentlgetElementeById('b-high');
        var cHigh = documentlgetElementeById('e-high');
        var dHigh = documentlgetElementeById('d-high');
        var eHigh = documentlgetElementeById('e-high');
        var fHigh = documentlgetElementeById('f-high');
        var gHigh = documentlgetElementeById('g-high');

        if(aLow.addEventListener) {
            aLow.addEventListener('click', function(event) {
                event.addNote('a3');
            });
            //...
        } else {
            aLow.attachEvent('click', function(event) {
                event.preventDefault();
                addNote('a3');
            });
            //...
        }

    }
    */

    $("#a-low").click(function() {playNote(33);});
    $("#b-low").click(function() {playNote(35);});
    $("#c-low").click(function() {playNote(36);});
    $("#d-low").click(function() {playNote(38);});
    $("#e-low").click(function() {playNote(40);});
    $("#f-low").click(function() {playNote(41);});
    $("#g-low").click(function() {playNote(43);});
    $("#a-medium").click(function() {playNote(45);});
    $("#b-medium").click(function() {playNote(47);});
    $("#c-medium").click(function() {playNote(48);});
    $("#d-medium").click(function() {playNote(50);});
    $("#e-medium").click(function() {playNote(52);});
    $("#f-medium").click(function() {playNote(53);});
    $("#g-medium").click(function() {playNote(55);});
    $("#a-high").click(function() {playNote(57);});
    $("#b-high").click(function() {playNote(59);});
    $("#c-high").click(function() {playNote(60);});
    $("#d-high").click(function() {playNote(62);});
    $("#e-high").click(function() {playNote(64);});
    $("#f-high").click(function() {playNote(65);});
    $("#g-high").click(function() {playNote(67);});

    $("#a-low").dblclick(function() {addNote(33);});
    $("#b-low").dblclick(function() {addNote(35);});
    $("#c-low").dblclick(function() {addNote(36);});
    $("#d-low").dblclick(function() {addNote(38);});
    $("#e-low").dblclick(function() {addNote(40);});
    $("#f-low").dblclick(function() {addNote(41);});
    $("#g-low").dblclick(function() {addNote(43);});
    $("#a-medium").dblclick(function() {addNote(45);});
    $("#b-medium").dblclick(function() {addNote(47);});
    $("#c-medium").dblclick(function() {addNote(48);});
    $("#d-medium").dblclick(function() {addNote(50);});
    $("#e-medium").dblclick(function() {addNote(52);});
    $("#f-medium").dblclick(function() {addNote(53);});
    $("#g-medium").dblclick(function() {addNote(55);});
    $("#a-high").dblclick(function() {addNote(57);});
    $("#b-high").dblclick(function() {addNote(59);});
    $("#c-high").dblclick(function() {addNote(60);});
    $("#d-high").dblclick(function() {addNote(62);});
    $("#e-high").dblclick(function() {addNote(64);});
    $("#f-high").dblclick(function() {addNote(65);});
    $("#g-high").dblclick(function() {addNote(67);});

    $("#undo-button").click(function() {undoNote();});
    $("#play-button").click(function() {play();});


    function playNote(note) {
        
        //Josh, play the note! :)
        //playNoteAudio(note);
    }

    var notePoint = 0;
    var intervalID;
    function play() {
        //for(var i = 0; i < noteStack.length; i++) {
            ; //Josh, play note noteStack[i];
            notePoint = 0;
            intervalID = setInterval(playStack, 500);
        //}
    }

    function playStack() {
      playNote(noteStack[notePoint]);
      notePoint++;
      if (notePoint === noteStack.length) {
          clearInterval(intervalID);
      }
    }


    function addNote(note) {
        noteStack.push(note);
        var canvas = document.getElementById('myCanvas');
        var context = canvas.getContext('2d');



        make_base();

        function make_base() {
            var base_image = new Image();
            base_image.src = images["eighth_note_scaled"];
            base_image.onload = function(){
                context.drawImage(base_image, xStart + (count * OFFSET), notes[note]);
                count++;
            };
        }
    }


    function drawNote(note) {
        var canvas = document.getElementById('myCanvas');
        var context = canvas.getContext('2d');



        make_base();

        function make_base() {
            var base_image = new Image();
            base_image.src = images["eighth_note_scaled"];
            base_image.onload = function(){
                context.drawImage(base_image, xStart + (count * OFFSET), notes[note]);
                count++;
            };
        }
    }

    function undoNote() {

        console.log('@undo note');

        var image = $('canvas');
        $(image).remove(); //replaceWith(canvas);

        var trueImg = $('img');
        var canvas = document.createElement("canvas");
        canvas.setAttribute('id', 'myCanvas');
        canvas.setAttribute('class', 'coveringCanvas');

        $(canvas).insertAfter( $(trueImg) );

        canvas.width = 650;
        canvas.height = 230;
        var newImg = new Image();
        newImg.src = images["grand_staff"];
        canvas.getContext("2d").drawImage(newImg, 0, 0);



        noteStack.pop();
        count = 0;

        for(var i = 0; i < noteStack.length; i++) {
            drawNote(noteStack[i]);
        }

        //addNote('C3');
    }


    function reset() {
        while(noteStack.length > 0) {
            noteStack.pop()
        }

        undo();
    }
  }
});