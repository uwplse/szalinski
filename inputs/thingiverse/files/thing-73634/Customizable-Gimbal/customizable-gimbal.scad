/* [Gimbal] */

// The width of each ring
ring_width=5; // [3:20]

// The space between each ring
ring_spacing=1; // [.5:2]

// The Height of the center ring
ring_height=6; // [6:100]

// The total number of rings
number_of_rings=3; // [1:20]

// The radius of the center hole
center_radius=6; // [1:50]

Build_Plate_Type = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
Build_Plate_Manual_Width = 100; //[100:400]
Build_Plate_Manual_Length = 100; //[100:400]

/* [Advanced] */

// The mesh resolution
mesh_resolution=70; // [20:120]

// The ring to ring height increase
ring_height_step=.5;

// The radius of a pin
pin_radius=2.45;

// The width of material covering the pin hole
pin_cap_width=4;

// The pin end to hole wall width
pin_cap_gap=.45;

// radius of the pin holes
pin_hole_radius=3;

use <utils/build_plate.scad>


/* [Hidden] */

$fn=mesh_resolution; // mesh resolution

build_plate(Build_Plate_Type,Build_Plate_Manual_Width,Build_Plate_Manual_Length);

// translate everything so that it rests on z=0
// and loop over all rings
translate(v=[0, 0, ring_height*.5]) union()
for (ring = [0 : number_of_rings-1]) assign(
	ir=center_radius+(ring_width+ring_spacing)*ring,
	or=center_radius+(ring_width+ring_spacing)*(ring+1)-ring_spacing,
	odd=(ring%2), even=((ring+1)%2)) {

	// translate each new ring so that the pins get printed
   // resting on the next ring's hole wall
	translate(v=[0, 0, ring*ring_height_step*.5]) intersection() {
		difference() {
      	difference() {
				union() {
					sphere(r=or, center=true);
					// the last ring does not have protruding pins
					if (ring != number_of_rings-1) rotate(v=[even, odd, 0], a=90)
						cylinder(r=pin_radius, 
					   	h=(or*2-ir+ring_spacing)*2-(pin_cap_width+pin_cap_gap),
							center=true);
				}
				// the inner-most ring does not have pin holes
				if (ring==0) cylinder(r=center_radius, h=50, center=true);
				else union() {
					sphere(r=ir, center=true);
					rotate(v=[odd, even, 0], a=90)
						cylinder(r=pin_hole_radius, h=or*2-pin_cap_width, center=true);
				}
			}
			if (ring != number_of_rings-1)
				rotate(v=[even, odd, 0], a=90)
					rotate(v=[0,0,1], a=45)
						cube(size=[pin_radius, pin_radius,
                       (or+ring_width+ring_spacing)*2],
                       center=true);
		}

		// make each ring thicker than the last so that the
      // pin is still centered even though it is printed
		// resting on the next ring's hole wall
		cube(size=[(or+ring_width+ring_spacing)*2,
                 (or+ring_width+ring_spacing)*2,
           ring_height+(ring_height_step*ring)],
           center=true);
	}
}