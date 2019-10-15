// Customizable Bike Light Mount v1.0
// TheNewHobbyist 2014 http://thenewhobbyist.com
// e-mail: chris@thenewhobbyist
// twitter: @thenewhobbyist
//
// Description: 
// This is a design for a bike handlebar mount for flashlights.
//
// Usage:
// 1. Enter the desired number of zip tie routing holes.
// 2. Enter the diameter of your flashlight and bike handlebars.
// 

/* [Settings] */

//How many zip ties (per side) would you like to use?
zipties = 2; // [1, 2]

//Enter the thickness of your flashlight in mm.
light_thickness = 22;

//Enter the diamter of your handlebar in mm.
bar_thickness = 22;

//Enter the width of your zip tie.
zip_thickness = 6.7;

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* [Hidden] */

box_height = bar_thickness+light_thickness*.15;

bar_ziptie = bar_thickness+6.8;
light_ziptie = light_thickness+6.8;

use <utils/build_plate.scad>

module holder(){
	difference(){ 
		cube([bar_thickness+6, light_thickness+6, box_height],center=true);
		translate([0,0,box_height/1.5]) rotate([0,90,0]) cylinder(r=light_thickness/2, h=bar_thickness+20, center=true);
		translate([0,0,-box_height/1.5]) rotate([90,90,0]) cylinder(r=bar_thickness/2, h=light_thickness+20, center=true);
	}
}

module ziptie_top(){
	difference(){
		translate([0,0,box_height/1.5]) rotate([0,90,0]) cylinder(r=light_thickness/2+6, h=zip_thickness, center=true);
		translate([0,0,box_height/1.5]) rotate([0,90,0]) cylinder(r=light_thickness/2+3, h=bar_thickness+20, center=true);
	}
}

module ziptie_bottom(){
	difference(){
		translate([0,0,-box_height/1.5]) rotate([90,90,0]) cylinder(r=bar_thickness/2+6, h=zip_thickness, center=true);
		translate([0,0,-box_height/1.5]) rotate([90,90,0]) cylinder(r=bar_thickness/2+3, h=bar_thickness+20, center=true);
	}
}

if (zipties == 1){
	translate([0,0,box_height/2]){
		difference(){
			holder();
			ziptie_top();
			ziptie_bottom();
		}
	}
}

else if (zipties == 2){
	translate([0,0,box_height/2]){
		difference(){
			holder();
			translate([(bar_thickness+6.8)*.25,0,0]) ziptie_top();
			translate([(bar_thickness+6.8)*-.25,0,0]) ziptie_top();
			translate([0,(light_thickness+6.8)*.25,0]) ziptie_bottom();
			translate([0,(light_thickness+6.8)*-.25,0]) ziptie_bottom();
		}
	}
}