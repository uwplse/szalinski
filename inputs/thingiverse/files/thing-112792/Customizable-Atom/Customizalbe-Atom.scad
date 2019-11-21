/* [Atom] */

// The number of electrons
number_of_electrons=79; // [1:120]

// The width of each ring
ring_width=5; // [3:20]

// The space between each ring
ring_spacing=2; // [.5:8]

// The Height of the center ring
ring_height=6; // [6:100]

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

max_electrons_on_ring1=2;
max_electrons_on_ring2=8;
max_electrons_on_ring3=18;
max_electrons_on_ring4=32;
max_electrons_on_ring5=50;
max_electrons_on_ring6=72;
max_electrons_on_ring7=98;

electrons_on_ring1=(min(max_electrons_on_ring1,number_of_electrons));
remaining_electrons_after_ring1=number_of_electrons-electrons_on_ring1;

electrons_on_ring2=(min(max_electrons_on_ring2,remaining_electrons_after_ring1));
remaining_electrons_after_ring2=remaining_electrons_after_ring1-electrons_on_ring2;

electrons_on_ring3=(min(max_electrons_on_ring3,remaining_electrons_after_ring2));
remaining_electrons_after_ring3=remaining_electrons_after_ring2-electrons_on_ring3;

electrons_on_ring4=(min(max_electrons_on_ring4,remaining_electrons_after_ring3));
remaining_electrons_after_ring4=remaining_electrons_after_ring3-electrons_on_ring4;

electrons_on_ring5=(min(max_electrons_on_ring5,remaining_electrons_after_ring4));
remaining_electrons_after_ring5=remaining_electrons_after_ring4-electrons_on_ring5;

electrons_on_ring6=(min(max_electrons_on_ring6,remaining_electrons_after_ring5));
remaining_electrons_after_ring6=remaining_electrons_after_ring5-electrons_on_ring6;

electrons_on_ring7=(min(max_electrons_on_ring7,remaining_electrons_after_ring6));
number_of_remaining_electrons=remaining_electrons_after_ring6-electrons_on_ring7;

number_of_rings=sign(electrons_on_ring1)+sign(electrons_on_ring2)+sign(electrons_on_ring3)+sign(electrons_on_ring4)+sign(electrons_on_ring5)+sign(electrons_on_ring6)+sign(electrons_on_ring7);

//debug
echo(number_of_rings);

//debug
echo(remaining_electrons_after_ring1, remaining_electrons_after_ring2, remaining_electrons_after_ring3, remaining_electrons_after_ring4, remaining_electrons_after_ring5, remaining_electrons_after_ring6);
echo(electrons_on_ring1, electrons_on_ring2, electrons_on_ring3, electrons_on_ring4, electrons_on_ring5, electrons_on_ring6, electrons_on_ring7);

// translate everything so that it rests on z=0
// and loop over all rings
translate(v=[0, 0, ring_height*.5]) union()
for (ring = [0 : number_of_rings-1]) assign(
	ir=center_radius+(ring_width+ring_spacing)*ring,
	or=center_radius+(ring_width+ring_spacing)*(ring+1)-ring_spacing,
	odd=(ring%2), even=((ring+1)%2)) {

drwaw_electrons(or, ir, ring_height, ring_height_step, ring, ring_width);

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


module drwaw_electrons(or, ir, ring_height, ring_height_step, ring, ring_width)
{
echo("Ring ", ring);
echo(ring_height+(ring_height_step*ring));
if (ring==0 && (electrons_on_ring1>0))
for (electron = [1 : electrons_on_ring1])
	rotate(a=360/electrons_on_ring1*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==1 && (electrons_on_ring2>0))
for (electron = [1 : electrons_on_ring2])
	rotate(a=360/electrons_on_ring2*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==2 && (electrons_on_ring3>0))
for (electron = [1 : electrons_on_ring3])
	rotate(a=360/electrons_on_ring3*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==3 && (electrons_on_ring4>0))
for (electron = [1 : electrons_on_ring4])
	rotate(a=360/electrons_on_ring4*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==4 && (electrons_on_ring5>0))
for (electron = [1 : electrons_on_ring5])
	rotate(a=360/electrons_on_ring5*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==5 && (electrons_on_ring6>0))
for (electron = [1 : electrons_on_ring6])
	rotate(a=360/electrons_on_ring6*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}

if (ring==6 && (electrons_on_ring7>0))
	for (electron = [1 : electrons_on_ring7])
	rotate(a=360/electrons_on_ring7*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2)-0.5, center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([ring_width,ring_width,ring_width]);
				}
}

