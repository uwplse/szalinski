// created by pretenda
// http://www.thingiverse.com/pretenda/designs
// modified by skytale
// http://www.thingiverse.com/skytale/designs

// If you are reading this, sorry for my spaghetti code.
// skytale :>> also sorry for mine

// Options!
//cube([39.5,92,50]);
/* [T-Boxx Insert] */
// What do you want to render out?
what = "boxx"; // [boxx:Boxx Insert,pegs:Pegs,both:Both Boxx Insert and Pegs]
// Which height?
h = "halfSize"; // [fullSize:fullSize,halfSize:halfSize]
// How many units wide?
modulesH = 2; // [1:8]
// How many units deep?
modulesV = 1; // [1:6]
// How many compartments in width?
numberOfHorizontalDivisions = 3; // [1:10]
// How many compartments in depth?
numberOfVerticalDivisions = 2; // [1:10]

/* [Misc Parameters] */
// Wall Thickness. Too thin and it is a bit flimsy, 1.7 seems about right for me.
wallThickness = 1.7;
// Peg Diameter. This width for me is quite snug, might need to dial it down depending on your printer.
pegDiameter = 7.4;

/* [Hidden] */
pegDistance = 39.5; //92 for two -- so 13 difference
baseCornerDiameter = 5;
topCornerDiameter = 10;
topWidth = 52.5;
topLowerWidth = 51.5;
topInnerDiameter = 48.5;
bottomWidth = 49.5;
height = (h == "fullSize")? 60.7:28.7; 
// fullSize: 63-2.3 for pegs
// halfSize: 31-2.3 for pegs



pegSlackH = (modulesH - 1) * 13;
pegSlackV = (modulesV - 1) * 13;

blPosX = 0;
blPosY = 0;

brPosX = modulesH * pegDistance + pegSlackH;
brPosY = 0;

tlPosX = 0;
tlPosY = modulesV * pegDistance + pegSlackV;

trPosX = modulesH * pegDistance + pegSlackH;
trPosY = modulesV * pegDistance + pegSlackV;

// Pegs?!
/*translate([0,0,-2]) {
cylinder(2, pegDiameter / 2, pegDiameter / 2);
translate([brPosX, 0, 0]) cylinder(2, pegDiameter / 2, pegDiameter / 2);
translate([0, tlPosY, 0]) cylinder(2, pegDiameter / 2, pegDiameter / 2);
translate([trPosX, trPosY, 0]) cylinder(2, pegDiameter / 2, pegDiameter / 2);
}*/

module boxx()
{

difference()
{

union()
{
hull()
{

translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, 0.03]) #cylinder(2, baseCornerDiameter/2,baseCornerDiameter/2, $fn = 20);


translate([brPosX, brPosY, 0]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, 0.03]) #cylinder(2, baseCornerDiameter/2,baseCornerDiameter/2, $fn = 20);

translate([tlPosX, tlPosY, 0]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, 0.03]) #cylinder(2, baseCornerDiameter/2,baseCornerDiameter/2, $fn = 20);

translate([trPosX, trPosY, 0]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, 0.03]) #cylinder(2, baseCornerDiameter/2,baseCornerDiameter/2, $fn = 20);

