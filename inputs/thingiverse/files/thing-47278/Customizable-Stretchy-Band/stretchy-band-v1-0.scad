// stretchy bands

// (not including the curved parts)
_1_insideDiameter = 24; //[1:300]

// (not including the curved parts)
_2_outsideDiameter = 48; //[1:300]

_3_height = 6; //[1:100]

// number of loops around the ring
_4_radialCount = 6; //[2:180]

// wall thickness
_5_thickness = 0.8;

// (of the arcs)
_6_resolution = 60; //[30:Low, 60:Medium, 120:High]


// only works from [0 to 180] degrees, runs clockwise from 12 o'clock
module smallArc(radius0, radius1, angle, depth) {
	thickness = radius1 - radius0;
	eps = 0.1;

	union() {
		difference() {
			// full arc
			cylinder(r=radius1, h=depth, center=true);
			cylinder(r=radius0, h=depth+2*eps, center=true);

			for(z=[0, 180 - angle]) {
				rotate([0,0,z])
				translate([-radius1,0,0])			
				cube(size = [radius1*2, radius1*2, depth+eps], center=true);
			}
		}
	}
}


module largeArc(radius0, radius1, angle, depth) {
	eps = 1;
	thickness = radius1 - radius0;
	cutAngle = 360-angle;
	centerRadius = (radius0 + radius1)/2.0;
	if (angle > 180) {
		union() {
			smallArc(radius0, radius1, 180, depth);
			rotate([0,0,-180 + eps]) {
				smallArc(radius0, radius1, angle-180 + eps, depth);
			}
		}
	} else {
		smallArc(radius0, radius1, angle, depth);
	}
}


module stretchyBand(r1, r2, count, height, thickness) {

	angle = 180/count;
	eps = 0.1;
	overlap = 2;

	cord2 = 2 * r2 * sin(angle/2);
	outsideArc = 180 + angle + overlap;
	outsideRadius = cord2/sin(90-angle/2)/2;
	outsideOffset = r2 * cos(angle/2) + cos(90-angle/2) * outsideRadius;

	insideArc = 180 - angle + overlap;
	cord1 = 2 * r1 * sin(angle/2);
	insideRadius = cord1/sin(90-angle/2)/2;
	insideOffset = r1 * cos(angle/2) + cos(90-angle/2) * insideRadius;

	union()
	translate([0,0,height/2])
	for(a = [0:angle*2:360]) {
		rotate([0,0,a]) {
			// straight sections
			for(b=[0,angle]) {
				rotate([0,0,angle/2 - b])
				translate([0,r1 + (r2-r1)/2,0]) {
					cube(size = [thickness, r2 - r1 + eps, height], center=true);
				}
			}

			// outer radius
			translate([0,outsideOffset,0])
			rotate([0,0,outsideArc/2]) {
				largeArc(outsideRadius-thickness/2,outsideRadius+thickness/2, outsideArc, height);
			}
		
			// inner radius
			rotate([0,0,angle])
			translate([0,insideOffset,0])
			rotate([0,0,180 + insideArc/2]) {
				largeArc(insideRadius-thickness/2,insideRadius+thickness/2, insideArc, height);
			}
		}
	}
}

stretchyBand(	_1_insideDiameter > _2_outsideDiameter ? _2_outsideDiameter/2 : _1_insideDiameter/2, 
					_2_outsideDiameter/2, 
					_4_radialCount, 
					_3_height, 
					_5_thickness, 
					$fn=_6_resolution
);
