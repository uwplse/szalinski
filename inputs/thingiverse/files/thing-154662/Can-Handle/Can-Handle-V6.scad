use <write/Write.scad>;
// preview[view:south, tilt:top]

// What to Print on Handle
text = "Your Text Here";
// Make the text wider so it is clearer?
bold = "No"; // [Yes,No]
// Height of Can (125 should work for most of North America)
canh = 125;
// Raised Text?
raise="No"; // [Yes,No]

/* [Hidden] */
// Diameter of Can
cand = 66;

height=canh+3;

// Handle Thickness
thick=15;
$fa=1;

// Grip
intersection () {
	cube([height,50,thick]);
	difference () {
		translate([height/2,-120,0])cylinder(r=150,h=thick);
		translate([height/2,-120,-1]) cylinder(r=150-thick,h=thick+2);
// Grip Text
if (bold=="Yes") {translate([height/2,-120,thick]) writecircle(text,[0,0,0],150-thick/2,t=4,h=8, space=1.1);}
else {translate([height/2,-120,thick]) writecircle(text,[0,0,0],150-thick/2,t=4,h=8, space=1);}
if (bold=="Yes"){translate([height/2,-120,thick]) rotate ([0,0,.2])writecircle(text,[0,0,0],150-thick/2,t=4,h=8, space=1.1);}
}
}
if (raise=="Yes") {
	if (bold=="Yes") {translate([height/2,-120,thick]) writecircle(text,[0,0,0],150-15/2,t=3,h=8, space=1.1);}
	else {translate([height/2,-120,thick]) writecircle(text,[0,0,0],150-15/2,t=3,h=8, space=1);}
	if (bold=="Yes"){translate([height/2,-120,thick]) rotate ([0,0,.2])writecircle(text,[0,0,0],150-15/2,t=3,h=8, space=1.1);}
}

difference() {
translate([0,-5,0]) cube([10,10,thick]);
translate([13,-5,-1]) cylinder(r=10,h=thick+2);
}
difference() {
translate([height-10,-5,0]) cube([10,10,thick]);
translate([height-13,-5,-1]) cylinder(r=10,h=thick+2);
}

// Top clip
translate([0,-31,0])cube([3,45,thick]);
difference() {
	translate([0,-27.5,0])cube([6,3.5,thick]);
	translate([3,-53,thick/2])rotate ([0,90,0]) cylinder(r=27,h=5);
}
intersection() {
	translate([0,-31,0])cube([6,6,thick]);
	translate([0,-53,thick/2])rotate ([0,90,0]) cylinder(r=25,h=10);
}

// Bottom clip
translate([height-3,-37,0])cube ([3,52,thick]);

difference() {
	translate([height-9,-29,0])cube ([9,10,thick]);
	translate([height-11.9,-53,thick/2])rotate ([0,90,0]) cylinder(r2=26,r1=cand/2,h=9);
}

intersection() {
	translate([height-7,-37,0])cube ([7,10,thick]);
	translate([height-9,-53,thick/2])rotate ([0,90,0]) cylinder(r=21,h=10);
}