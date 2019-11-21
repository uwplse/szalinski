
/*[Size]*/
_outside_width = 80; // x axis
_outside_length = 80;  // y axis
_box_height = 80; // z axis
_corregation_thickness = 6;

/*[Detail]*/
_corner_style = 0; // [0:Round,1:Corner]

//thickness of the walls used in the corregation
_stroke_thickness = 1;

// frequency of corregations (use 0.866 for equilateral triangles)
_corregation_density = 0.866; //sin(60) for approximate equilateral triangles 

// smallest gap between each corregation triangle
_gaps = 0.3;

/*[Caps]*/
// thickness of the edges covering the corregations (use 0 for none)
_edge_cap_height = 0.0;

// thickness of the bottom of the box (use 0 for no bottom)
_bottom_height = 0.0;

// ignore
eps = 0.1 * 1;
$fn = 128 * 1;

module rrect(h, w, l, r) {
	r = min(r, min(w/2, l/2));
	w = max(w, eps);
	l = max(l, eps);
	h = max(h, eps);
	if (r <= 0) {
		translate([-w/2, -l/2,0]) {
			cube([w,l,h]);
		}
	} else {
		hull() {
			for (y = [-l/2 + r, l/2 - r]) {
				for (x = [-w/2 + r, w/2 - r]) {
					translate([x, y, 0]) {
						cylinder(h=h, r=r, center=false);
					}
				}
			}
		}
	}
}

module flexBox() {
	module zee(thickness, length, height, stroke, gap) {
//		#translate([length/4,0,0]) cube([length/2, thickness, 1], center=true);
		radius = stroke/2;
		maxx = length/2 - radius - gap/2;
		minx = gap/2 + stroke/2;
		angle = atan2(thickness - stroke, maxx - minx);
		union() {
			// top
			translate([0, thickness/2 - stroke, 0]) {
				cube([maxx, stroke, height]);
			}
			translate([maxx, thickness/2 - stroke/2, 0]) {
				cylinder(h=height, r=stroke/2, $fn = 32);
			}

			// slant (should be more efficient than using a hull)
			translate([length/4, 0, 0])
			rotate([0, 0, angle])
			translate([0, 0, height/2]) {
				cube([(maxx - minx)/cos(angle), stroke, height], center=true);
			}

			// bottom
			translate([minx, -thickness/2, 0]) {
				cube([maxx, stroke, height]);
			}
			translate([minx, -thickness/2 + stroke/2, 0]) {
				cylinder(h=height, r=stroke/2, $fn = 32);
			}
	
			// connectors (for avoiding degenerate surfaces)
			translate([0, thickness/2 - stroke/2, 0]) {
				cylinder(h=height, r=stroke/2, $fn=4);
			}
			translate([length/2, -thickness/2 + stroke/2, 0]) {
				cylinder(h=height, r=stroke/2, $fn=4);
			}

		}	
	}

	module squiggle(thickness, length, height, stroke, gap) {
		union() {
			zee(thickness, length, height, stroke, gap);
			translate([length/2, 0, 0])
			mirror([0, 1, 0]) {
				zee(thickness, length, height, stroke, gap);
			}
		}
	}

	module squiggleLine(thickness, length, height, stroke, density, gap) {
		numSquiggles = max(1, round(density * length/thickness));
		squiggleLength = length/numSquiggles;
		union()
		for(x=[0:1:numSquiggles-1]) {
			translate([x * squiggleLength,0,0]) {
				squiggle(thickness, squiggleLength, height, stroke, gap);
			}
		}
	}

	module rcorner(thickness, x, y, height, stroke, gap) {
		xflip = (x > 0 ? 1 : -1);
		yflip = (y > 0 ? 1 : -1);
		intersection() {
			translate([x - thickness * xflip, y - thickness * yflip, 0]) {
				difference() {
					cylinder(h=height, r=thickness);
					translate([0, 0, -eps/2]) {
						cylinder(h=height + eps, r=thickness - stroke);
					}
				}
			}
			translate([x - thickness/2 * xflip, y - thickness/2 * yflip, height/2 - eps/2]) {
				cube([thickness, thickness, height + eps], center=true);
			}
		}
	}

