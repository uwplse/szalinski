/*
    Braille Fridge Magnet
    Spencer Barton

    based on http://www.thingiverse.com/thing:47411 by kitwallace

    Directions: Upload your alphebetic character [A-Z,a-z] to be converted to braille and placed on a tag

*/

use <Write.scad>

/*===================================================
  Global Vars
  =================================================== */

// encodings
font_charKeys = ["a", "A", "b", "B", "c", "C", "d", "D", "e", "E", "f", "F", "g", "G", "h", "H", "i", "I", "j", "J", "k", "K", "l", "L", "m", "M", "n", "N", "o", "O", "p", "P", "q", "Q", "r", "R", "s", "S", "t", "T", "u", "U", "v", "V", "w", "W", "x", "X", "y", "Y", "z", "Z", ",", ";", ":", ".", "!", "(", ")", "?", "\"", "*", "'", "-"];
font_charValues = [[1], [1], [1, 2], [1, 2], [1, 4], [1, 4], [1, 4, 5], [1, 4, 5], [1, 5], [1, 5], [1, 2, 4], [1, 2, 4], [1, 2, 4, 5], [1, 2, 4, 5], [1, 2, 5], [1, 2, 5], [2, 4], [2, 4], [2, 4, 5], [2, 4, 5], [1, 3], [1, 3], [1, 2, 3], [1, 2, 3], [1, 3, 4], [1, 3, 4], [1, 3, 4, 5], [1, 3, 4, 5], [1, 3, 5], [1, 3, 5], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 5], [1, 2, 3, 5], [2, 3, 4], [2, 3, 4], [2, 3, 4, 5], [2, 3, 4, 5], [1, 3, 6], [1, 3, 6], [1, 2, 3, 6], [1, 2, 3, 6], [2, 4, 5, 6], [2, 4, 5, 6], [1, 3, 4, 6], [1, 3, 4, 6], [1, 3, 4, 5, 6], [1, 3, 4, 5, 6], [1, 3, 5, 6], [1, 3, 5, 6], [2], [2, 3], [2, 5], [2, 5, 6], [2, 3, 5], [2, 3, 5, 6], [2, 3, 5, 6], [2, 3, 6], [2, 3, 6], [3, 5], [3], [3, 6]];

// compile vars
$fa = 0.01; $fs = 0.5; 

// global dimensions from http://www.brailleauthority.org/sizespacingofbraille/sizespacingofbraille.pdf

// these dimensions for braille letters
font_dotHeight = 0.7;
font_dotBase = 1.6;  
font_dotRadius = font_dotBase /2;
font_dotWidth= 2.54;
font_charWidth = 7.62;
font_lineHeight = 11; 

// compute the sphere to make the raised dot
font_dotSphereRadius =  chord_radius(font_dotBase,font_dotHeight);
font_dotSphereOffset = -(cylinderDepth - 2.0)/2.0 + font_dotSphereRadius - font_dotHeight;

// inputs
letter = "C"; 
cylinderRadius = 8.0;
cylinderDepth = 2.0;
magnetRadius = 2.0;
magnetDepth = 1.0;
guideDots = true;
cylinderMagnet = false;

/*===================================================
  Functions
  =================================================== */

// dot is not a hemisphere 
function chord_radius(length,height) = ( length * length /(4 * height) + height)/2;

/*===================================================
  Modules
  =================================================== */

module drawDot(location, radius) {  
    translate(location) 
       translate ([0,0, -font_dotSphereOffset ]) 
			sphere(radius);
}

module drawCharacter(charMap) {
     for(i = [0: len(charMap)-1]) 
        assign(dot = charMap[i] - 1)
        drawDot(   [floor(dot / 3) * font_dotWidth,  -((dot %3) * font_dotWidth),   0],  font_dotRadius );
}


module transcribeChar(char) {
    // match with one from alphabet
    for(j = [0:len(font_charKeys)-1]) {
        if(font_charKeys[j] == char) {
            drawCharacter(font_charValues[j]);
				echo(font_charKeys[j]);
        }
    }
}

module drawGuideDots() {
	  assign( charMap = [1,2,3,4,5,6] )
     for(i = [0: len(charMap)-1]) 
        assign(dot = charMap[i] - 1)
        drawDot(   [floor(dot / 3) * font_dotWidth,  -((dot %3) * font_dotWidth),   0],  font_dotRadius * .5 );
}

module magnet(letter) {

     difference () {
        union() {
            // main rectangle
            if (cylinderMagnet == true) {
					cylinder(r = cylinderRadius,h = cylinderDepth);
				} else {
					translate([0,0,cylinderDepth/2])
						resize(newsize=[cylinderRadius*2.5,cylinderRadius*2,cylinderDepth]) sphere(r=cylinderRadius);  
				}
            // write regular letter
            translate([-cylinderRadius/3.0,0,cylinderDepth])
					write(letter,t=font_dotSphereOffset,h=cylinderRadius,center=true, font = "orbitron.dxf");
				// chars
				translate([cylinderRadius/4.0,font_dotWidth,cylinderDepth])
            	transcribeChar(letter);
				// indicators
				if (guideDots == true) {
					translate([cylinderRadius/4.0,font_dotWidth,cylinderDepth])
						drawGuideDots();
				}
        } // end union
        
        // hole for magnet
		  translate([0,0,-.5])
            cylinder(r=magnetRadius,h=magnetDepth+1);  
    }

}

/*===================================================
  Run Main Module
  =================================================== */

magnet(letter);
