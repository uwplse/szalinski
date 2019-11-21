//SLIDE | Smart phone_q Slider by isaac budmen @ibudmen
// preview[view:south west, tilt:top diagonal]

// What kind of Smartphone do you have?
type_of_phone = "first"; // [first:iPhone5,second:HTC One X,third:Samsung Galaxy S3,fourth:Lumia 920,fifth:Nexus 4,sixth:Samsung Galaxy Note 2,seventh:Motorola Droid X,eighth:Motorola Droid RazrHD,nineth:Blackberry Bold 9900,tenth:LG Optimus G,eleventh:iPhone4/4s]

// Add end caps to build plate?
print_endcaps = "Yes"; // [Yes,No]

end_vis();

//ENDS

module end(){
union(){
translate([-21,20,-12])cube([42,5,16]);
difference(){
union(){
translate([-25,20,-12])cylinder(16,7,7);
translate([-32,5,-12])cube([14,16,16]);
}
translate([-25,20,-10])cylinder(18,4.2,4.2);
}
difference(){
union(){translate([25,20,-12])cylinder(16,7,7);
translate([18,5,-12])cube([14,16,16]);}
translate([25,20,-10])cylinder(18,4.2,4.2);
}

}};

module end_vis() {
if (print_endcaps == "Yes") {
translate([0,10,0])end();
translate([0,40,0])end();
}
else if (print_endcaps == "No"){
cube([1,1,1]);
}
};

//MAIN

module main(){
difference(){
hull(){
translate([-21,0,0])cube([42,5,24]);
translate([-4,2,0])cube([8,9,24]);
}
translate([0,10,11])phone_type();
translate([-25,0,-1])cylinder(26,7,7);
translate([25,0,-1])cylinder(26,7,7);
};};

module phone_type(){
	if (type_of_phone == "first") {
		cube([8,14,28], center=true);
	} else if (type_of_phone == "second") {
		cube([9.0,14,28], center=true);
	} else if (type_of_phone== "third") {
		cube([8.7,14,28], center=true);
	} else if (type_of_phone == "fourth") {
		cube([10.8,14,28], center=true);
	} else if (type_of_phone == "fifth") {
		cube([9.2,14,28], center=true);
	} else if (type_of_phone == "sixth") {
		cube([9.5,14,28], center=true);
	} else if (type_of_phone == "seventh") {
		cube([10,14,28], center=true);
	} else if (type_of_phone == "eighth") {
		cube([8.5,14,28], center=true);
	} else if (type_of_phone == "nineth") {
		cube([10.6,14,28], center=true);
	} else if (type_of_phone == "tenth") {
		cube([8.6,14,28], center=true);
	} else if (type_of_phone == "eleventh") {
		cube([9.4,14,28], center=true);
	} 
};


union(){
translate([0,0,-12])main();}

	translate([-25,0,-1])TLB_linearBearing(
							inner_d          = 8, 
							outer_d          = 15,
							h                = 24,
							stringWidth      = 0.5,
							minWallThickness = 0.85, 
							tooths           = 16, 
							toothRatio       = 0.25);

	translate([25,0,-1])TLB_linearBearing(
							inner_d          = 8, 
							outer_d          = 15,
							h                = 24,
							stringWidth      = 0.5,
							minWallThickness = 0.85, 
							tooths           = 16, 
							toothRatio       = 0.25);







// LINEAR BEARING CODE by Krallinger Sebastian
// ************* units.scad ************* //
mm = 1;
cm = 10 * mm;
dm = 100 * mm;
m = 1000 * mm;

inch = 25.4 * mm;

X = [1, 0, 0];
Y = [0, 1, 0];
Z = [0, 0, 1];

M3 = 3*mm;
M4 = 4*mm;
M5 = 5*mm;
M6 = 6*mm;
M8 = 8*mm;



epsilon = 0.01*mm;
OS = epsilon;

// ************* toothedLinearBearing.scad ************* //


/**
* @brief Toothed Linear Bearing (TLB).
*
* Linear Bearing with parallel triagnles towards the center.
* @param inner_d Inner diameter (Axis Diameter)
* @param outer_d outer diameter (holder Diameter)
* @param h height
* @param stringWidth width of an single string of your printer (this defines the width of the tooth walls)
* @param minWallThickness minimum thickness of the outer wall.
* @param tooths number of toohts on the innside
* @param toothRatio coverd length of the inner ring
**/
module TLB_linearBearing(
inner_d = 8,
outer_d = 15,
h = 24,
stringWidth = 0.5,
minWallThickness = 0.85,
tooths = 16,
toothRatio = 0.25
) {

stringWidth = stringWidth; //!< the layer width of one string

TLB_innerD = inner_d;
TLB_outerD = outer_d;
TLB_minWallThickness = minWallThickness;
TLB_h = h;
TLB_tooths = tooths;

TLB_toothRate = toothRatio;


gapWidth = (TLB_innerD*PI)/TLB_tooths *TLB_toothRate;
//echo(str("gap Width: ", gapWidth));
middR = TLB_outerD/2- TLB_minWallThickness;

//outer ring
difference() {
cylinder(r=TLB_outerD/2, h=TLB_h, center=true);
cylinder(r=middR, h=TLB_h+2*OS, center=true);
}


difference() {
union(){
cylinder(r=TLB_innerD/2 + stringWidth, h=TLB_h, center=true);

for (i=[0:360 / TLB_tooths : 360]) {
rotate(a=i,v=Z) translate([-(gapWidth+2*stringWidth)/2, 0, -TLB_h/2])
cube(size=[gapWidth+2*stringWidth, middR+OS, TLB_h], center=false);
}
}
union(){
cylinder(r=TLB_innerD/2, h=TLB_h+2*OS, center=true);

for (i=[0:360 / TLB_tooths : 360]) {
rotate(a=i,v=Z) translate([-gapWidth/2, 0, -TLB_h/2-OS])
cube(size=[gapWidth, middR, TLB_h+2*OS], center=false);
}
}
}

};
