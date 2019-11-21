include <utils/build_plate.scad>
//CUSTOMIZER VARIABLES
//
base_thickness = 4;//[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10]
// of the base plate:
radius = 17;//[10:50]
// ratio to the base thickness:
bezel = 0.6;//[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]

// of the hook from the back of the base:
height = 20;//[10:50]
// of the hook:
angle = 25;//[0:60]
// of the hook from the center of the base:
offset = 6;//[-20:20]
// at the top:
hook_thickness = 3;//[1:10]
//:
hook_base_thickness = 5;//[3:15]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
//CUSTOMIZER VARIABLES END

$fn=100;

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

translate([0,0,base_thickness*(1-bezel)]) {
	cylinder(base_thickness*bezel, radius, radius - base_thickness*bezel);
}
cylinder(base_thickness*(1-bezel),radius,radius);
intersection() {
	translate([-offset,0,]) {
		rotate([0,angle,0]){
			cylinder(height,hook_base_thickness,hook_thickness);
			translate([0,0,height-.3]){
				sphere(hook_thickness);
			}
		}
	}
	cylinder(height+hook_thickness,radius,radius);
}
