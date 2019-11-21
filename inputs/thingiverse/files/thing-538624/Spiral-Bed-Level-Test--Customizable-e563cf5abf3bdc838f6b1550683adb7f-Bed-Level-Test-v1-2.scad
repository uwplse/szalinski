// spiral shape (rectangular or circular)
_bed_type = 4; // [4:rectangular, 120:circular]

// width of the bed along the x-axis
_bed_x = 200;

// width of the bed along the y-axis
_bed_y = 200;

// thickness of each printed line of the spiral
_line_width = 0.8;

// height of the spiral
_line_height = 0.1;

// distance between each loop of the spiral
_spiral_gap = 1;

// number of loops in the spiral
_loops = 5;


module make() {
//	#cube([_bed_x, _bed_y, 0.1], center=true);

	if (_bed_type == 4) {
		sqiral(_loops, _bed_x/2, _bed_y/2, _line_width, _line_height, _spiral_gap, _bed_type);
	} else {
		spiral(_loops, min(_bed_x, _bed_y)/2, _line_width, _line_height, _spiral_gap, _bed_type);
	}
}


module sqiral(revolutions, rx, ry, thickness, height, gap, resolution) {
	minr = min(rx, ry);
	revolutions = min(revolutions, floor((minr-gap)/(thickness+gap)));
	rx = rx - thickness;
	pitch = thickness + gap;

	union() {
		for (step = [0:1:revolutions * resolution - 1]) {
			assign(s = step * pitch/4) {
				if (step%2 == 0) {
					translate([(step%4) ? -pitch/4 : pitch/4, (step%4) ? ry - s : -ry + s, 0])
					cube([rx*2 - s*2 + thickness, thickness, height], center=true);
				} else {
					translate([(step%4-1) ? rx - s: -rx + s, (step%4-1) ? pitch/4 : -pitch/4, 0])
					cube([thickness, ry*2 - s*2 + thickness, height], center=true);
				}
			}
		}
	}
}

function spiralRadius(radius, angle, pitch) = radius - pitch * (angle/360);
function angleStep(step) = step * (360/_bed_type);

module spiral(revolutions, radius, thickness, height, gap, resolution) {
	revolutions = min(revolutions, floor((radius-gap)/(thickness+gap)));
	pitch = thickness + gap;
	eps = 0.01;

	union() {
		for (step = [0:1:revolutions * resolution-1]) {
			assign(startAngle = angleStep(step),
					endAngle = angleStep(step+1)) {
				assign(	r0 = spiralRadius(radius, startAngle, pitch),
						r1 = spiralRadius(radius, endAngle, pitch),
						r2 = spiralRadius(radius-thickness, endAngle, pitch),
						r3 = spiralRadius(radius-thickness, startAngle, pitch) ) {
					linear_extrude(height = height, slices = 1) {
						polygon(	points=[	[r0*sin(startAngle), r0*cos(startAngle)],
										[r1*sin(endAngle), r1*cos(endAngle)],
										[r2*sin(endAngle+eps), r2*cos(endAngle+eps)],
										[r3*sin(startAngle-eps), r3*cos(startAngle-eps)]],
								paths=[[0,1,2,3]]);
					}
				}			
			}
		}
	}
}


make();
