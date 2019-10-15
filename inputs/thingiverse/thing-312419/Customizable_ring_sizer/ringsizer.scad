// This tool allows you to create jewelry-makers' ring sizers in:
//	1) Individual rings
//	2) A single solid set of rings.
//	3) A set of rings split down the middle so people don't get stuck.
//
// This file resides on thingiverse at:
//    ...
//
// Released under BSD(cc) licence:
//    http://opensource.org/licenses/bsd-license.php
//
// Based on OpenSCAD ring sizing script.
// by, Christopher "ScribbleJ" Jansen
// Available from:
//    http://www.thingiverse.com/thing:7210

//CUSTOMIZER VARIABLES

/* [Main] */

// What to create
generate=2; // [0:separate sizing rings,1:combinded ring tool,2:split-apart ring tool that so you don't get stuck]

// The size of the first ring to create
first_ring_size=4;

// How many rings to create
num_rings=5;

// Spacing between ring sizes (eg 0.5 for half sizes, 2 for odd or even sizes only)
ring_size_incriment=2;

/* [Ring Feel] */

// set ring_w to width of ring.
ring_w = 8;

// ring_thick = radius of ring
ring_thick = 2;

/* [Hidden] */

use<write/Write.scad>


// Stolen from Wikipedia.
RING_SIZES = 
[
[0,	11.63],
[1,	12.45],
[2,	13.26],
[3,	14.07],
[4,	14.88],
[5,	15.70],
[6,	16.51],
[7,	17.32],
[8,	18.14],
[9,	18.95],
[10,	19.76],
[11,	20.57],
[12,	21.39],
[13,	22.20],
[14,	23.01],
[15,	23.83],
[16,	24.64]
];
function get_actual_size(s) = lookup(s, RING_SIZES);


// Ring scaling.  Two data points provided by Worksofman.
// 6 = 1 size too small. 
// 15 = 1.25 too small.
// Openscad will interpolate
RING_SCALING =
[
[6, get_actual_size(6) / get_actual_size(5)],
[15, get_actual_size(15) / get_actual_size(13.75)],
];
function get_scaling(s) = lookup(s, RING_SCALING);
function get_size(s) = get_actual_size(s) * get_scaling(s);

if (generate==0)
{
	separate_rings();
}else{
	if(generate==1){
		ring_guage();
	}else{
		ring_gauge_split();
	}
}


module post(){
	translate([0,-2,-ring_w/2]) union() {
		cube([5,2,ring_w]);
		translate([4,-2,0]) cube([2,4,ring_w]);
	}
}

module ring_gauge_split()
{
	max_ring_dia=get_size(first_ring_size+(num_rings*ring_size_incriment));
	difference() {
		ring_guage(posts=true);
		translate([-max_ring_dia,0,-ring_w/2]) cube([max_ring_dia*(num_rings+2),max_ring_dia+ring_thick,ring_w+2]);
}
}


// recursively-generated ring guage
module ring_guage(posts=false,i=0,pos=0) {
	size=first_ring_size+(i*ring_size_incriment);
	if(i==0&&posts){
		translate([-get_size(first_ring_size)/2,0,0]) rotate([0,180,0]) post();
	}
	if(i<num_rings){
		union() {
			translate([pos, 0, 0]) ring(size);
			ring_guage(posts,i+1,pos+get_size(size)+(ring_thick*1.5));
		}
	}else{
		if(posts){
			translate([pos-(get_size(size)/2)-ring_thick,0,0]) post();
		}
	}
}

module separate_rings() {
	rings_per_row=sqrt(num_rings);
	max_ring_dia=get_size(first_ring_size+(num_rings*ring_size_incriment));
	ring_space=max_ring_dia+2;
	row=0;
	col=0;
	for(i = [0:num_rings - 1])
	{
		assign(row = floor(i / rings_per_row)) {
			assign(col  = i % rings_per_row) {
				assign(size=first_ring_size+(i*ring_size_incriment)){
				echo(str("Ring: ", i,
					" Row: ", row, 
					" Col: ", col, 
					" Size: ", size, 
					" ID(ref): ", get_actual_size(size),
					" ID(actual): ", get_size(size)
				));
				translate([ring_space * row, ring_space * col, 0]) ring(size);
}
			}
		}
	}
}

module ring(size = 0)
{
	difference()
	{
		cylinder(h=ring_w, r=(get_size(size)/2) + ring_thick, center=true);
		ringhole(size);
	}

}


module ringhole(size = 0)
{
	polyhole(h=ring_w * 2, d=get_size(size), center=true);
}



// polyhole code from http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(h, d, center=false) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), center=center, $fn = n);
}

