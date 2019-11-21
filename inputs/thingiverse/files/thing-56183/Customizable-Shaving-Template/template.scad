// Joe Stubbs
// March 1 2013
// http://www.thingiverse.com/thing:56183


use <utils/build_plate.scad>

$fn = 50*1;

//Select the basic shape for your template
Template_Shape = 2; // [1:Strip,2:Arrow,3:Heart]

//Select the basic width for your design
Width = 20; //[10:30]

//Select the basic height for your design (not used with the heart shape)
Height = 50; //[10:80]

//Select the thickness for the template
Thickness = 4; //[3:8]


strip_x=Height;
strip_y=Width;
strip_z=Thickness;

handle_d=5*1;
handle_r=handle_d/2;
handle_z=strip_z*3;

handle_x = handle_d;

arrow_y = strip_y*1.5;

fudge=0.05*1;


shape = Template_Shape;






//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);






if (shape == 1) landingStrip();
if (shape == 2) arrowStrip();
if (shape == 3) heartStrip();



module landingStrip() {
	translate([0,0,strip_z/2]) {
		cube ([strip_x,strip_y,strip_z],center=true);
		translate ([handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
		translate ([-handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
	}              
}                                                                     





module arrowStrip() {
	translate([0,0,strip_z/2]) {
		cube ([strip_x,strip_y,strip_z],center=true);
		
		translate([strip_x/2,0,0])
			difference() {
				rotate(45,[0,0,1])
					cube ([arrow_y,arrow_y,strip_z],center=true);
				translate([-arrow_y,0,0])
					cube ([arrow_y*2,arrow_y*2,strip_z+fudge],center=true);
			}
		

		translate ([handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
		translate ([-handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
	}              
}   






module heartStrip() {
	translate([0,0,strip_z/2]) {
		rotate(45,[0,0,1])
			cube ([strip_y,strip_y,strip_z],center=true);
			
		translate ([-strip_y/3.14,-strip_y/3.14,0])
		cylinder(r=strip_y/2,h=strip_z,center=true);

		translate ([-strip_y/3.14,strip_y/3.14,0])
		cylinder(r=strip_y/2,h=strip_z,center=true);

		

		translate ([handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
		translate ([-handle_x,0,handle_z/2])
			cylinder(r=handle_r,h=handle_z,center=true);
	

	}              
}                                                                     