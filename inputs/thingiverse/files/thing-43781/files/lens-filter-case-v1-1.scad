
// diameter of the opening (should be slightly larger than the measured filter diameter)
_1_filterDiameter = 52.3;

// height of the opening (should be slightly larger than the filter thickness)
_2_filterHeight = 5.2;

// thickness of the sides of the case
_3_sidewallThickness = 1.0;

// thickness along the edge of the case
_4_edgeThickness = 1.6;

// diameter of the hinge magnet
_5_magnetDiameter = 3.95;

// height of the hinge magnet
_6_magnetHeight = 2.2;

// padding around the magnet
_7_magnetWall = 1.4;


////////////////////////////////////////////////////////////////


module hinge(y, radius, height) {
	translate([0,y,0]) {
		cylinder(h = height, r = radius);
	}
}

module outsideShell(radius, outsideHeight, hingeY, hingeRadius) {
	hull () {
		cylinder(h = outsideHeight, r = radius);
		hinge(hingeY, hingeRadius, outsideHeight);
		hinge(-hingeY, hingeRadius, outsideHeight);
	}
}

module filter(radius, height) {
	cylinder(h = height, r = radius);	
}

module rightCut(radius, height) {
	translate([0,-radius*2,0]) {
		cube([radius * 2, radius * 4, height+1]);
	}
}

module chamfer(direction, hingeY, hingeRadius, diameter, mDiameter, height) {
	sq2 = sqrt(2);
	polyhedron(
  		points=[ 	[0,hingeY-hingeRadius*4 * direction,0],
					[0,0,height],
					[-diameter/(2*sq2),diameter/(2*sq2) * direction,height],
					[0,hingeY+mDiameter/2 * direction,height] ],
		triangles=[ [3,1,2],[3,0,1],[1,0,2],[0,3,2] ]
	);
}

module filterTray(diameter, height, side, edge, mDiameter, mHeight, mWall, $fn = 180) {
	radius = diameter/2 + edge;
	hingeY = diameter/2 + mDiameter/2 + mWall;
	hingeRadius = mDiameter/2 + mWall;
	outsideHeight = height + side;
	difference () {
		union() {
			difference () {
				translate([0,0,-side]) {
					outsideShell(radius, outsideHeight, hingeY, hingeRadius);
				}
				
				// cuts
				filter(diameter/2, height+1);
				rightCut(radius, height);
			}
			hinge(hingeY, hingeRadius, height);
			hinge(-hingeY, hingeRadius, height);
		}
		translate([0,0,height/2]) {
			hinge(hingeY, hingeRadius + 0.2, height);
			hinge(-hingeY, hingeRadius + 0.2, height);
		}
		translate([0,0,height/2 - mHeight]) {
			hinge(hingeY, mDiameter/2, mHeight+1);
			hinge(-hingeY, mDiameter/2, mHeight+1);
		}
		chamfer(1, hingeY, hingeRadius, diameter, mDiameter, height);
		chamfer(-1, -hingeY, hingeRadius, diameter, mDiameter, height);
	}
}

filterTray(_1_filterDiameter, _2_filterHeight, _3_sidewallThickness, _4_edgeThickness, _5_magnetDiameter, _6_magnetHeight, _7_magnetWall);
