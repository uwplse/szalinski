
// outside diameter of the spiral
_diameter = 60; //[5:300]

// thickness of each ring of the spiral
_thickness = 1.0;

// height of the spiral rings
_height = 0.8;

// gap between the spiral rings
_gap = 0.3;

// diameter of center post
_postDiameter = 4;

// height of center post with tree spirals
_postHeight = 50;

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


module make(diameter, thickness, height, gap, postDiameter, postHeight, resolution) {
	revolutions = (diameter/2)/(thickness+gap);
	postRadius = postDiameter/2;
	// fixed angular resolution is inefficient, resolution of the spiral should be variable, lower angular resolution in the center
	treeHeight = max(postHeight, postDiameter*3 + height*2);
	treeBase = thickness;
	eps = 0.1;
	
	union() {
		spiral(revolutions, diameter, thickness, height, gap, resolution);
		cylinder(r=postRadius, h=treeHeight, $fn=30);
		hull() {
			translate([0,0,treeHeight - treeBase/2]) {
				cylinder(r=postRadius*3, h=treeBase, $fn=30);
			}
			translate([0,0,treeHeight - treeBase - postDiameter*3]) {
				cylinder(r=postRadius, h=eps, $fn=30);
			}
		}
	}
}

make(_diameter, _thickness, _height, _gap, _postDiameter, _postHeight, _resolution);

// todo:
// fix angular resolution issue
// add magenetic attachment option