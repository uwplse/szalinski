// =======================================================
// AUTHOR        : Jose Lopez, JoLoCity, LLC
// DATE          : 20190515
// DESCRIPTION   : Braille generator for 3d printing
// VERSION       : 1.0
// =======================================================
// word to display
PHRASE = "ABCDE";

/* [Dimensions] */
// tablet height
biHeight = 25; 
// tablet width
biWidth = 15;
// tablet depth
biDepth = 5;

// tablet gap
tbtGap = 2;

// button radius
biRadius = 2;


// row margin
biSpaceA = 4;
// row spacing
biSpaceB = biWidth - (biSpaceA*2);

// column margin
biSpaceX = 4;
// column spacing;
biSpaceY = (biHeight - (biSpaceX*2))/2;
/* [Colors] */
//back base color
baseColor = [0,0,0]; //[0:0.1:1]

//tablet color
tbtColor = [1.0,1.0,1.0]; //[0:0.1:1]

// Item color
biColor = [0.5,1.0,0.5]; //[0:0.1:1]

/* [Other] */
//braille alphabet
BRAILLE_ALPHABET = [
    [false, false, false, false, true, false] //A
    , [false, false, true, false, true, false] //B
    , [false, false, false, false, true, true] //C
    , [false, false, false, true, true, true] //D
    , [false, false, false, true, true, false] //E
    , [false, false, true, false, true, true] //F
    , [false, false, true, true, true, true] //G
    , [false, false, true, true, true, false] //H
    , [false, false, true, false, false, true] //I
    , [false, false, true, true, false, true] //J
    , [true, false, false, false, true, false] //K
    , [true, false, true, false, true, false] //L
    , [true, false, false, false, true, true] //M
    , [true, false, false, true, true, true] //N
    , [true, false, false, true, true, false] //O
    , [true, false, true, false, true, true] //P
    , [true, false, true, true, true, true] //Q
    , [true, false, true, true, true, false] //R
    , [true, false, true, false, false, true] //S
    , [true, false, true, true, false, true] //T
    , [true, true, false, false, true, false] //U
    , [true, true, true, false, true, false] //V
    , [false, true, true, true, false, true] //W
    , [true, true, false, false, true, true] //X
    , [true, true, false, true, true, true] //Y
    , [true, true, false, true, true, false] //Z
    , [false, false, false, false, true, false] //Accent
    , [true, false, false, false, false, false] //Apostrophe
    , [false, false, false, false, false, false] //Space
    , [true, true, false, false, false, false] //-
    , [false, false, true, false, false, false] //,
    , [true, false, true, false, false, false] //;
    , [false, false, false, true, true, false] //:
    , [false, true, true, true, false, false] //.
    , [true, true, true, false, false, false] //?
    , [true, false, true, true, false, false] //!
    , [true, true, true, true, false, false] //()
    , [true, true, false, true, false, true] //Number
    , [false, true, false, false, false, false] //Capital
    , [false, true, false, true, false, false] //Letter
    , [false, false, true, true, false, true] //0    
    , [false, false, false, false, true, false] //1
    , [false, false, true, false, true, false] //2
    , [false, false, false, false, true, true] //3
    , [false, false, false, true, true, true] //4
    , [false, false, false, true, true, false] //5
    , [false, false, true, false, true, true] //6
    , [false, false, true, true, true, true] //7
    , [false, false, true, true, true, false] //8
    , [false, false, true, false, false, true] //9    
];

showBackPiece();
showWord(PHRASE);

module showBackPiece() {
    translate([0,3,0])
        color(baseColor)
            cube([((biWidth+tbtGap)*len(PHRASE))-tbtGap,biDepth,biHeight],false);
}
module showWord(word) {
    for(pos = [0:len(word)-1]){
        echo(ord(word[pos]));
        // translate character to braille alphabet
        charValue = ord(word[pos]);
        
        // 0-9 < TODO must prefix
        if((charValue>=48)&&(charValue<=57)) {            
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[charValue-8]);
        }
        // A-Z
        if((charValue>=65)&&(charValue<=90)) {                   
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[charValue-65]);
        }
        // a-z
        if((charValue>=97)&&(charValue<=122)) {                   
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[charValue-97]);
        }
        // space
        if(charValue==32){
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[28]);
        }
        // -
        if(charValue==45){
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[29]);
        }
        // .
        if(charValue==46){
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[33]);
        }
        // !
        if(charValue==33){
            translate([pos*(biWidth+tbtGap), 0, 0])
                showBrailleItem(BRAILLE_ALPHABET[35]);
        }
    }
}

module showBrailleItem(letterArray) {
    // back plate
    color(tbtColor)
        cube([biWidth,biDepth,biHeight],false);
    
    translate([biSpaceA,0,biSpaceX])
    for (rowId = [0:1:1]){                
        // column from bottom to top
        for (colId = [0:1:2]){
            if(letterArray[((colId*2)+rowId)]==true) {
                translate([rowId*biSpaceB,0,biSpaceY*colId])
                    color(biColor)
                        sphere(biRadius, $fn=32);
            }
        }
        translate([biSpaceB,0,0]);
    }
}
