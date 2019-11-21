/*
  By David Pflug <david@tpflug.com>
  CC BY-NC-SA 4.0
*/

// preview[view: north east, tilt:top diagonal]

use <utils/build_plate.scad>

$fa = 1 + 0;
$fs = 0.01 + 0;

// Full width of the slotted beam
beam_width = 15;

slot_width = 3.4;

// This would be the rod you're using in the bushing
rod_diameter = 6.35;

// This is for both the compression bolt and the bolts used to attach parts.
bolt_diameter = 3;

// How thick is the captive nut you're using?
nut_height = 2.4;

// And what does it measure from flat to flat? What's its "diameter"?
nut_across_flats=5.5;

// Adjust to fit the tolerances of your parts/printer
fudge_factor=0.001;

/* Build Plate */
//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

module RotaryCluster(radius=7.5, number=4)
     for (azimuth = [0:360/number:359])
	  rotate([0, 0, azimuth])
	       translate([radius, 0, 0]) children();

module MiltyKarriage(beam_width=15, rod_diameter=6.35, slot_width=3.4, bolt_diameter=3, nut_height=2.4, nut_across_flats=5.5) {
     rod_radius=rod_diameter/2;
     
     k_width=beam_width*2;
     k_length=beam_width*2+rod_radius;
     k_height=rod_radius*5;

     gap = beam_width/20;

     // Calculate the isosceles triangle for the rods
     rod_offset = sqrt(pow(rod_radius, 2)-pow(slot_width, 2)/4);

     difference() {
	  union() {
	       // Basic shape
	       linear_extrude(k_height, convexity=4) difference() {
		    union() {
			 translate([0, rod_radius/2]) square([k_width, k_length], true);
			 RotaryCluster(beam_width/2+rod_offset, 2) circle(rod_radius+beam_width/2);
		    }
		    translate([0, beam_width/2]) square([beam_width+gap*2, beam_width*2+gap*2], true);
		    RotaryCluster(beam_width/2+rod_offset, 2) circle(rod_radius+fudge_factor);
	       }
	       // Rear guide
	       linear_extrude(k_height) translate([0, -beam_width/2-rod_offset]) difference() {
		    circle(rod_radius+fudge_factor);
		    translate([0, -rod_radius])
			 square(rod_radius*2, center=true);
	       }
	  }
	  // Rear bolt holes
	  RotaryCluster(beam_width/3, 2)
	       translate([0, 0, k_height/2])
	       rotate([90, 0])
	       cylinder(k_length, d=bolt_diameter+fudge_factor, center=true);
	  // Nut detents. If I don't include that 0.1mm in the translate, it doesn't make it out of the face.
	  translate([0, -beam_width/2-gap-nut_height/2+0.1, k_height/2])
	       RotaryCluster(beam_width/3, 2)
	       rotate([90, -90])
	       cylinder(nut_height, d=nut_across_flats+fudge_factor, center=true, $fn=6);
	  // Compression bolt holes
	  translate([0, beam_width-gap, k_height/2+k_width/24])
	       rotate([0, 90])
	       cylinder(k_width*2, d=bolt_diameter+fudge_factor, center=true);
	  // Chamfer exterior
	  translate([0, k_length/2+k_height/12, k_height])
	       rotate([45, 0, 0])
	       cube([k_width+fudge_factor*10, k_height/12, k_height/6], center=true);
	  translate([0, k_length/2+k_height/12, 0])
	       rotate([45, 0, 0])
	       cube([k_width+fudge_factor*10, k_height/2, k_height/3], center=true);
	  translate([0, -k_width/2, k_height/2-fudge_factor])
	       RotaryCluster(k_width/2, 2)
	       rotate(45)
	       cube([k_width/12, k_width/12, k_height+fudge_factor*10], center=true);
     }
     // Rod retainer shelf
     linear_extrude(rod_radius)
	  RotaryCluster(beam_width/2+gap+rod_radius, 2)
	  square(rod_radius*2, true);
     // Interior fillets
     translate([0, -beam_width/2-gap, 0])
	  linear_extrude(k_height)
	  RotaryCluster(beam_width/2+gap, 2)
	  rotate(45)
	  square(gap*gap, true);
}

MiltyKarriage(beam_width, rod_diameter, slot_width, bolt_diameter, nut_height, nut_across_flats);

%build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
