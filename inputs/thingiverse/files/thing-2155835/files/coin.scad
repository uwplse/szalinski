// Created by Grant Emsley <grant@emsley.ca>

/* [Shape] */
// total diameter of the coin
outerDiameter = 20; // [1:50]
// diameter at the top of the bevel
innerDiameter = 18; // [1:50]
// bevel only top or both sides?
bevelBothSides = "yes"; // [yes,no]
// adjust to line up text the way you want
shapeRotation = 90; // [0:360]
// number of points the coin shape has
points = 5; // [3:20]
// total height of the coin
totalHeight = 1; // [0.5:0.1:20]

/* [Text] */

// Text to cut out of the coin
coinValue = "1";
textSize = 9;
textFont = "Open Sans";


module taperedShape() {
	if(bevelBothSides == "yes") {
		rotate(shapeRotation) translate([0,0,totalHeight/2]) cylinder(h = totalHeight/2, d1 = outerDiameter, d2 = innerDiameter, $fn = points);
		rotate(shapeRotation) cylinder(h = totalHeight/2, d1 = innerDiameter, d2 = outerDiameter, $fn = points);
	} else {
		cylinder(h = totalHeight, d1 = outerDiameter, d2 = innerDiameter, $fn = points);
	}
}

module createText() {
	translate([0,0,-1]) linear_extrude(height = totalHeight + 2) text(str(coinValue), size=textSize, halign="center", valign="center", font=textFont);
}


difference() {
	taperedShape();
	createText();
}

