// width across the front (z height as printed)
width = 60;
// width of the end
endSize = 85;
// thickness of your phone + case
shelfDepth = 13;
// height of the lip to hold the phone in place
shelfLip = 4;
// thickness of walls
thickness = 2;
// roundness
outerRadius = 12;

module roundedEquilateralTriangularPrism(endSize, width, r) {
	endHeight = endSize / 1.414;
	w = width - 1;
	minkowski() {
		polyhedron(
		   points=[[0,0,0], [w,0,0], [w,endSize,0], [0,endSize,0], [0,endSize / 2,endHeight], [w,endSize / 2,endHeight]],
		   faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]] );
		rotate([0, 90, 0])
			cylinder(r=r, h=1);
	}
}

module roundedShelf(stickout, lip) {
	minkowski() {
		union() {
			translate([0, stickout, thickness])
				cube([width - 1, thickness, lip]);
			cube([width - 1, stickout + thickness, thickness]);
		}
		rotate([0, 90, 0])
			cylinder(r=thickness / 2, h=1, $fn=8);
	}
}

// phone stand
rotate([0, -90, 0]) // rotate to print
union() {
	innerOffset = thickness * 2;
	difference() {
		roundedEquilateralTriangularPrism(endSize - outerRadius * 2, width, outerRadius);
		translate([-1, innerOffset, thickness])
			roundedEquilateralTriangularPrism(endSize - outerRadius * 2 - thickness * 4, width + 2, outerRadius - thickness);
	}
	translate([0, endSize - outerRadius - thickness * 2, outerRadius / 2])
		rotate([30, 0, 0])
			roundedShelf(shelfDepth + thickness * 1.5, shelfLip);
}

// model of phone with case, in position (comment out the "rotate to print" line to see alignment)
//~ color("DimGray", 1)
	//~ translate([-10, endSize - outerRadius - 4, 10])
		//~ rotate([30, 0, 0])
			//~ cube([80, 13, 150]);


