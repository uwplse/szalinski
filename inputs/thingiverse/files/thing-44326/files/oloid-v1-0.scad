
_type = 2; //[1:Full Oloid, 2:Half Oloid]

// oloid radius (final size will be about 2*radius x 3*radius)
_radius = 20; // [4:100]

// Gap between the pegs and the holes.  Increase this value if the pegs will not fit in the holes.
_pegGap = 0.0;

// Depth of the pegs / holes
_pegHeight = 3; // [0:10]

/////////////////////////////////////////////

module oloid(radius) {
	dist = radius; 
	hull() {
		translate([-dist/2,0,0]) {
			cylinder(r=radius, h=0.1, center=true);	
		}
		rotate(a=90, v=[1,0,0]) {
			translate([dist/2,0,0]) {
				cylinder(r=radius, h=0.1, center=true);
			}
		}
	}
}

module halfOloid(radius, pegHeight, gap) {
	offset = radius/2;
	pegSize = radius/8;
	union() {

		difference() {
			oloid(radius);
			translate([-radius*2,0,0]) {
				cube(size=radius * 4, center=true);
			}

			// hole
			if (pegHeight > 0) {
				rotate(a=-90, v=[0,1,0]) {
					for (x=[-offset, offset]) {
						translate([x,0,-pegHeight-gap-0.2]) {
							cylinder(r=pegSize+gap, h = pegHeight+gap+1);
						}
					}
				}
			}
		}
		
		// peg
		if (pegHeight > 0) {
			rotate(a=-90, v=[0,1,0]) {
				for (y=[-offset, offset]) {
					translate([0,y,-0.1]) {
						cylinder(r=pegSize, h = pegHeight+.1);
					}
				}
			}
		}
	}	
}

module run($fn=180) {
	if (_type == 2) {
		halfOloid(_radius, _pegHeight, _pegGap);
	} else {
		oloid(_radius);
	}
}

run();