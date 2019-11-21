// Bird House Customizer v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:106951
//
// I decided to take a shot at the Makerbot Birdhouse Challenge. I based the 
// bird houses off the specifications listed on this site:
// http://www.birdsandblooms.com/Backyard-Projects/Birdhouses/Birdhouse-Guidelines/
//
// I've also included the ability to create a totally custom birhouse based
// on your own measurements and text.  
//
// Change Log:
//
// v1.0
// Initial Release
//

/////////////////////////
//  Customizer Stuff  //
///////////////////////

/* [Prebuilt] */

// What kind of bird are we creating lodging for?
bird_type = 0; // [0:Chickadee,1:Downy Woodpecker,2:Eastern Bluebird,3:House Wren,4:Nuthatch,5:Tree Swallow,6:Tufted Titmouse]

// Label your Birdhouse
text_label = "TNH";
// Pick a font
text_font = "write/orbitron.dxf"; // ["write/BlackRose.dxf":Black Rose, "write/braille.dxf":Braille,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]
// Resize your label
text_size = 30; // [10:50]
// Move label left and right
text_left_right = 30; // [0:100]
// Move label up and down
text_up_down = 15; // [0:100]

//For display only, not part of final model
build_plate_selector = 0; //[0:Replicator 2/2X,1: Replicator,2:Thingomatic,3:Manual]

// "Manual" build plate X dimension
build_plate_manual_x = 100; //[100:400]

// "Manual" build plate Y dimension
build_plate_manual_y = 100; //[100:400]

/* [Custom] */

//Adjust birdhouse width
custom_width = 100; // [50:150]
//Adjust birdhouse length
custom_length = 100; // [65:150]
//Adjust birdhouse height
custom_height = 200; //[100:250]

//Diameter of opening
custom_opening = 30; // [5:40]
//Height of opening
custom_opening_height = 150; // [60:210]

// Label your Birdhouse
custom_text_label = "TNH";
// Pick a font
custom_text_font = "write/orbitron.dxf"; // ["write/BlackRose.dxf":Black Rose, "write/braille.dxf":Braille,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]
// Resize your label
custom_text_size = 30; // [10:50]
// Move label left and right
custom_text_left_right = 30; // [0:100]
// Move label up and down
custom_text_up_down = 15; // [0:100]

//For display only, not part of final model
custom_build_plate_selector = 0; //[0:Replicator 2/2X,1: Replicator,2:Thingomatic,3:Manual]

// "Manual" build plate X dimension
custom_build_plate_manual_x = 100; //[100:400]

// "Manual" build plate Y dimension
custom_build_plate_manual_y = 100; //[100:400]

// preview[view:north west, tilt:top diagonal]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

bh_width = [101.6,101.6,127,101.6,101.6,127,101.6];
bh_length = [101.6,101.6,127,101.6,101.6,127,101.6];
bh_height = [203.2,254,203.2,203.2,254,152.4,203.2];

bh_opening = [31.75,31.75,38.1,28.575,31.75,38.1,31.75];
bh_opening_height = [152.4,184.15,152.4,152.4,190.5,101.6,150];

preview_tab = "Prebuilt";

use <write/Write.scad>
use <utils/build_plate.scad>	

////////////////////////////////
// Lets make some birdhouses //
//////////////////////////////

module birdhouse_solid(){
	difference(){
		union(){
			cube([bh_height[bird_type], bh_width[bird_type], bh_length[bird_type]]);
			translate([bh_opening_height[bird_type]-50,bh_width[bird_type]/4,bh_length[bird_type]]) cube([80, bh_width[bird_type]/2, 10]);
			translate([bh_opening_height[bird_type]-40,bh_width[bird_type]/2,bh_length[bird_type]]) cylinder(r=5, h=50);

		}
		translate([bh_height[bird_type]/2,bh_width[bird_type]/2,1]) write("TNH",h=10,t=1,font="write/orbitron.dxf", space=1);
	}
}

module roof(){
	difference(){
		translate([bh_height[bird_type],0,0]) cube([15, bh_width[bird_type], bh_length[bird_type]+40]);
		translate([bh_height[bird_type]+22,-10,10]) rotate([0,-7,0]) cube([100, bh_width[bird_type]+30, bh_length[bird_type]+40]);
	}
}

module custom_birdhouse_solid(){
	difference(){
			union(){
			cube([custom_height, custom_width, custom_length]);
			translate([custom_opening_height-50,custom_width/4,custom_length]) cube([80, custom_width/2, 10]);
			translate([custom_opening_height-40,custom_width/2,custom_length]) cylinder(r=5, h=50);	
		}
	translate([custom_height/2,custom_width/2,1]) write("TNH",h=10,t=1,font="write/orbitron.dxf", space=1);
	}
}

module custom_roof(){
	difference(){
		translate([custom_height,0,0]) cube([15, custom_width, custom_length+40]);
		translate([custom_height+22,-10,10]) rotate([0,-7,0]) cube([100, custom_width+30, custom_length+40]);
	}
}

