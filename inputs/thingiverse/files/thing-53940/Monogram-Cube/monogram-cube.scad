// Monogram Cube
// v 1.1
// Inspired by the cover art of Douglas Hofstadter's "Godel, Escher, Bach"
//
// (C) Copyright 2013, Brian Enigma, some rights reserved.
//
// Monogram Cube by Brian Enigma is licensed under a Creative Commons 
// Attribution-ShareAlike 3.0 Unported License.
//
// - http://netninja.com
// - http://www.thingiverse.com/BrianEnigma

// Note that certain letter combinations don't work well, especially with the "alternate" typeface.

SIZE = 40 * 1;
DETAIL = 30 * 1;

// The typeface to use.  "Blocks" yields better results, but is more stylistic and block-like.  It reminds me of some display typefaces from the 20s and 30s. It has smaller overhangs and is easier to print.  "Alternate" results in more consistently letter-like, less stylized results, but has more overhangs and is harder to print.
typeface = "blocks";     // [blocks, alternate]

top_letter = "A";        // [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,None]
left_side_letter = "B";  // [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,None]
right_side_letter = "C"; // [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,None]


//include <letters.scad>

// ----------------------------------------
// Monogram Cube
// v 1.1
// Inspired by the cover art of Douglas Hofstadter's "Godel, Escher, Bach"
//
// (C) Copyright 2013, Brian Enigma, some rights reserved.
//
// Monogram Cube by Brian Enigma is licensed under a Creative Commons 
// Attribution-ShareAlike 3.0 Unported License.
//
// - http://netninja.com
// - http://www.thingiverse.com/BrianEnigma

// arc() builds a lower-left corner arc by default
// +
// |\
// |  \
// |    \
// +------+
module arc(cubeSize, rotation, x, y)
{
    translate(v = [(cubeSize / 4 + 1) / 2 + x, (cubeSize / 4 + 1) / 2 + y, (cubeSize + 2) / 2 - 1])
		rotate(a = [0, 0, -1 * rotation])
		    translate(v = [(cubeSize / 4 + 1) / -2, (cubeSize / 4 + 1) / -2, (cubeSize + 2) / -2])
		        difference()
		        {
		            cube(size = [cubeSize / 4 + 1, cubeSize / 4 + 1, cubeSize + 2]);
		            translate(v = [cubeSize / 4 + 1, cubeSize / 4 + 1, 0])
		                cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
		        }
}

module arcWithMargin(cubeSize, rotation, marginX, marginY, x, y)
{
	if (90 == rotation || 270 == rotation)
	{
	    translate(v = [(cubeSize / 4 + marginY) / 2 + x, (cubeSize / 4 + marginX) / 2 + y, (cubeSize + 2) / 2 - 1])
			rotate(a = [0, 0, -1 * rotation])
			    translate(v = [(cubeSize / 4 + marginX) / -2, (cubeSize / 4 + marginY) / -2, (cubeSize + 2) / -2])
			        difference()
			        {
			            cube(size = [cubeSize / 4 + marginX, cubeSize / 4 + marginY, cubeSize + 2]);
			            translate(v = [cubeSize / 4 + marginX, cubeSize / 4 + marginY, 0])
			                cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
			        }
	} else {
	    translate(v = [(cubeSize / 4 + marginX) / 2 + x, (cubeSize / 4 + marginY) / 2 + y, (cubeSize + 2) / 2 - 1])
			rotate(a = [0, 0, -1 * rotation])
			    translate(v = [(cubeSize / 4 + marginX) / -2, (cubeSize / 4 + marginY) / -2, (cubeSize + 2) / -2])
			        difference()
			        {
			            cube(size = [cubeSize / 4 + marginX, cubeSize / 4 + marginY, cubeSize + 2]);
			            translate(v = [cubeSize / 4 + marginX, cubeSize / 4 + marginY, 0])
			                cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
			        }
	}
}

