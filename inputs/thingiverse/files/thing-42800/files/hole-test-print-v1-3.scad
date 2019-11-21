// hole/column test print (vertical)


// wall height or gap test
_1_style = 2; //[1:Column, 2:Hole]

// start thickness
_2_start = 0.1;

// end thickness
_3_end = 3;

// thickness increment between samples
_4_increment = 0.1;

// space between samples
_5_gap = 3.0; // [1:10]

// column height
_6_height = 4; // [1:50]

// thickness of the base
_7_baseHeight = 1.0; // [1:10]

// number of columns across
_8_numColumns = 10; // [1:20]


////////////////////////////////////////////////////////////
module addPillar(diameter, spacing, xpos, ypos, height) {
	echo (ypos, xpos, diameter);
	translate([spacing * xpos, -spacing * ypos, 0]) {
		cylinder(h=height, r=diameter/2, center=false);
	}
}

module addBase(x, y, h, gap) {
	translate([0, 0, -h*.75]) {
		minkowski() {
			cube([x, y, h/2]);
			cylinder(r=gap,h=h/4);
		}
	}
}

module addColumnGrid(start, end, increment, pillarHeight,columns,gap) {
	count = round((end-start)/increment)+1;
	spacing = gap + end;

	translate([spacing/2, -spacing/2, 0]) {
		for (index = [0:count-1]) {
			assign(diameter = start + increment * index) {
				addPillar(diameter, spacing, index%columns, floor(index/columns), pillarHeight);
			}
		}
	}
}

module columnTest($fn=30) {
	count = round((_3_end-_2_start)/_4_increment)+1;
	spacing = _5_gap + _3_end;
	xdim = spacing * min(_8_numColumns, count);
	ydim = spacing * ceil(count/_8_numColumns);
	if (_1_style == 1) {
		union () {
			addBase(xdim, ydim, _7_baseHeight, _5_gap);
			translate([0, ydim, 0]) { 
				addColumnGrid(_2_start,_3_end,_4_increment,_6_height,_8_numColumns,_5_gap);
			}
		}
	} else {
		difference () {
			addBase(xdim, ydim, _7_baseHeight, _5_gap);
			translate([0, ydim, -_7_baseHeight-1]) {
				addColumnGrid(_2_start,_3_end,_4_increment,_7_baseHeight+2,_8_numColumns,_5_gap);
			}
		}
	}	
}

columnTest();