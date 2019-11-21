// Parametric bezel
// by Andy Gock

// actual panel cutout is minumum: width + 2 * (clearance + bezel_thickness)

// width of device (not including clearance)
width = 27.1;

// height of device (not including clearance)
height = 44.7;

// clearance for the opening per each edge
clearance = 0.1;

// wall thickness, both vertical and horizontal
bezel_thickness = 1.2;

// width of bezel as viewed from outside
bezel_width = 7.0;

// depth of opening
depth = 5.0;

// the retainer fits on the inside of the panel

// increase = less spring tension, more strength
retainer_thickness = 1.2;

// increase = less spring tension
retainer_radius = 3.0;

retainer_height = 4.0;

// set inside of retainer a little smaller than outside of bezel inner wall

// set >= 0, increase for tighter fit
retainer_negative_clearance =0.15;

// round the corners of bezel, set to true or false
round_corners = false; // [true:use round bezel corners,false:use square bezel corners]

// 0 = create both bezel and retainer
// 1 = create bezel only
// 2 = create retainer only
action = 0; // [0:create both bezel and retainer,1:create bezel only,2:create retainer only]

// calculated vars

module _bezel_opening() {
	square([width + 2 * clearance, height + 2 * clearance]);
}

module bezel() {

	// outer section of bezel
	linear_extrude(height = bezel_thickness) {
		difference() {
			if (round_corners)
				offset(r = bezel_width, chamfer=false)
					_bezel_opening();
			else
				offset(delta = bezel_width, chamfer=false)
					_bezel_opening();
			_bezel_opening();
		}
	}

	// inner wall section of bezel
	linear_extrude(height = depth + bezel_thickness) {
		difference() {
			offset(delta = bezel_thickness, chamfer=false)
				_bezel_opening();
			_bezel_opening();
		}
	}

}

module bezel_retainer_shape() {
	// size of inside opening of the retainer
	_x = width + 2 * (clearance + bezel_thickness) - retainer_negative_clearance;
	_y = height + 2 * (clearance + bezel_thickness)- retainer_negative_clearance;

	translate([-bezel_thickness, -bezel_thickness, 0]) {
		translate([0,0,0]) circle(retainer_radius);
		translate([_x,0,0]) circle(retainer_radius);
		translate([0,_y,0]) circle(retainer_radius);
		translate([_x,_y,0]) circle(retainer_radius);
		square([_x, _y]);
	}
}

module bezel_retainer() {

	linear_extrude(height = retainer_height) {
		difference() {
			offset(delta = retainer_thickness, chamfer = false)
				bezel_retainer_shape();
			bezel_retainer_shape();
		}
	}
}

if (action == 0 || action == 1) {
	bezel();
}

if (action == 0) {
	// put retainer next to bezel()
	translate([5 + width + bezel_thickness + bezel_width + retainer_radius + retainer_thickness, 0, 0]) {
		bezel_retainer();
	}
}

// don't translate if creating retainer only
if (action == 2) {
	bezel_retainer();
}