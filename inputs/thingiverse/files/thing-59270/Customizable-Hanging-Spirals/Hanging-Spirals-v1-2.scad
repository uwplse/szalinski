
// outside diameter of the spiral
_diameter = 30; //[5:300]

// thickness of each ring of the spiral
_thickness = 1.0;

// height of the spiral rings
_height = 0.8;

// gap between the spiral rings
_gap = 0.3;

// diameter of hole in loop
_loopDiameter = 3;

// width hanging loop
_loopWidth = 1;

// number of angle steps around the circle
_resolution = 60; //[3:180]

function radiusAt(radius, angle, pitch) = radius - pitch * (angle/360);

module spiral(revolutions, diameter, thickness, height, gap, resolution) {
	radius = diameter/2;
	revolutions = min(revolutions, radius/(thickness+gap)-1);
	pitch = thickness + gap;
	angleStep = 360/round(resolution);
	eps = 0.2;

	union() {
		for (angle = [0:angleStep:360*revolutions-angleStep]) {
			assign(	r0 = radiusAt(radius, angle, pitch),
						r1 = radiusAt(radius, angle+angleStep, pitch),
						r2 = radiusAt(radius-thickness, angle+angleStep, pitch),
						r3 = radiusAt(radius-thickness, angle, pitch)
						) {
				linear_extrude(height = height, slices = 1) {
					polygon(	points=[	[r0*sin(angle),r0*cos(angle)],
											[r1*sin(angle+angleStep),r1*cos(angle+angleStep)],
											[r2*sin(angle+angleStep+eps),r2*cos(angle+angleStep+eps)],
											[r3*sin(angle-eps),r3*cos(angle-eps)] ],
								paths=[[0,1,2,3]]);
				}			
			}
		}
	}
}


module make(diameter, thickness, height, gap, loopDiameter, loopWidth, resolution) {
	revolutions = (diameter/2)/(thickness+gap);
	loopRadius = loopDiameter/2;
	eps = 0.1;

	union() {
		difference() {
			union() {
				spiral(revolutions, diameter, thickness, height, gap, resolution);
				translate([0,0,height/2]) {
					cylinder(r=loopRadius+thickness, h=height, center=true, $fn=60);
				}
			}
			translate([0,0,height/2]) {
				cylinder(r=loopRadius, h=height+eps, center=true, $fn=60);
			}
		}
		difference() {
			translate([0,0,height]) {
				rotate([90,0,0])
				difference() {
					cylinder(r=loopRadius+thickness, h=loopWidth, center=true, $fn=60);
					cylinder(r=loopRadius, h=loopWidth+eps, center=true, $fn=60);
				}
			}
			translate([0, 0, -loopRadius-thickness]) {
				cube(size=loopDiameter + 2*thickness+eps, center=true);
			}
		}
	}

}

make(_diameter, _thickness, _height, _gap, _loopDiameter, _loopWidth, _resolution);
