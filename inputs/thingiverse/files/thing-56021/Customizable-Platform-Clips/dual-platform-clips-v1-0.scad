

_style = "square"; // [round, square]

// height of the platform (use a slightly smaller value, about 0.2mm to make the clip tight)
_platformGap = 6.8;


// length of the clip
_length = 16.0; //[4:50]


// thickness of the clip.
_wallThickness = 1.0;


// size of the top of the clip
_diameter = 2.2;

////////////////////////////////////////////////////////////////////////

// only works from [0 to 180] degrees, runs clockwise from 12 o'clock
module smallArc(radius0, radius1, angle, depth) {
	thickness = radius1 - radius0;
	eps = 0.01;

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

module clip(arcRadius, angle, height, outerThickness, hingeRadius, hingeAngle, clipAngle, hingeGap) {
	ir = arcRadius;
	or = ir + outerThickness;
	clipRadius = hingeRadius;
	hx = (ir-hingeRadius)*sin(angle/2);
	hy = (ir-hingeRadius)*cos(angle/2);
	cx = (ir-clipRadius)*sin(angle/2);
	cy = (ir-clipRadius)*cos(angle/2);

	union() {

		difference() {
			//	spine
			rotate([0,0,angle/2]) {
				roundArc(ir, or, angle, height);
			}
		}

		// hinge
		translate([-hx, hy, 0])
		rotate([0,0,angle/2+hingeAngle]) {
			roundArc(hingeRadius, hingeRadius+outerThickness, hingeAngle, height);
		}

		// clip
		translate([cx, cy, 0])
		rotate([0,0,-angle/2]) {
			roundArc(clipRadius, clipRadius+outerThickness, clipAngle, height);
		}
	}
}

// reuse code from the arc clip
module buildRoundClip(gap, width, wall, diameter) {
	curvature = 25;
	clipAngle = 120;
	hingeAngle = 280 - wall*10;
	length = gap + diameter/3 + wall; // approximate
	radius = length / (2 *(curvature/100));
	angle = 2 * asin(length/(2*radius));

	translate([0,-radius,width/2]) {
		clip(radius, angle, width, wall, diameter/2, hingeAngle, clipAngle);
	}
}
////////////////////////////////////////////////////////////////////////

module buildSquareClip(gap, width, wall, diameter) {
	radius = diameter/2;
	tipRadius = diameter * 0.3;
	clipDepth = 1.0; // depth of the clip prongs
	space = 0.6; // space between clip and spine
	eps = 0.1;
	for (y = [-1,1]) {
		hull() {
			translate([0,y*(gap/2 + radius),0]) {
				cylinder(r=radius, h=width);
			}
			translate([-diameter*clipDepth,y*(gap/2 + tipRadius),0]) {
				cylinder(r=tipRadius, h=width);
			}
		}
		
		translate([(radius+space)/2, y*(gap/2 + diameter - wall/2), width/2]) {
			cube(size=[radius + space + eps, wall, width], center=true);
		}
	}
	translate([radius + space + wall/2, 0, width/2]) {
		cube(size=[wall, gap + diameter*2, width], center=true);
	}
}

module make($fn = 120) {
	if (_style == "round") {
		buildRoundClip(_platformGap, _length, _wallThickness, _diameter);
	} else {
		buildSquareClip(_platformGap, _length, _wallThickness, _diameter);
	}
}

make();