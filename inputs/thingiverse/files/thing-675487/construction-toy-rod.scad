//CUSTOMIZER VARIABLES

//The length of the rod
length = 40;

//The radius of the rod
rod_rad = 1;

//The length of the peg portion
peg_len = 3;

//The length of the rod portion that isn't grooved
non_groove_len = 3;

//Round it?
rounded = 0;//[0, 1]

//The amount of roundness (applied as a sphere's radius applied with minkowski)
roundness = 0.5;

//The number of grooves
grooves = 4;

//Red
R = 140;//[0:255]
//Green
G = 60;//[0:255]
//Blue
B = 40;//[0:255]
//Alpha
A = 255;//[0:255]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

$fn = 50;
rod_color = [R/255.0, G/255.0, B/255.0, A/255.0];

//The diameter of the rod
module rod(length, peg_len = 3, non_groove_len = 3, roundness = 0.5, grooves = 6, rod_rad = 1){
	union(){
		cylinder(h = peg_len, r1 = rod_rad, r2 = rod_rad*0.75);
		translate([0,0,peg_len]){
			difference(){
				cylinder(h = length - 2*peg_len, r = rod_rad);
				translate([0,0,non_groove_len]){
					for (i = [0:grooves-1]){
						rotate([0,0,i*360.0/grooves]){
							translate([0.3,0.3*sin(360.0/grooves),0]){
								linear_extrude(length - 2*peg_len - 2*non_groove_len){
									polygon([[rod_rad/4,0],
												[rod_rad,0],
												[cos(360.0/grooves)*rod_rad,sin(360.0/grooves)*rod_rad],
												[cos(360.0/grooves)*rod_rad/4,sin(360.0/grooves)*rod_rad/4]]);
								}
							}
						}
					}
				}
			}
		}
		translate([0,0,length - peg_len]){
			cylinder(h = peg_len, r1 = rod_rad*0.75, r2 = rod_rad);
		}
	}
}

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

color(rod_color){
	if (rounded==1){
		minkowski(){
			sphere(roundness);
			rod(length, peg_len, non_groove_len, roundness, grooves, rod_rad);
		}
	} else{
		rod(length, peg_len, non_groove_len, roundness, grooves, rod_rad);
	}
}