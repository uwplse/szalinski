// created by pretenda
// http://www.thingiverse.com/pretenda/designs

// If you are reading this, sorry for my spaghetti code.

// Options!

/* [T-Boxx Insert] */
// What do you want to render out?
what = "both"; // [boxx:Boxx Insert,pegs:Pegs,both:Both Boxx Insert and Pegs]
// How many units wide?
modulesH = 1; // [1:8]
// How many units deep?
modulesV = 1; // [1:6]

/* [Misc Parameters] */
// Wall Thickness. Too thin and it is a bit flimsy, 1.7 seems about right for me.
wallThickness = 1.7;
// Peg Diameter. This width for me is quite snug, might need to dial it down depending on your printer.
pegDiameter = 7.4;

/* [Hidden] */
pegDistance = 39.5;
baseCornerDiameter = 5;
topCornerDiameter = 10;
topWidth = 52.5;
topLowerWidth = 51.5;
topInnerDiameter = 48.5;
bottomWidth = 49.5;
height = 60.7;



pegSlackH = (modulesH - 1) * ((topWidth - pegDistance));
pegSlackV = (modulesV - 1) * ((topWidth - pegDistance));

blPosX = 0;
blPosY = 0;

brPosX = modulesH * pegDistance + pegSlackH;
brPosY = 0;

tlPosX = 0;
tlPosY = modulesV * pegDistance + pegSlackH;

trPosX = modulesH * pegDistance + pegSlackH;
trPosY = modulesV * pegDistance + pegSlackH;

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
translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([brPosX, brPosY, 0]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, -(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([tlPosX, tlPosY, 0]) translate([-(bottomWidth - pegDistance) / 2 + baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

translate([trPosX, trPosY, 0]) translate([(bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, (bottomWidth - pegDistance) / 2 - baseCornerDiameter / 2, baseCornerDiameter / 2]) sphere(baseCornerDiameter/2, $fn = 20);

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