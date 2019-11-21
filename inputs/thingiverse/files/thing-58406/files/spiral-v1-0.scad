use <utils/build_plate.scad>

// number of revolutions around the circle
_revolutions = 2.0;

// outside diameter of the spiral
_diameter = 30; //[5:300]

// thickness of each ring of the spiral
_thickness = 2.0;

// height of the spiral
_height = 3;

// gap between rings of the spiral
_gap = 0.3;

// number of sections around the circle
_resolution = 60; // [3:180]


function radiusAt(radius, angle, pitch) = radius - pitch * (angle/360);

module spiral(revolutions, diameter, thickness, height, gap, resolution) {
	eps = 0.2;
	radius = diameter/2;
	revolutions = min(revolutions, radius/(thickness+gap)-eps);
	pitch = thickness + gap;
	angleStep = 360/round(resolution);

	union()
	for (angle = [0:angleStep:360*revolutions-angleStep]) {
		assign(	r0 = radiusAt(radius, angle, pitch),
					r1 = radiusAt(radius, angle+angleStep, pitch),
					r2 = radiusAt(radius-thickness, angle+angleStep, pitch),
					r3 = radiusAt(radius-thickness, angle, pitch)
					) {
			linear_extrude(height = height, slices=1) {
					polygon(	points=[	[r0*sin(angle),r0*cos(angle)],
											[r1*sin(angle+angleStep),r1*cos(angle+angleStep)],
											[r2*sin(angle+angleStep+eps),r2*cos(angle+angleStep+eps)],
											[r3*sin(angle-eps),r3*cos(angle-eps)] ],
								paths=[[0,1,2,3]]);
			}			
		}
	
	}

}


build_plate(0);
spiral(_revolutions, _diameter, _thickness, _height, _gap, _resolution);