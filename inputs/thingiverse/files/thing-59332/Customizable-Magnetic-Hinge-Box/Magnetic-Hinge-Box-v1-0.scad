use <utils/build_plate.scad>

_part = "box"; // [box, lid]

// width of the box (affects the length of the hinges)
_width = 36; // [10:300]

// length of the box
_length = 36; // [10:300]

// height of the box
_height = 12; // [4:300]

// rounding radius of the corners of the box
_rounding = 4; // [1:50]

// thickness of the walls around the magnets
_minimumWallThickness = 0.8;

// thickness of the side walls without the hinge
_sidewallThickness = 0.8;

// thickness of the bottom of the box or the top of the lid
_horizontalThickness = 0.8;

// diameter of magnets in the hinge
_magnetDiameter = 3.2;

// height magnets in the hinge
_magnetHeight = 3.2;

// gap bewteen the lid and box parts
_hingeGap = 0.2;


module roundRect(width, depth, height, round) {
	round = min(round, width/2);
	hull() {
		for (w=[-1,1])
		for (d=[-1,1])
		translate([w * (width/2 - round),d * (depth/2 - round),0]) {
			cylinder(r=round, h=height, center=true);
		}
	}
}

module makeBase(width, depth, height, rounding, minimum, side, bottom, mdiameter, mheight, gap) {
	eps = 0.1;
	iwidth = width - side*2;
	idepth = depth - mdiameter*2 - minimum*4;
	hingeCutZ = mdiameter + minimum*2 + gap;
	hingeCutWidth = width - rounding*2 - mheight*2;
	fillet = mdiameter/2 + minimum;

	difference() {
		translate([0,0,height/2]) {
			difference() {
				roundRect(width, depth, height, rounding);
				translate([0,0,bottom]) {
					roundRect(iwidth, idepth, height, rounding-side);
				}
			}
		}

		// hinge cutout
		translate([0,0,height - hingeCutZ/2 + eps/2]) {
			cube(size=[hingeCutWidth, depth+eps, hingeCutZ + eps], center=true);
		}

		// fillet edges
		for (y=[-1,1]) {
			translate([0,y*(depth/2 - fillet/2),height - fillet/2]) {
				difference() {
					cube(size=[width+eps, fillet+eps, fillet+eps], center=true);
					translate([0,y*-fillet/2,-fillet/2])
					rotate([0,90,0]) {
						cylinder(r=fillet, h=width + eps*2, center=true); 
					}
				}
			}
		}
		// magnet cutouts
		for (x=[-1,1])
		for (y=[-1,1]) {
			translate([x * (hingeCutWidth/2 + mheight/2 - eps/2), y*(depth/2 - minimum - mdiameter/2), height - minimum - mdiameter/2])
			rotate([0,90,0])
			cylinder(r=mdiameter/2, h=mheight+eps, center=true, $fn=30);
		}
	}
}


module makeLid(width, depth, rounding, minimum, side, bottom, mdiameter, mheight, gap) {
	eps = 0.1;
	hingeWidth = width - rounding*2 - mheight*2 - gap*2;
	hingeSize = mdiameter + minimum*2;
	
	difference() {
		union() {
			translate([0,0,bottom/2]) {
				roundRect(width, depth, bottom, rounding);
			}	

			// hinges
			for (s=[-1,1]) {
				translate([0,s*(depth/2 - hingeSize/2),bottom + hingeSize/2]) {
					hull() {
						rotate([0,90,0]) {
							cylinder(r=hingeSize/2, h=hingeWidth,center=true);
						}
						translate([0,s*-hingeSize/4,0]) {
							cube(size=[hingeWidth, hingeSize/2, hingeSize], center=true);
						}
						translate([0,0,-hingeSize/4-eps]) {
							cube(size=[hingeWidth, hingeSize, hingeSize/2], center=true);
						}
					}
				}
			}
		}

		// magnet cutouts
		for (x=[-1,1])
		for (y=[-1,1]) {
			translate([x * (hingeWidth/2 - mheight/2 + eps/2), y*(depth/2 - minimum - mdiameter/2), mdiameter/2 + bottom + minimum])
			rotate([0,90,0])
			cylinder(r=mdiameter/2, h=mheight+eps, center=true, $fn=30);
		}

	}
}

module make($fn=60) {
	// minimal error checking
	eps = 0.1;
	rounding = max(_rounding, _sidewallThickness + eps);
	height = max(_height, _horizontalThickness + _magnetDiameter + _minimumWallThickness*2 + _hingeGap);

	if (_part == "box") {
		makeBase(_width, _length, height, rounding, 
					_minimumWallThickness, _sidewallThickness, _horizontalThickness, 
					_magnetDiameter, _magnetHeight, _hingeGap);
	} else if (_part == "lid") {
		makeLid(_width, _length, rounding, 
					_minimumWallThickness, _sidewallThickness, _horizontalThickness, 
					_magnetDiameter, _magnetHeight, _hingeGap);
		
	}

}

build_plate(0);
make();
