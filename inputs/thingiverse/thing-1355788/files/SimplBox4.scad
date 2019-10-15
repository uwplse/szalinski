// created by skytale
// http://www.thingiverse.com/skytale/designs


// Options!
/* [SimplBox Insert] */
//Box measures
type = 6; // [0:Custom,1:Sortimo Small,2:Sortimo Medium,3:Sortimo Large, 4:Allit Euro Plus Small, 5:Allit Euro Plus Large, 6:Alutec]
// How many units in x-direction?
xCount = 3; // [1:6]
// How many units in y-direction?
yCount = 1; // [1:6]
// How many separators in x-direction?
xSeparators = 2;
// How many separators in y-direction?
ySeparators = 0;
// Feet holes?
feetHoles = true; // [true:yes, false:no]

/* [Misc Parameters] */
// Wall Thickness.
wallThickness = 1.2;
innerWallThickness = 0.8;

customWidth = 50;
customDepth = 50;
customHeight = 20;
feetHeight = 2.4;

/* [Hidden] */
cornerRadius = 5;
holeDistance = 6.5;
holeDiameter = 4;
fn = 40;

// DIMENSIONS

// Custom
if (type == 0) doBox(customWidth * xCount, customDepth * yCount, customHeight - feetHeight, holeDistance);

// Sortimo S
if (type == 1) doBox(52 * xCount, 52 * yCount, 31 - feetHeight, holeDistance);

// Sortimo M
if (type == 2) doBox(52 * xCount, 52 * yCount, 44 - feetHeight, holdeDistance);

// Sortimo L
if (type == 3) doBox(52 * xCount, 52 * yCount, 63 - feetHeight, holeDistance);

// Allit S
if (type == 4) doBox(54 * xCount, 54 * yCount, 45 - feetHeight, holeDistance);

// Allit L
if (type == 5) doBox(54 * xCount, 54 * yCount, 63 - feetHeight, holeDistance);

// Alutec (feet distance = 38.5)
if (type == 6) doBox(48 * xCount + (xCount - 1), 48 * yCount + (yCount - 1), 50.3 - feetHeight, (48-33.5-5)/2);  // 1mm*(xyCount -1):-> 1mm space compensation for multilength boxes


module doBox(width, depth, height, holeDistance) {
	difference() {
		box(width, depth, height);
		if (feetHoles) holes(width, depth, holeDistance);
	}
	makeSeparators(width, depth, height);
}

module box(width, depth, height) {
	cWidth = width - 2 * cornerRadius;
	cDepth = depth - 2* cornerRadius;
	difference() {
		hull() {
			translate([-cWidth / 2, -cDepth / 2, 0]) cylinder(height, cornerRadius, cornerRadius, $fn = fn);
			translate([+cWidth / 2, -cDepth / 2, 0]) cylinder(height, cornerRadius, cornerRadius, $fn = fn);
			translate([+cWidth / 2, +cDepth / 2, 0]) cylinder(height, cornerRadius, cornerRadius, $fn = fn);
			translate([-cWidth / 2, +cDepth / 2, 0]) cylinder(height, cornerRadius, cornerRadius, $fn = fn);
		}
		hull() {
			translate([-cWidth / 2, -cDepth / 2, wallThickness]) cylinder(height, cornerRadius - wallThickness, cornerRadius - wallThickness, $fn = fn);
			translate([+cWidth / 2, -cDepth / 2, wallThickness]) cylinder(height, cornerRadius - wallThickness, cornerRadius - wallThickness, $fn = fn);
			translate([+cWidth / 2, +cDepth / 2, wallThickness]) cylinder(height, cornerRadius - wallThickness, cornerRadius - wallThickness, $fn = fn);
			translate([-cWidth / 2, +cDepth / 2 , wallThickness]) cylinder(height, cornerRadius - wallThickness, cornerRadius - wallThickness, $fn = fn);
		}
	}
}

module holes(width, depth, holeDistance) {
	translate([-width / 2 + holeDistance, -depth / 2 + holeDistance, -1]) cylinder(wallThickness + 2, holeDiameter / 2, holeDiameter / 2, $fn = fn);
	translate([+width / 2 - holeDistance, -depth / 2 + holeDistance, -1]) cylinder(wallThickness + 2, holeDiameter / 2, holeDiameter / 2, $fn = fn);
	translate([+width / 2 - holeDistance, +depth / 2 - holeDistance, -1]) cylinder(wallThickness + 2, holeDiameter / 2, holeDiameter / 2, $fn = fn);
	translate([-width / 2 + holeDistance, +depth / 2 - holeDistance, -1]) cylinder(wallThickness + 2, holeDiameter / 2, holeDiameter / 2, $fn = fn);
}


// separators

module makeSeparators(width, depth, height){
 if(xSeparators >= 1){
  for (i = [1 : xSeparators]){
	xSeparator(width, depth, height, ((width - wallThickness) / (xSeparators + 1)) * i);
	//xSeparator(0);
	//xSeparator(width - wallThickness);
  }
 }
 if(ySeparators >= 1){
  for (i = [1 : ySeparators]){
  	ySeparator(width, depth, height, ((depth - wallThickness) / (ySeparators + 1)) * i);
	//ySeparator(0);
	//ySeparator(depth - wallThickness);
  }
 }
}

module xSeparator(width, depth, height, pos){
	translate([(-width + wallThickness) / 2 + pos, 0 ,height / 2]) cube(size = [innerWallThickness, depth - wallThickness, height], center = true);
}

module ySeparator(width, depth, height, pos){
	translate([0, (-depth + wallThickness) / 2 + pos ,height / 2]) cube(size = [width - wallThickness, innerWallThickness, height], center = true);
}
