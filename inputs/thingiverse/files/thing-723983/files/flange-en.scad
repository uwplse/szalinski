use <build_plate.scad>;
use <utils/build_plate.scad>;

//All dimentions are in mm.

//==========Parameters==========

/* [Axle parameters] */

axle_diameter = 6;//[1:10]

//set this equal to the diameter for a round axle
axle_thickness = 5.5;//[1:10]

axle_th = axle_diameter < axle_thickness ? axle_diameter : axle_thickness;

axle_lenght = 12;

//Hub's outer diam
hub_diameter = 25;

/* [Flange parameters] */

//flange_diameter = 41;

// 0 if not needed
flange_height = 4;

//Number of radial holes in the flange
flange_holes_number = 5;

//Radial holes' position radius
radial_holes_r_vector = 17;

/*[Finger parameters] */

finger_diameter = 21.8;//[2.2:40]

// 0 if not needed
finger_height = 7.2;

//==========Screws and nuts==========

/* [Screws and nuts] */

screw_diameter = 4;

// not less than 6 for a 3 mm screw and 7.7 for 4 mm
nuts_external_diameter = 7.7;

// try 5.5 for a 3 mm screw or 7 for 4 mm
nuts_across_flats = 7;

//try 2.4 for a 3 mm screw or 3.2 for 4 mm
nut_height = 3.2;

//==========Additional parameters==========
/* [Printing] */

layer_thickness = 0.2;//[0.05:0.2]

shell_thickness = 1.2; //[0.2:5]

//for display only, doesn't contribute to final object 
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension 
build_plate_manual_x = 190; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension 
build_plate_manual_y = 190; //[100:400]

/* [Hidden] */

//Smoothing (see openSCAD docs)
$fa = 5;//Minimal angle
$fs = 0.4; //Minimal size of a fragment
//$fn = 100;//Number of segments. This option overrides the previous 2, be careful

//============================================

flange_diameter = shell_thickness*2 + screw_diameter + radial_holes_r_vector*2;

function align(n, d) = ceil(n/d)*d;

la = align(axle_lenght, layer_thickness);
lf = align(flange_height, layer_thickness);
ls = align(finger_height, layer_thickness);
do = align(nuts_external_diameter, layer_thickness);

echo(str("<b>Total height ", do+lf+ls, " mm"));
echo(str("<b>Number of layers: ", round((do+lf+ls)/layer_thickness)));
echo(str("<b>Hub height ", round(do*100)/100, " mm"));
echo(str("<b>Flange height ", round(lf*100)/100, " mm"));
echo(str("<b>Finger height ", round(ls*100)/100, " mm"));

module blank(){
	cylinder(r = hub_diameter/2, h = do+lf/2, center = false);				//Hub
	cylinder(r = flange_diameter/2, h = lf, center = true);					//Flange
	translate([0,0,-ls-lf/2+2]){
		cylinder(r = finger_diameter/2-0.08, h = ls+lf/2-2, center = false);	//Finger
		translate([0,0,-2])
		cylinder(r2 = finger_diameter/2-0.08, r1=finger_diameter/2-1.1, h = 2, center = false);//bevel
	}
}

module negative(){
translate([0,0,do-la+lf/2])
	intersection(){										//Axle
		cylinder(r = axle_diameter/2+0.3, h = la+1, center = false);
		translate([axle_th-axle_diameter, 0, la/2])
		cube([axle_diameter+0.5, axle_diameter+0.5, la+1], center = true);
	}
	translate([0,0,(lf+do)/2])
	rotate([0,90,0])
	union(){
		cylinder(r = align(screw_diameter/2, layer_thickness)+layer_thickness*2, h = hub_diameter/2+1, center = false);	//Screw
		rotate([0,0,180])
		translate([-do/2, -(nuts_across_flats+0.5)/2, axle_th-axle_diameter/2+shell_thickness])
		cube([do+1, nuts_across_flats+0.5, nut_height+0.5], center = false);						//Nut
	}
	rotate([0,0,180/flange_holes_number])
	for(i = [1:flange_holes_number]){									//even more screws
		rotate(i*360/flange_holes_number,[0,0,1])
		translate([radial_holes_r_vector,0,0])
		cylinder(r=screw_diameter/2+0.25, h = lf+1, center = true);
	}
}

module flange(){
	difference(){
		blank();
		negative();
	}
}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

translate([0,0,finger_height+flange_height/2])
rotate([0,0,-90])
flange();