module carveLetterA(cubeSize)
{
    // lower cut-out
    translate(v = [cubeSize / 4, -1, -1])
        cube(size = [cubeSize / 2, cubeSize / 4 + 1, cubeSize + 2]);
    // center hole
    translate(v = [cubeSize / 2, cubeSize * 5 / 8, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
}

module carveLetterB(cubeSize)
{
    // center holes
    translate(v = [cubeSize / 2, cubeSize * 3 / 4, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    translate(v = [cubeSize / 2, cubeSize * 1 / 4, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // edge divot
	arcWithMargin(cubeSize, 270, 0, 5, cubeSize * 3 / 4, cubeSize / 2 - 0.1); // upper
	arcWithMargin(cubeSize, 180, 5, 0, cubeSize * 3 / 4, cubeSize / 4 + 0.1); // lower
}

module carveLetterC(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize * 3 / 4, cubeSize * 3 / 8, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 4, cubeSize + 2]);
}

module carveLetterCAlt(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
	translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
    translate(v = [cubeSize / 2, cubeSize / 4, -1])
		cube(size = [cubeSize / 2 + 1, cubeSize / 2, cubeSize + 2]);
}

module carveLetterD(cubeSize)
{
    // center hole
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
}

module carveLetterDAlt(cubeSize)
{
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
	// Cutout
	translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
    translate(v = [cubeSize / 4, cubeSize / 4, -1])
		cube(size = [cubeSize / 4, cubeSize / 2, cubeSize + 2]);
}

module carveLetterE(cubeSize)
{
    // upper cut-out
    translate(v = [cubeSize * 3 / 4, cubeSize * 5 / 8, -1])
        cube(size = [cubeSize / 4 + 1, cubeSize / 8, cubeSize + 2]);
    // lower cut-out
    translate(v = [cubeSize * 3 / 4, cubeSize / 4, -1])
        cube(size = [cubeSize / 4 + 1, cubeSize / 8, cubeSize + 2]);
}

module carveLetterEAlt(cubeSize)
{
    // upper cut-out
    translate(v = [cubeSize / 4, cubeSize * 5 / 8, -1])
        cube(size = [cubeSize * 3 / 4 + 1, cubeSize / 8, cubeSize + 2]);
    // lower cut-out
    translate(v = [cubeSize / 4, cubeSize  / 4, -1])
        cube(size = [cubeSize * 3 / 4 + 1, cubeSize / 8, cubeSize + 2]);
	// middle prong
    translate(v = [cubeSize * 5 / 8, cubeSize * 3 / 8 - 1, -1])
        cube(size = [cubeSize / 2, cubeSize / 4 + 2, cubeSize + 2]);
}

module carveLetterF(cubeSize)
{
	// Upper cutout
    translate(v = [cubeSize * 3 / 4, cubeSize / 2, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 4, cubeSize + 2]);
	// Lower cutout
    translate(v = [cubeSize * 3 / 4, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterFAlt(cubeSize)
{
	// Upper cutout
    translate(v = [cubeSize / 4, cubeSize / 2, -1])
		cube(size = [cubeSize * 3/ 4 + 1, cubeSize / 4, cubeSize + 2]);
	// Lower cutout
    translate(v = [cubeSize / 4, -1, -1])
		cube(size = [cubeSize * 3 / 4 + 1, cubeSize / 4 + 1, cubeSize + 2]);
    translate(v = [cubeSize * 5 / 8, cubeSize / 4 - 1, -1])
        cube(size = [cubeSize / 2, cubeSize / 4 + 2, cubeSize + 2]);
}

module carveLetterG(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize * 3 / 4, cubeSize * 3 / 8, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 4, cubeSize + 2]);
}

module carveLetterGAlt(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
	translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cube(size = [cubeSize / 2 + 1, cubeSize / 4, cubeSize + 2]);
    translate(v = [cubeSize / 2, cubeSize / 4, -1])
		cube(size = [cubeSize / 4, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterH(cubeSize)
{
    // lower cut-out
    translate(v = [cubeSize / 4, -1, -1])
        cube(size = [cubeSize / 2, cubeSize / 4 + 1, cubeSize + 2]);
    // upper cut-out
    translate(v = [cubeSize / 4, cubeSize * 3 / 4, -1])
        cube(size = [cubeSize / 2, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterHAlt(cubeSize)
{
    // lower cut-out
    translate(v = [cubeSize / 4, -1, -1])
        cube(size = [cubeSize / 2, cubeSize * 3 / 8 + 1, cubeSize + 2]);
    // upper cut-out
    translate(v = [cubeSize / 4, cubeSize * 5 / 8, -1])
        cube(size = [cubeSize / 2, cubeSize * 3 / 8 + 1, cubeSize + 2]);
}

module carveLetterI(cubeSize)
{
    // left cut-out
    translate(v = [-1, cubeSize / 4, -1])
        cube(size = [cubeSize / 4 + 1, cubeSize / 2, cubeSize + 2]);
    // right cut-out
    translate(v = [cubeSize * 3 / 4, cubeSize / 4, -1])
        cube(size = [ cubeSize / 4 + 1, cubeSize / 2,cubeSize + 2]);
}

module carveLetterIAlt(cubeSize)
{
    // left cut-out
    translate(v = [-1, cubeSize / 4, -1])
        cube(size = [cubeSize * 3 / 8 + 1, cubeSize / 2, cubeSize + 2]);
    // right cut-out
    translate(v = [cubeSize * 5 / 8, cubeSize / 4, -1])
        cube(size = [ cubeSize * 3 / 8 + 1, cubeSize / 2,cubeSize + 2]);
}

module carveLetterJ(cubeSize)
{
    //// top right corner curve
	//arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [-1, cubeSize / 2, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterJAlt(cubeSize)
{
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
	translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
    translate(v = [-1, cubeSize / 2, -1])
		cube(size = [cubeSize * 3 / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterK(cubeSize)
{
	// Upper leg
	translate(v = [cubeSize / 2, cubeSize, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 4, cubeSize * 3 / 4, -1])
		cube(size = [cubeSize / 4, cubeSize / 4 + 1, cubeSize + 2]);
	// Lower leg
	translate(v = [cubeSize / 2, 0, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 4, -1, -1])
		cube(size = [cubeSize / 4, cubeSize / 4 + 1, cubeSize + 2]);
    // edge divot
	arc(cubeSize, 270, cubeSize * 3 / 4, cubeSize / 2); // upper
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize / 4); // lower
	
}

module carveLetterKAlt(cubeSize)
{
	// Upper leg
	translate(v = [cubeSize / 2, cubeSize * 7 / 8, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 4, cubeSize * 5 / 8, -1])
		cube(size = [cubeSize / 4, cubeSize / 2, cubeSize + 2]);
	translate(v = [cubeSize / 2 - 1, cubeSize * 7 / 8, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 4, cubeSize + 2]);
	// Lower leg
	translate(v = [cubeSize / 2, cubeSize / 8, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 4, -1, -1])
		cube(size = [cubeSize / 4, cubeSize * 3 / 8 + 1, cubeSize + 2]);
	translate(v = [cubeSize / 2 - 1, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 8 + 1, cubeSize + 2]);
    // edge divot
	arc(cubeSize, 270, cubeSize * 3 / 4, cubeSize / 2); // upper
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize / 4); // lower
	
}

module carveLetterL(cubeSize)
{
	// Cutout
    translate(v = [cubeSize * 3 / 4, cubeSize / 2, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterLAlt(cubeSize)
{
	// Cutout
    translate(v = [cubeSize / 4, cubeSize / 4, -1])
		cube(size = [cubeSize * 4 / 4 + 1, cubeSize * 3 / 4 + 1, cubeSize + 2]);
}

module carveLetterM(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // divot
	arcWithMargin(cubeSize, 180, 0.1, 5, cubeSize / 4 + 0.1, cubeSize * 3 / 4); // left
	arcWithMargin(cubeSize,  90, 5, 0.1, cubeSize / 2 - 0.1, cubeSize * 3 / 4); // right
	// Cutouts
    translate(v = [cubeSize / 4, -1, -1])
		cube(size = [cubeSize / 8, cubeSize / 4 + 1, cubeSize + 2]);
    translate(v = [cubeSize * 5 / 8, -1, -1])
		cube(size = [cubeSize / 8, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterN(cubeSize)
{
    // top
	arcWithMargin(cubeSize, 180, 0, 5, cubeSize * 3 / 8, cubeSize * 3 / 4);
	// bottom
	arcWithMargin(cubeSize,   0, 0, 5, cubeSize * 3 / 8, -5);
}

module carveLetterO(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 8, h = cubeSize + 2,$fn = DETAIL);
}

module carveLetterOAlt(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2,$fn = DETAIL);
}

module carveLetterP(cubeSize)
{
    // center holes
    translate(v = [cubeSize / 2, cubeSize * 3 / 4, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
	arcWithMargin(cubeSize, 270, 5, 5, cubeSize * 3 / 4, cubeSize / 2 - 5);
	// cuout
	translate(v = [cubeSize * 3 / 4, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterPAlt(cubeSize)
{
    // center holes
    translate(v = [cubeSize / 2, cubeSize * 3 / 4, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
	arcWithMargin(cubeSize, 270, 5, 5, cubeSize * 3 / 4, cubeSize / 2 - 5);
	// cuout
	translate(v = [cubeSize / 2, -1, -1])
		cube(size = [cubeSize / 2 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterQ(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 8, h = cubeSize + 2,$fn = DETAIL);
}

module carveLetterR(cubeSize)
{
    // center holes
    translate(v = [cubeSize / 2, cubeSize * 3 / 4, -1])
        cylinder(r = cubeSize / 8, h = cubeSize + 2, $fn = DETAIL);
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
	arcWithMargin(cubeSize, 270, 0, 5, cubeSize * 3 / 4, cubeSize / 2 - 0.1); // upper
	arcWithMargin(cubeSize, 180, 5, 0, cubeSize * 3 / 4, cubeSize / 4 + 0.1); // lower
	// cuout
	translate(v = [cubeSize / 2, 0, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 4, -1, -1])
		cube(size = [cubeSize / 4, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterS(cubeSize)
{
    // top left corner curve
	arc(cubeSize, 90, -1, cubeSize * 3 / 4 + 1);
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // left
	arcWithMargin(cubeSize,   0, 5, 0, -5, cubeSize * 3 / 8);
	// right
	arcWithMargin(cubeSize, 180, 5, 0, cubeSize * 3 / 4, cubeSize * 3 / 8);
}

module carveLetterT(cubeSize)
{
	translate(v = [-1, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize * 5 / 8 + 1, cubeSize + 2]);
	translate(v = [cubeSize * 3 / 4, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize * 5 / 8 + 1, cubeSize + 2]);
}

module carveLetterU(cubeSize)
{
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize / 4, cubeSize * 3 / 4, -1])
		cube(size = [cubeSize / 2, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterUAlt(cubeSize)
{
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
	// Cutout
    translate(v = [cubeSize / 2, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2,$fn = DETAIL);
    translate(v = [cubeSize / 4, cubeSize / 2, -1])
		cube(size = [cubeSize / 2, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterV(cubeSize)
{
	translate(v = [0, 0, -1])
		linear_extrude(height = cubeSize + 2, center = false, convexity = 3)
			polygon(points = [[-0.1, cubeSize * 3 / 8], [cubeSize * 3 / 8, -0.1], [-0.1, -0.1]], paths = [[0, 1, 2]], convexity = 3);
	translate(v = [0, 0, -1])
		linear_extrude(height = cubeSize + 2, center = false, convexity = 3)
			polygon(points = [[cubeSize * 5 / 8, - 0.1], [cubeSize + 0.1, cubeSize * 3 / 8 + 0.1], [cubeSize + 0.1, -0.1]], paths = [[0, 1, 2]], convexity = 3);
	translate(v = [0, 0, -1])
		linear_extrude(height = cubeSize + 2, center = false, convexity = 3)
			polygon(points = [[cubeSize / 4, cubeSize + 0.1], [cubeSize * 3 / 4, cubeSize + 0.1], [cubeSize / 2, cubeSize * 5 / 8]], paths = [[0, 1, 2]], convexity = 3);
}

module carveLetterW(cubeSize)
{
    // bottom right corner curve
	arc(cubeSize, 270, cubeSize * 3 / 4, -1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
    // divot
	arcWithMargin(cubeSize, 270, 5, 0.1, cubeSize / 4 + 0.1, -5); // left
	arcWithMargin(cubeSize,   0, 0.1, 5, cubeSize / 2 - 0.1, -5); // right
	// Cutouts
    translate(v = [cubeSize / 4, cubeSize * 3 / 4, -1])
		cube(size = [cubeSize / 8, cubeSize / 4 + 1, cubeSize + 2]);
    translate(v = [cubeSize * 5 / 8, cubeSize * 3 / 4, -1])
		cube(size = [cubeSize / 8, cubeSize / 4 + 1, cubeSize + 2]);
}

module carveLetterX(cubeSize)
{
	translate(v = [cubeSize / 2, 0, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [0, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize / 2, cubeSize, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	translate(v = [cubeSize, cubeSize / 2, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
}

module carveLetterY(cubeSize)
{
	translate(v = [cubeSize / 2, cubeSize, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	// right arc
	arcWithMargin(cubeSize, 270, 5, 5, cubeSize * 3 / 4, cubeSize / 2 - 5);
	// right cuout
	translate(v = [cubeSize * 3 / 4, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
	// left arc
	arcWithMargin(cubeSize, 0, 5, 5, -5, cubeSize / 2 - 5);
	// left cuout
	translate(v = [-1, -1, -1])
		cube(size = [cubeSize / 4 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterYAlt(cubeSize)
{
	translate(v = [cubeSize / 2, cubeSize, -1])
		cylinder(r = cubeSize / 4, h = cubeSize + 2, $fn = DETAIL);
	// right arc
	arcWithMargin(cubeSize, 270, 5, 5, cubeSize * 3 / 4, cubeSize / 2 - 5);
	// right cuout
	translate(v = [cubeSize * 5 / 8, -1, -1])
		cube(size = [cubeSize * 3 / 8 + 1, cubeSize / 2 + 1, cubeSize + 2]);
	// left arc
	arcWithMargin(cubeSize, 0, 5, 5, -5, cubeSize / 2 - 5);
	// left cuout
	translate(v = [-1, -1, -1])
		cube(size = [cubeSize * 3 / 8 + 1, cubeSize / 2 + 1, cubeSize + 2]);
}

module carveLetterZ(cubeSize)
{
    // top right corner curve
	arc(cubeSize, 180, cubeSize * 3 / 4, cubeSize * 3 / 4 + 1);
    // bottom left corner curve
	arc(cubeSize, 0, -1, -1);
    // left
	arcWithMargin(cubeSize,  90, 0, 5, -5, cubeSize * 3 / 8);
	// right
	arcWithMargin(cubeSize, 270, 0, 5, cubeSize * 3 / 4, cubeSize * 3 / 8);
}

module carveLetter(typeface, theLetter, cubeSize)
{
	// Function pointers are fun
    if (theLetter == "A")
        carveLetterA(cubeSize);
    if (theLetter == "B")
        carveLetterB(cubeSize);
    if (theLetter == "C")
	{
		if (typeface == "alternate")
			carveLetterCAlt(cubeSize);
		else
        	carveLetterC(cubeSize);
	}
    if (theLetter == "D")
	{
		if (typeface == "alternate")
			carveLetterDAlt(cubeSize);
		else
        	carveLetterD(cubeSize);
	}
    if (theLetter == "E")
	{
		if (typeface == "alternate")
			carveLetterEAlt(cubeSize);
		else
        	carveLetterE(cubeSize);
	}
    if (theLetter == "F")
	{
		if (typeface == "alternate")
			carveLetterFAlt(cubeSize);
		else
        	carveLetterF(cubeSize);
	}
    if (theLetter == "G")
	{
		if (typeface == "alternate")
			carveLetterGAlt(cubeSize);
		else
        	carveLetterG(cubeSize);
	}
    if (theLetter == "H")
	{
		if (typeface == "alternate")
			carveLetterHAlt(cubeSize);
		else
        	carveLetterH(cubeSize);
	}
    if (theLetter == "I")
	{
		if (typeface == "alternate")
			carveLetterIAlt(cubeSize);
		else
        	carveLetterI(cubeSize);
	}
    if (theLetter == "J")
	{
		if (typeface == "alternate")
			carveLetterJAlt(cubeSize);
		else
        	carveLetterJ(cubeSize);
	}
    if (theLetter == "K")
	{
		if (typeface == "alternate")
			carveLetterKAlt(cubeSize);
		else
        	carveLetterK(cubeSize);
	}
    if (theLetter == "L")
	{
		if (typeface == "alternate")
			carveLetterLAlt(cubeSize);
		else
        	carveLetterL(cubeSize);
	}
    if (theLetter == "M")
        carveLetterM(cubeSize);
    if (theLetter == "N")
        carveLetterN(cubeSize);
    if (theLetter == "O")
	{
		if (typeface == "alternate")
			carveLetterOAlt(cubeSize);
		else
        	carveLetterO(cubeSize);
	}
    if (theLetter == "P")
	{
		if (typeface == "alternate")
			carveLetterPAlt(cubeSize);
		else
        	carveLetterP(cubeSize);
	}
    if (theLetter == "Q")
        carveLetterQ(cubeSize);
    if (theLetter == "R")
        carveLetterR(cubeSize);
    if (theLetter == "S")
        carveLetterS(cubeSize);
    if (theLetter == "T")
       	carveLetterT(cubeSize);
    if (theLetter == "U")
	{
		if (typeface == "alternate")
			carveLetterUAlt(cubeSize);
		else
        	carveLetterU(cubeSize);
	}
    if (theLetter == "V")
        carveLetterV(cubeSize);
    if (theLetter == "W")
        carveLetterW(cubeSize);
    if (theLetter == "X")
        carveLetterX(cubeSize);
    if (theLetter == "Y")
	{
		if (typeface == "alternate")
			carveLetterYAlt(cubeSize);
		else
        	carveLetterY(cubeSize);
	}
    if (theLetter == "Z")
        carveLetterZ(cubeSize);
}
// ----------------------------------------

module carveBlock(typeface, letter1, letter2, letter3)
{
	translate(v = [SIZE / -2, SIZE / -2, 0])
	    difference()
	    {
	        cube(size = [SIZE, SIZE, SIZE]);
	        // Top letter
	        carveLetter(typeface, letter3, SIZE);
	        // Front letter
	        translate(v = [0, SIZE, 0])
	            rotate(a = [90, 0, 0])
	                carveLetter(typeface, letter1, SIZE);
	        // Side letter
	        translate(v = [0, 0, 0])
	            rotate(a = [0, 90, 0])
	                rotate(a = [0, 0, 90])
	                    carveLetter(typeface, letter2, SIZE);
	    }
}

module test()
{
    difference()
    {
        cube(size = [SIZE, SIZE, SIZE]);
        // Top letter
        carveLetterFAlt(SIZE);
    }
}

carveBlock(typeface, left_side_letter, right_side_letter, top_letter);

// Test code:
//carveBlock(typeface, "B", "E", "A");
//carveBlock(typeface, "G", "E", "B");
//test();

