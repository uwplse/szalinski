//=== Flat Tri Glide ===//

//width of the webbing opening (1in = 25.4 mm)
_1_webbingWidth = 26;

// width of the gap for the webbing
_2_webbingGap = 4;

// thickness of the edge
_3_edgeThickness = 2.4;

// thickness of the center beam
_4_centerThickness = 4;

// height of the tri glide
_5_height = 2.4;

// percent corner rounding
_6_cornerRounding = 75; // [1:100]


module makeBody(xsize, ysize, height, radius) {
	translate([0,0,height/2]) {
		minkowski() {
			cube(size=[xsize-2*radius,ysize-2*radius, height/2], center = true);
			cylinder(r=radius, h=height/2, center=true);
		}
	}
}

module makeCuts(width, gap, thickness, height) {
	offset = (thickness+gap)/2;
	for (y = [-offset, offset]) {
		translate([0, y, height/2]) {
			cube(size=[width, gap, height*2], center=true);
		}
	}
}

module makeTriGlide(width, gap, edgeThickness, centerThickness, height, rounding, $fn=90) {
	xsize = width + edgeThickness * 2;
	ysize = centerThickness + edgeThickness * 2 + gap * 2;
	radius = edgeThickness*(rounding/100);
	difference() {
		makeBody(xsize, ysize, height, radius);
		makeCuts(width, gap, centerThickness, height);
	}
}

makeTriGlide(_1_webbingWidth, _2_webbingGap, _3_edgeThickness, _4_centerThickness, _5_height, _6_cornerRounding);