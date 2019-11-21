//by Thingiverse user Steamgear
use <build_plate.scad>;
use <utils/build_plate.scad>;

/* [Basic] */
center = 1;//[0:Ring,1:Hemisphere]
number_of_rings = 6;//[2:12]

/* [Advanced] */
gap = 0.5;
ring_height = 5;
radius = 1;//[0:internal, 1:minimal]
internal_radius = 10;
minimal_ring_radius = 10;

Use = 0;//[0:thickness,1:exernal_diameter]
thickness = 3;
external_radius = 13;

shell = Use==0 ? thickness : external_radius/number_of_rings-gap;
minimal_radius =  radius == 0 ? internal_radius+shell : minimal_ring_radius;

/* [Printing] */

//for display only, doesn't contribute to final object 
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension 
build_plate_manual_x = 190; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension 
build_plate_manual_y = 190; //[100:400]

nozzle_size  = 0.4;

/* [Hidden] */
$fa = 5;//Minimal angle
$fs = 0.4; //Minimal size of a fragment

//minimal_radius = internal_radius+shell;

module inner_ring(radius, height, shell){
	sphere(r = radius, center = true);
	for(i = [0:1]){
		rotate([0,0,180*i])
		translate([radius-shell/2,0,0])
		rotate([0,90,0])
		cylinder(r1 = (gap+shell)*0.8,r2 = nozzle_size, h = gap+shell, center = false);
	}

}

module middle_ring(radius, height, shell){
	rotate([0,0,90])
	for(i = [0:1]){
		rotate([0,0,180*i])
		translate([radius-shell/2,0,0])
		rotate([0,90,0])
		cylinder(r1 = (gap+shell)*0.8,r2 = nozzle_size, h = gap+shell, center = false);
	}
	difference(){
		difference(){
		sphere(r = radius);
		sphere(r = radius - shell);
		}
		for(i = [0:1]){
			rotate([0,0,180*i])
			translate([radius-shell-gap,0,0])
			rotate([0,90,0])
			cylinder(r1 = (gap+shell)*2/3,r2 = nozzle_size, h = 0.1+gap+shell/2, center = false);
		}
	}
}

module outer_ring(radius, height, shell){
	difference(){
		difference(){
			cylinder(r = radius, h = height, center = true);
			sphere(r = radius-shell, center = true);
		}
		for(i = [0:1]){
			rotate([0,0,180*i])
			translate([radius-shell-gap,0,0])
			rotate([0,90,0])
			cylinder(r1 = (gap+shell)/2,r2 = nozzle_size, h = 0.1+gap+shell/2, center = false);
		}
	}
}

translate([0,0, ring_height/2]){
	if (center == 1){							//Central part
		intersection(){
			inner_ring(minimal_radius, ring_height, shell);
			translate([0,0,-ring_height/2])
			cylinder(r = minimal_radius+(shell+gap*2), h = minimal_radius*2, center = false);
		}
	} else if (center == 0){
		intersection(){
			difference(){
				inner_ring(minimal_radius, ring_height, shell);
				cylinder(r = minimal_radius-shell, h = ring_height+1, center = true);
			}
			cylinder(r = minimal_radius+(shell+gap*2), h = ring_height, center = true);
		}
	}

	if(number_of_rings > 2){				//Middle part
		intersection(){
			for (i = [0:number_of_rings-3]){
			rotate([0,0,i*90])
			middle_ring(minimal_radius+(shell+gap)*(i+1), ring_height, shell);
			}
		cylinder(r = minimal_radius+(shell+gap)*number_of_rings, h = ring_height, center = true);
		}
	}
	
	if(number_of_rings % 2 == 0){			//External part
		outer_ring(minimal_radius+(shell+gap)*(number_of_rings-1), ring_height, shell);
	} else {
		rotate([0,0,90])
		outer_ring(minimal_radius+(shell+gap)*(number_of_rings-1), ring_height, shell);
	}
}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);