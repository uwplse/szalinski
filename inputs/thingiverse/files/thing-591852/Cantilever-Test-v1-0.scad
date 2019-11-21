

// Length of longest overhang
_maxOverhang = 30;

// Length difference between each overhanging bar
_increment = 3;

// height of each bar
_height = 2;

// size of the center column (also the width of each bar)
_size = 4;


module make() {
	maxLevel = floor(_maxOverhang/_increment);
	union() {
		for(level = [0:maxLevel]) {
			assign(length = level * _increment) {
				translate([level%2==0 ? -length : 0, 0, _height * level])
					cube([length+_size, _size, _height]);
			}
		}

		// base
		translate([-_size,-_size,0])
		cube([_size*3,_size*3,0.3]);
	}
}

make();