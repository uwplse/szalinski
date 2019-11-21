/* [Global] */
// Angle of the inker hole (degrees above horizontal)
inker_angle = 25; // [20:45]

// Number of rows of holes
row_count = 3; //[2,3,4,5,6,7,8,9]

// Number of columns of holes
column_count = 4; //[1,2,3,4,5,6,7,8,9]


/* [Hidden] */
//length of edge/diameter if square/round holes (mm)
holeSize=18;
//depth of hole (mm)
holeDepth=15;
//number of rows along the x axis
rows=row_count-1;
columns=column_count;
//space between holes (mm)
spacing=7;
//thickness of bottom layer (mm)
baseThickness=5;
inkerBaseThickness=1.5;

inkerAngle = inker_angle;

//set resolution
$fa=1;
$fs=1;

print_part();

module print_part() {

	difference() {
		//main body
		cube(size=[
			(rows + 1)*(holeSize+spacing)+spacing, 
			columns*(holeSize+spacing)+spacing, 
			baseThickness+holeDepth
		], center=false);
		//holes
		holders(holeSize,holeDepth,rows,columns,spacing,baseThickness);
		inker(holeSize, holeDepth,inkerAngle, rows, columns,spacing, inkerBaseThickness, baseThickness);
	}
}

/*
 * Generates all the columns that hold the vials normalls
 */

module holders(holeSize,holeDepth,rows,columns,spacing,baseThickness) {

	radius = holeSize / 2;
	sectionSize = holeSize + spacing;

	translate([
		radius+spacing, 
		radius+spacing, 
		holeDepth/2+baseThickness+0.5
	]) {
		//make the main holes
		for (i=[0:columns-1]) {
			//rows are X axis
			for (j=[0:rows-1]) {
				translate([j*sectionSize, i*sectionSize, 0]) {
					cylinder(r=radius, h=holeDepth+1, center=true);
				}
			}
		}
		// make the bottom row, leaving space for the inker
		if(columns > 3) {
			for (i=[0:columns-4]) {
				translate([rows*sectionSize, i*sectionSize, 0]) {
					cylinder(r=radius, h=holeDepth+1, center=true);
				}
			}
		}
	}
}

/*
 * Generates the angled hole for inking your pen
 */

module inker(holeSize, holeDepth,inkerAngle, row, column,spacing, inkerBaseThickness, baseThickness) {
	inkerDepth = holeDepth + baseThickness - inkerBaseThickness;
	diagColumnHeight = inkerDepth / cos(90-inkerAngle);

	halfDepth = inkerDepth / 2;
	radius = holeSize / 2;
	barrelDiag = sqrt((halfDepth * halfDepth) + (radius * radius));
	barrelTheta = atan(halfDepth / radius);
	yOffset = halfDepth + (barrelDiag*sin(360-(90-barrelTheta)));

	rowOffset = (row)*(holeSize+ spacing) + (holeSize/2+spacing);
	verticalOffset = inkerDepth/2+inkerBaseThickness+0.5 + (halfDepth) +yOffset;
	columnOffset = (column - 1)*(holeSize+spacing) - (holeSize / 2) ;

	translate([rowOffset, columnOffset, verticalOffset]) {
		rotate([-(90 - inkerAngle),0,0]) {
			cylinder(r=holeSize/2, h=diagColumnHeight, center=true);
		}
	}
}