/////////////////////////////
// Decide what to display //
///////////////////////////

if (preview_tab == "Prebuilt"){
	color("Turquoise"){
		translate([-bh_height[bird_type]/2-7,-bh_width[bird_type]/2,0]){
			union(){
				difference(){
					birdhouse_solid();
					translate([7,7,7]) scale([.9,.9,.9]) cube([bh_height[bird_type], bh_width[bird_type], bh_length[bird_type]]);
					translate([bh_opening_height[bird_type],bh_width[bird_type]/2,bh_length[bird_type]-25]) cylinder(r=bh_opening[bird_type]/2, h=40);
					//Body Trim
					translate([-20,bh_width[bird_type],bh_length[bird_type]-6]) rotate([45,0,0]) cube([bh_height[bird_type]+20, 10, 10]);
					translate([-20,0,bh_length[bird_type]-6]) rotate([45,0,0]) cube([bh_height[bird_type]+20, 10, 10]);
					translate([-7,0,bh_length[bird_type]+1]) rotate([0,45,0]) cube([10, bh_width[bird_type]+20, 10]);
					//Flange Trim
					translate([bh_opening_height[bird_type]+25,0,bh_length[bird_type]+11]) rotate([0,45,0]) cube([10, bh_width[bird_type]+20, 10]);
					translate([bh_opening_height[bird_type]-59,0,bh_length[bird_type]+11]) rotate([0,45,0]) cube([10, bh_width[bird_type]+20, 10]);
					translate([bh_opening_height[bird_type]-55,bh_width[bird_type]/4,bh_length[bird_type]+6]) rotate([45,0,0]) cube([90, 10, 10]);
					translate([bh_opening_height[bird_type]-55,bh_width[bird_type]/4*3,bh_length[bird_type]+6]) rotate([45,0,0]) cube([90, 10, 10]);
					// Ventilation Holes
					translate([bh_height[bird_type]-20,bh_width[bird_type]+100,bh_length[bird_type]/2]) rotate([90,90,0]) cylinder(r=5, h=300);
					translate([bh_height[bird_type]-20,bh_width[bird_type]+100,bh_length[bird_type]/2+20]) rotate([90,90,0]) cylinder(r=5, h=300);
					translate([bh_height[bird_type]-20,bh_width[bird_type]+100,bh_length[bird_type]/2-20]) rotate([90,90,0]) cylinder(r=5, h=300);
				}
				translate([text_up_down,bh_width[bird_type]/2+text_left_right,bh_length[bird_type]]) rotate([0,0,270]) write(text_label,h=text_size,t=2,font=text_font, space=1);
				roof();
			}	
		}
	}
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
} 

if(preview_tab == "Custom"){
	color("Tomato"){
		translate([-custom_height/2-7,-custom_width/2,0]){
			union(){
				difference(){
					custom_birdhouse_solid();
					translate([25,6,6]) scale([.8,.8,.8]) cube([custom_height, custom_width, custom_length]);
					translate([custom_opening_height,custom_width/2,custom_length-25]) cylinder(r=custom_opening/2, h=40);
					//Body Trim
					translate([-20,custom_width,custom_length-6]) rotate([45,0,0]) cube([custom_height+20, 10, 10]);
					translate([-20,0,custom_length-6]) rotate([45,0,0]) cube([custom_height+20, 10, 10]);
					translate([-7,0,custom_length+1]) rotate([0,45,0]) cube([10, custom_width+20, 10]);
					//Flange Trim
					translate([custom_opening_height+25,0,custom_length+11]) rotate([0,45,0]) cube([10, custom_width+20, 10]);
					translate([custom_opening_height-59,0,custom_length+11]) rotate([0,45,0]) cube([10, custom_width+20, 10]);
					translate([custom_opening_height-55,custom_width/4,custom_length+6]) rotate([45,0,0]) cube([90, 10, 10]);
					translate([custom_opening_height-55,custom_width/4*3,custom_length+6]) rotate([45,0,0]) cube([90, 10, 10]);
					// Ventilation Holes
					translate([custom_height-20,custom_width+100,custom_length/2]) rotate([90,90,0]) cylinder(r=5, h=300);
					translate([custom_height-20,custom_width+100,custom_length/2+20]) rotate([90,90,0]) cylinder(r=5, h=300);
					translate([custom_height-20,custom_width+100,custom_length/2-20]) rotate([90,90,0]) cylinder(r=5, h=300);
				}
				translate([custom_text_up_down,custom_width/2+custom_text_left_right,custom_length]) rotate([0,0,270]) write(custom_text_label,h=custom_text_size,t=2,font=custom_text_font, space=1);
				custom_roof();
			}	
		}
	}
	build_plate(custom_build_plate_selector,custom_build_plate_manual_x,custom_build_plate_manual_y);
}