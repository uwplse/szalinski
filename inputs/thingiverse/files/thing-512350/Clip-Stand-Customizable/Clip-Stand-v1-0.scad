
// Length of the stand
_length = 160.0;

// height of the stand
_height = 24.0;

// Curvature of the stand (lower values for a flatter arc, 100 for a semicircle)
_curvature = 99; //[50:100]

// Thickness of the stand
_thickness = 3;

// Radius at the ends where it clips to the device
_clip_radius = 2.5;

// How far around the device the clips run
_clip_angle = 100; //[60:180]



////////////////////////////////////////////////////////////////////////



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



// arc from [0 to 360] degrees with rounded ends, runs clockwise from 12 o'clock, rounded tips not included in angle computation
module roundArc(radius0, radius1, angle, depth) {
	thickness = radius1 - radius0;
	cutAngle = 360-angle;
	centerRadius = (radius0 + radius1)/2.0;
	union() {
		if (angle > 180) {
			smallArc(radius0, radius1, 180, depth);
			rotate([0,0,-180]) {
				smallArc(radius0, radius1, angle-180, depth);
			}
		} else {
			smallArc(radius0, radius1, angle, depth);
		}

		// round ends
		for(t = [ [0,centerRadius,0], 
					 [centerRadius * -sin(cutAngle), centerRadius * cos(cutAngle),0] ]) {
			translate(t) {
				cylinder(r=thickness/2, h=depth, center=true);
			}
		}
	}
}

module makeStand(arcRadius, angle, height, outerThickness, clipRadius, clipAngle) {
	ir = arcRadius;
	or = ir + outerThickness;
	cx = (ir-clipRadius)*sin(angle/2);
	cy = (ir-clipRadius)*cos(angle/2);

	union() {

		//	spine
		rotate([0,0,angle/2]) {
			smallArc(ir, or, angle, height, $fn=180);
		}

		// clip
		for (m=[1,0]) {
			mirror([m,0,0]) {
				translate([cx, cy, 0])
				rotate([0,0,-angle/2]) {
					roundArc(clipRadius, clipRadius+outerThickness, clipAngle, height, $fn=45);
				}
			}
		}
	}
}

module make() {
	radius = _length / (2 *(_curvature/100));
	angle = 2 * asin(_length/(2*radius));

	translate([0,-radius,_height/2]) {
			makeStand(radius, 
					  angle, 
					  _height, 
					  _thickness, 
					  _clip_radius,
					  _clip_angle);
		}
}

make();