	module corner(thickness, x, y, height, stroke, gap) {
		xflip = (x > 0 ? 1 : -1);
		yflip = (y > 0 ? 1 : -1);
		barLength = thickness-stroke/2;
		union() {
			translate([x - (barLength + stroke)/2 * xflip, y - stroke/2 * yflip, height/2]) {
				cube([barLength, stroke, height], center=true);
			}
			translate([x-stroke/2 * xflip,  y - (barLength + stroke)/2 * yflip, height/2]) {
				cube([stroke, barLength, height], center=true);
			}

			hull() {
				translate([x - stroke/2 * xflip, y-stroke/2 * yflip, 0]) {
					cylinder(h=height, r=stroke/2);
				}
		
				translate([x + (-thickness + stroke/2 + gap) * xflip, y + (-thickness + stroke/2 + gap) * yflip, 0]) {
					cylinder(h=height, r=stroke/2);
				}
			}
		}
	}

	insideWidth = _outside_width - _corregation_thickness*2;
	insideLength = _outside_length - _corregation_thickness*2;
	rounding = _corner_style == 0 ? _corregation_thickness : _stroke_thickness/2;
	hack = 0.001; // offset cap edges to prevent degenerate geometry

	echo("inside width", insideWidth);
	echo("inside length", insideLength);


//	translate([0,0,_box_height/2]) {
//		difference() {
//			cube([_outside_width, _outside_length, _box_height], center=true);
//			cube([insideWidth, insideLength, _box_height+eps], center=true);
//		}
//	}


	union() {

		//	walls
		for (a=[0,180]) {
			rotate([0,0,a])
			translate([-insideWidth/2, insideLength/2 + _corregation_thickness/2,0]) {
				squiggleLine(_corregation_thickness, insideWidth, _box_height, _stroke_thickness, _corregation_density, _gaps);
			}
		}
		for (a=[-1,1]) {
			rotate([0,0,90 * a])
			translate([-insideLength/2, (insideWidth/2 + _corregation_thickness/2),0]) {
				squiggleLine(_corregation_thickness, insideLength, _box_height, _stroke_thickness, _corregation_density, _gaps);
			}
		}
	
		// corners
		if (_corner_style == 0) {
			rcorner(_corregation_thickness, _outside_width/2, _outside_length/2, _box_height, _stroke_thickness, _gaps);
			rcorner(_corregation_thickness, _outside_width/2, -_outside_length/2, _box_height, _stroke_thickness, _gaps);
			rcorner(_corregation_thickness, -_outside_width/2, _outside_length/2, _box_height, _stroke_thickness, _gaps);
			rcorner(_corregation_thickness, -_outside_width/2, -_outside_length/2, _box_height, _stroke_thickness, _gaps);	
		} else {
			corner(_corregation_thickness, _outside_width/2, _outside_length/2, _box_height, _stroke_thickness, _gaps);
			corner(_corregation_thickness, _outside_width/2, -_outside_length/2, _box_height, _stroke_thickness, _gaps);
			corner(_corregation_thickness, -_outside_width/2, _outside_length/2, _box_height, _stroke_thickness, _gaps);
			corner(_corregation_thickness, -_outside_width/2, -_outside_length/2, _box_height, _stroke_thickness, _gaps);	
		}

		// note: add these as non-overlapping objects, otherwise degenerate geometry is created

		// edge caps
		if (_edge_cap_height > 0) {
			difference() {
				union() {
					rrect(_edge_cap_height, _outside_width - hack, _outside_length - hack, rounding);
					translate([0, 0, _box_height-_edge_cap_height]) {
						rrect(_edge_cap_height, _outside_width - hack, _outside_length - hack, rounding);
					}
				}
				translate([0, 0, _box_height/2]) {
					cube([insideWidth + hack, insideLength + hack, _box_height+eps], center=true);
				}
			}
		}
	

		// base
		if (_bottom_height > 0) {
			rrect(_bottom_height, _outside_width - hack, _outside_length - hack, rounding);
		}
	}

}


flexBox();