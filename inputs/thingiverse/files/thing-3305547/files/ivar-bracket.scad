// Ikea Ivar brackets
// to add additional horizontals into uprights e.g. as bookends

// settable parameters

// slot width (9 results in cup side-walls 3mm thick)
width=9;

// depth of slot below bottom edge of holes in uprights
// slot depth (32 puts bottom of bracket flush with bottom of shelf)
depth=32;
// note that bracket itself will extend from 5mm above bottom edge of holes
// to 3mm below the bottom of the slot, i.e. the bracket total height is 8mm
// greater than the dimension specified here

// bracket projection at top - just set for desired aesthetics
proj_t=10;

// bracket projection at bottom
proj_b=10;

// proj_t & proj_b uploaded to thingiverse: 10/20 & 10/10

// label will be embossed into concealed face of back-plane
label="v1.2.4 - 32";

// heght of label text
lbl_size=5;

// non-settable parameters:
// peg size is hard-coded 6mm diameter 22mm long (holes are 26mm deep)
// back-plane thickness is hard-coded at 3mm outside and 2mm inside teh slot
// so wood piece 430mm long for 50cm shelves and 230mm long for 30cm shelves 
// cup corners all filleted 2mm radius
// cup base 3mm thick
// text is embossed 1mm deep



// set default circle refinement
$fn=16;



difference(){
    union(){
    // mounting pegs are 6mm diameter and 22mm long
	// to avoid steep overhangs 1mm is trimmed off
	translate([-13,-2,2]) rotate([-90,0,0]) cylinder(24,3,3);
	translate([13,-2,2]) rotate([-90,0,0]) cylinder(24,3,3);
	// wood piece cup
        hull(){
	    // top back
            translate([-7.5,-1,0]) cube([15,1,1]);
	    // bottom back
            translate([-5.5,0,depth+6]) rotate([90,0,0]) cylinder(1,2,2);
            translate([5.5,0,depth+6]) rotate([90,0,0]) cylinder(1,2,2);
	    // bottom outer
	    translate([-5.5,2-proj_b,depth+6]) sphere(2);
	    translate([5.5,2-proj_b,depth+6]) sphere(2);
	    // top outer
	    translate([-5.5,2-proj_t,0]) cylinder(1,2,2);
	    translate([5.5,2-proj_t,0]) cylinder(1,2,2);
	    }
	// back plane
        hull(){
	    // top back
            translate([-13,0,2]) rotate([90,0,0]) cylinder(3,3,3);
            translate([13,0,2]) rotate([90,0,0]) cylinder(3,3,3);
	    // bottom back is up to 16 below peg
	    dd = depth>14 ? 19 : depth+5;
            translate([-7.5,-3,dd]) cube([15,3,1]);
	}
    }

    // trim projection below z=0 plane
    translate([-100,-100,-20]) cube([200,200,20]);

    // cutout for wood piece
    translate([-width/2,-52,-1]) cube([width,50,depth+6]);

    // emboss label text
    translate([0,-1,2]) rotate([-90,-90,0]) linear_extrude(2)
        text(label, size=lbl_size, halign="left", valign="center");

}