// Bottom
translate([blPosX, blPosY, height]) translate([-(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([brPosX, brPosY, height]) translate([(topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([tlPosX, tlPosY, height]) translate([-(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, (topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([trPosX, trPosY, height]) translate([(topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, (topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);
}


hull()
{


translate([blPosX, blPosY, height]) translate([-(topWidth - pegDistance) / 2 + topCornerDiameter / 2, -(topWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2 -0.2, topCornerDiameter / 2, $fn = 30);

translate([brPosX, brPosY, height]) translate([(topWidth - pegDistance) / 2 - topCornerDiameter / 2, -(topWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2 -0.2, topCornerDiameter / 2, $fn = 30);

translate([tlPosX, tlPosY, height]) translate([-(topWidth - pegDistance) / 2 + topCornerDiameter / 2, (topWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2 -0.2, topCornerDiameter / 2, $fn = 30);

translate([trPosX, trPosY, height]) translate([(topWidth - pegDistance) / 2 - topCornerDiameter / 2, (topWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(4, topCornerDiameter / 2 -0.2, topCornerDiameter / 2, $fn = 30);

}
}




 // inside carved out
hull()
{
translate([blPosX +wallThickness, blPosY + wallThickness, 1]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([brPosX - wallThickness, brPosY + wallThickness, 1]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([tlPosX + wallThickness, tlPosY - wallThickness, 1]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([trPosX - wallThickness, trPosY - wallThickness, 1]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

// Bottom
translate([blPosX + wallThickness, blPosY + wallThickness, height]) translate([-(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(5, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([brPosX - wallThickness, brPosY + wallThickness, height]) translate([(topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, -4]) cylinder(5, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([tlPosX + wallThickness, tlPosY - wallThickness, height]) translate([-(topLowerWidth - pegDistance) / 2 + topCornerDiameter / 2, (topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(5, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);

translate([trPosX - wallThickness, trPosY- wallThickness, height]) translate([(topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, (topLowerWidth - pegDistance) / 2 - topCornerDiameter / 2, -4]) cylinder(5, topCornerDiameter / 2, topCornerDiameter / 2, $fn = 30);
}


// Holes for pegs to slot into

cylinder(20, 2, 2, $fn = 20);
translate([brPosX, 0, 0]) cylinder(20, 2, 2, $fn = 20);
translate([0, tlPosY, 0]) cylinder(20, 2, 2, $fn = 20);
translate([trPosX, trPosY, 0]) cylinder(20, 2, 2, $fn = 20);

}
}




module peg() {
union()
{
cylinder(2, pegDiameter/2, pegDiameter/2, $fn = 20);
translate([0,0,1]) cylinder(2, 1.8, 1.8, $fn = 20);
}
}


if (what == "boxx" || what == "both")
{
// Boxx!

boxx();
makeDivisions();

}

if (what == "pegs" || what == "both")
{
// Pegs!
translate([-20,0,0]) {
translate([0, 0, 0]) peg();
translate([0, pegDiameter + 2, 0]) peg();
translate([0, (pegDiameter+2)*2, 0]) peg();
translate([0, (pegDiameter+2)*3, 0]) peg();
}

}

// SUBDIVISIONS

rim = 0;
module makeDivisions(){
 if(numberOfVerticalDivisions >= 2){
  for (i = [1 : numberOfVerticalDivisions-1]){
	vDevide(((tlPosY + (bottomWidth - pegDistance) / 2) / numberOfVerticalDivisions) * i);
	//vDevide(0);
	//vDevide(tlPosY + (bottomWidth - pegDistance) / 2);
  }
 }
 if(numberOfHorizontalDivisions >= 2){
  for (i = [1 : numberOfHorizontalDivisions-1]){
  	hDevide(((brPosX + (bottomWidth - pegDistance) / 2) / numberOfHorizontalDivisions) * i);
	//hDevide(0);
	//hDevide(brPosX + (bottomWidth - pegDistance) / 2);
  }
 }
}

module vDevide(pos){
translate([0,pos,0])
hull()
{
translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) 
	rotate([90,0,0]) translate([0,0,-wallThickness/2]) cylinder(wallThickness, baseCornerDiameter / 2, baseCornerDiameter / 2, $fn = 30);
translate([brPosX, 0, 0]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) 
	rotate([90,0,0]) translate([0,0,-wallThickness/2]) cylinder(wallThickness, baseCornerDiameter / 2, baseCornerDiameter / 2, $fn = 30);
translate([blPosX, 0, height]) translate([-(topLowerWidth - pegDistance) / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -rim])
	translate([wallThickness/2, 0, -wallThickness/2]) cube(size = [wallThickness, wallThickness, wallThickness], center = true);
translate([brPosX, 0, height]) translate([(topLowerWidth - pegDistance) / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -rim])
	translate([-wallThickness/2, 0, -wallThickness/2]) cube(size = [wallThickness, wallThickness, wallThickness], center = true);
}
}

module hDevide(pos){
translate([pos,0,0])
hull()
{
translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) 
	rotate([0,-90,0]) translate([0,0,-wallThickness/2]) cylinder(wallThickness, baseCornerDiameter / 2, baseCornerDiameter / 2, $fn = 30);
translate([0, tlPosY, 0]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, baseCornerDiameter / 2])
	rotate([0,-90,0]) translate([0,0,-wallThickness/2]) cylinder(wallThickness, baseCornerDiameter / 2, baseCornerDiameter / 2, $fn = 30);
translate([0, tlPosY, height]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, (topLowerWidth - pegDistance) / 2, -rim])
	translate([0, -wallThickness/2, -wallThickness/2]) cube(size = [wallThickness, wallThickness, wallThickness], center = true);
translate([0, blPosY, height]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(topLowerWidth - pegDistance) / 2, -rim])
	translate([0, wallThickness/2, -wallThickness/2]) cube(size = [wallThickness, wallThickness, wallThickness], center = true);
}
}