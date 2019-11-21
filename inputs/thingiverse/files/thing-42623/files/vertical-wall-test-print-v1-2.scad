// wall/gap test print (vertical)


// wall height or gap test
_1_style = 1; //[1:Wall,2:Gap]

// start thickness
_2_start = 0.1;

// end thickness
_3_end = 2.0;

// thickness increment between samples
_4_increment = 0.1;

// space between samples
_5_gap = 3.0; // [1:10]

// wall height
_6_height = 4; // [1:50]

// wall length
_7_length = 10; // [1:50]

// thickness of the base
_8_baseHeight = 1.0; // [1:10]

// number of columns across
_9_numColumns = 10; // [1:20]

// ignore (angle resolution)
$fn=60;

////////////////////////////////////////////////////////////
module addWall(thickness, xspacing, yspacing, xpos, ypos, h) {
	echo (ypos, xpos, thickness);
	translate([xspacing * xpos, -yspacing * ypos, 0]) {
		cube([thickness, _7_length, h]);
	}
}

module addWallGrid(wallHeight) {
	count = round((_3_end-_2_start)/_4_increment)+1;
	xspacing = _5_gap + _3_end;
	yspacing = _5_gap + _7_length;
	translate([_5_gap, -_5_gap - _7_length, 0]) {
		for (index = [0:count-1]) {
			assign(thickness = _2_start + _4_increment * index) {
				translate([-thickness/2, 0, 0]) {
					addWall(thickness, xspacing, yspacing, index%_9_numColumns, floor(index/_9_numColumns), wallHeight);
				}
			}
		}
	}
}

module addBase(x, y, height) {
	translate([0, 0, -height*.75]) {
		minkowski() {
			cube([x, y, height/2]);
			cylinder(r=_5_gap,h=height/4);
		}
	}
}

module thinWallTest() {
	count = round((_3_end-_2_start)/_4_increment)+1;
	xspacing = _5_gap + _3_end;
	yspacing = _5_gap + _7_length;
	xdim = xspacing * min(_9_numColumns, count);
	ydim = yspacing * ceil(count/_9_numColumns)+_5_gap;
	if (_1_style == 1) {
		union () {
			addBase(xdim, ydim, _8_baseHeight);
			translate([0, ydim, 0]) { 
				addWallGrid(_6_height);
			}
		}
	} else {
		difference () {
			addBase(xdim, ydim, _8_baseHeight);
			translate([0, ydim, -_8_baseHeight-1]) {
				addWallGrid(_8_baseHeight+2);
			}
		}
	}	
}

thinWallTest();