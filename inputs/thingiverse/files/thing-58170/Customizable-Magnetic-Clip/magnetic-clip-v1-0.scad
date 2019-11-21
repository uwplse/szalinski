use <utils/build_plate.scad>

// length of the clip opening
_length = 12;

// width of the clip opening
_width = 12;

// rounding of the inside of the clip
_rounding = 3.0;

// thickness of the walls around the magnets
_wallThickness = 1.0;

// diameter of the cylindrical magnets
_magnetDiameter = 3.18;

// height of the cylindrical magnets
_magnetHeight = 3.0;

// rib inside the magnet insets to help hold the magnets in place
_crushRibDiameter = 0.6;

// gap between the parts of the hinge
_partGap = 0.15;



module roundRect(width, depth, height, round) {
	manifold_hack = 0.0000001; // avoid manifold issues when cylinders are tangent
	round = min(round, width/2) + manifold_hack;
	hull() {
		for (w=[-1,1])
		for (d=[-1,1])
		translate([w * (width/2 - round),d * (depth/2 - round),0]) {
			cylinder(r=round, h=height, center=true);
		}
	}
}

module makeClip(length, width, wall, rounding, mdiameter, mheight, partGap, ribDiameter) {
	thickness = mdiameter + wall*2;
	eps = 0.1;

	width = max(width, thickness+eps);
	rounding = min(rounding, (width - thickness)/2);
	olength	= length + 2*thickness;
	owidth = width + 2*thickness;
	oheight = mheight*3 + partGap*2;
	orounding = rounding + thickness;
	
	translate([0,0,oheight/2])
	difference() {
		union() {
			difference() {
				union() {
					// body
					difference() {
						roundRect(olength, owidth, oheight, orounding); 
						roundRect(length, width, oheight+eps, rounding);
						
						translate([0,-(owidth+eps)/2,0]) {
							cube(size=[olength+eps, owidth+eps, oheight+eps], center=true);
						}
					}
		
					// hinge
					for(s=[-1,1])
					translate([s*(length/2+thickness/2), 0, 0]) {
						cylinder(r=thickness/2, h=oheight, center=true);
					}
				}

				// magnet cutouts
				for(s=[-1,1])
				translate([s*(length/2+thickness/2), 0, 0]) {
					cylinder(r=mdiameter/2, h=oheight+eps, center=true);
				}
			}
			// ribs
			for(s=[-1,1])
			translate([s*(length/2+thickness/2), mdiameter/2, 0]) {
				cylinder(r=ribDiameter/2, h=oheight, center=true);
			}
		}
	
		// cuts
		translate([length/2+thickness/2, 0, 0]) {
			cube(size=[thickness+eps, thickness+eps, mheight + partGap*2], center=true);
		}
	
		for(s=[-1,1])
		translate([-(length/2+thickness/2), 0, s*(mheight+partGap)]) {
			cube(size=[thickness+eps, thickness+eps, mheight + partGap*2], center=true);
		}
		
	}
}

build_plate(0);
makeClip(_length, _width, _wallThickness, _rounding, _magnetDiameter, _magnetHeight, _partGap, _crushRibDiameter, $fn=90);