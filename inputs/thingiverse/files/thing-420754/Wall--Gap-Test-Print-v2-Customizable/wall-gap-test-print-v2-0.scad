use <write/Write.scad>


// wall/gap test print (vertical)


/*[Setup]*/

// wall height or gap test
_style = 2; //[1:Wall,2:Gap]

// start thickness
_start = 0.2;

// end thickness
_end = 2.0;

// thickness difference between samples
_increment = 0.2;

// space between samples
_gap = 3.6;

// wall height (ignored for gaps)
_height = 3; // [1:16]

// wall or gap length
_length = 16; // [1:64]

// thickness of the base
_baseHeight = 1.0;


/*[Text]*/

// title for the test print
_title = "GAP TEST PRINT";

// depth of text emboss
_textEmboss = 0.25;

// height of title text
_titleHeight = 4; // [1:16]

// height of numerical text
_fontHeight = 3; // [1:16]


/*[Whitespace]*/

// space between the test and samples
_textGap = 3; // [1:8]

// whitespace margin around the outside, affects corner radius
_edgePadding = 5; // [1:8]

/*[Ignore]*/
eps = 0.1 * 1; // ignore
$fn=48 * 1; // ignore

////////////////////////////////////////////////////////////

module rrect(h, w, l, r) {
	r = min(r, min(w/2, l/2));
	w = max(w, eps);
	l = max(l, eps);
	h = max(h, eps);
	if (r <= 0) {
		translate([-w/2, -l/2,0]) {
			cube([w,l,h]);
		}
	} else {
		hull() {
			for (y = [-l/2+r, l/2-r]) {
				for (x = [-w/2+r, w/2-r]) {
					translate([x,y,0]) {
						cylinder(h=h, r=r, center=false);
					}
				}
			}
		}
	}
}


module thinWallTest() {

	module addWallGrid(count, wallHeight) {
		module addWall(thickness, xspacing, xpos, h) {
			//echo (xpos, thickness);
			translate([xspacing * xpos, 0, 0]) {
				cube([thickness, _length, h]);
			}
		}
	
		xspacing = _gap + _end;
		for (index = [0:count-1]) {
			assign(thickness = _start + _increment * index) {
				translate([-thickness/2, 0, 0]) {
					addWall(thickness, xspacing, index, wallHeight);
				}
			}
		}
	}
	
	module addTextGrid(count, wallHeight) {
	
		module addText(thickness, xspacing, xpos) {
			//!@# get font length
			translate([xspacing * xpos + _fontHeight/2, _length + _textGap, 0]) {
				rotate(90,00,0) {
					write(str(thickness), t=_textEmboss+eps, h=_fontHeight, font="write/orbitron.dxf", space=1);
				}
			}
		}
	
		xspacing = _gap + _end;
		for (index = [0:count-1]) {
			assign(thickness = _start + _increment * index) {
					addText(thickness, xspacing, index);
			}
		}
	}

	function maxFast(a,b) = (a >= b) ? a : b; // using the builtin max will be really slow O(2^n) vs O(n) : https://github.com/openscad/openscad/issues/738

	// count the max number of characters in the display strings
	function maxChars(start, increment, end, chars) = 
		start >= end ? chars : maxFast(chars, maxChars(start+increment, increment, end, len(str(start)) ) );

	fontLength = maxChars(_start, _increment, _end, 0);
	count = round((_end-_start)/_increment)+1;
	xspacing = _gap + _end;
	xdim = xspacing * (count-1) + _fontHeight;
	xdim = xspacing * (count-1) + _fontHeight + _end;
	ydim = _length + _titleHeight + _textGap*2 + _fontHeight * fontLength * (2/3);
	difference() {
		if (_style == 1) {
			// walls
			union () {
				translate([xdim/2-xspacing/2, ydim/2 - _titleHeight - _textGap,-_baseHeight]) {
					rrect(_baseHeight, xdim + _edgePadding*2, ydim + _edgePadding*2, _edgePadding);
				}
				addWallGrid(count, _height);
			}
		} else {
			// gaps
			difference () {
				translate([xdim/2-xspacing/2, ydim/2 - _titleHeight - _textGap,-_baseHeight]) {
					rrect(_baseHeight, xdim + _edgePadding*2, ydim + _edgePadding*2, _edgePadding);
				}
				translate([0, 0, -_baseHeight-eps]) {
					addWallGrid(count, _baseHeight+eps*2);
				}
			}
		}

		// labels
		translate([0, 0, -_textEmboss]) {
			addTextGrid(count, _textEmboss + eps);
		}

		// title
		translate([xdim/2 - xspacing/2, -_textGap - _titleHeight/2, -_textEmboss/2+eps/2]) {
			rotate([0,0,180])
			write(_title, t=_textEmboss+eps, h=_titleHeight, font="write/orbitron.dxf", space=1.2, center=true);
		}
	}
}

thinWallTest();

