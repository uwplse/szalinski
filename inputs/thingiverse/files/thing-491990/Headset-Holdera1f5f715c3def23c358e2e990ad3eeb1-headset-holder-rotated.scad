// Filename: parametric_headset_holder.scad
// Author: Steffen Pfiffner
// Date: 06/10/2014
// Email: s.pfiffner@gmail.com
// Web: http://www.thingiverse.com/FiveF

// Project: Parametric Headset Holder

use <build_plate.scad>

/* [Basic] */
//Normally the thickness of the table should be chosen slightly bigger than the real thickness because material shrinkage. (for PLA about 0.1mm)
thickness_of_tabletop = 35;
width_of_headband = 45;

holder_length = 40;
holder_width = 40;
holder_strength = 3;

holder_height = 10;

/* [Quality] */
//$fa is the minimum angle for a fragment. Even a huge circle does not have more fragments than 360 divided by this number. The default value is 12 (i.e. 30 fragments for a full circle). The minimum allowed value is 0.01. Any attempt to set a lower value will cause a warning.
$fa = 5.0;

//$fs is the minimum size of a fragment. Because of this variable very small circles have a smaller number of fragments than specified using $fa. The default value is 2. The minimum allowed value is 0.01. Any attempt to set a lower value will cause a warning.
$fs = 1.0;

/* [Advanced] */

/* [Hidden] */
width_of_headset = width_of_headband + 2*holder_strength;

//Build plate:

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//Build plate END


//half cylinder
module half_cylinder(){
	difference(){
		translate([0,-holder_length/2-width_of_headset/2,thickness_of_tabletop+holder_strength]){
			rotate(a=90, v=[1,0,0]){
				
				cylinder (h = width_of_headset-2*holder_strength, r=holder_width/2, center = true);
			}
			
		}
		
		translate([0,-holder_length/2-width_of_headset/2,holder_width/2+thickness_of_tabletop-holder_strength*2+0.5]){
			cube([holder_width,width_of_headset+5,holder_width/2], center = true);
		}
	}
}

//HOLDER START
//thickness_of_tabletop+holder_strength/2+holder_strength
translate([holder_length/2,-thickness_of_tabletop/2,holder_width/2]){
	rotate(a=180, v=[0,1,0]){
		rotate(a=90, v=[0,0,1]){
			rotate(a=90, v=[0,1,0]){
				difference(){
					union(){

						translate([0,0,0]){
							cube([holder_width,holder_length,holder_strength], center = true);
						}

						translate([0,0,thickness_of_tabletop+holder_strength]){
							cube([holder_width,holder_length,holder_strength], center = true);
						}


						translate([0,-holder_length/2-holder_strength/2,thickness_of_tabletop/2+holder_strength/2]){
							rotate(a=90, v=[1,0,0]){
								cube([holder_width,thickness_of_tabletop+2*holder_strength,holder_strength], center = true);
							}
						}


						half_cylinder();
						
						translate([0,-holder_length/2-width_of_headset+holder_strength/2+holder_strength,-holder_height+0.25]){
							resize([holder_width+holder_height,holder_strength,0], auto=true){
								half_cylinder();
							}
						
						}
					}

					union(){

						//the following line remove stuff
						//bottom
						translate([0,-holder_length/2-width_of_headset/2,holder_width/2+thickness_of_tabletop-holder_strength*2]){
							cube([holder_width*2,width_of_headset*5,holder_width/2], center = true);
						}

						//sides
						//left
						translate([holder_width/2 + 20,0,0]){
							cube([40,500,500], center = true);
						}

						//right
						translate([-holder_width/2 - 20,0,0]){
							cube([40,500,500], center = true);
						}

					}
				}
			}
		}
	}
}

//HOLDER END


