/* Customizable sieve by DrLex, based on Sieve (or Seive?) by pcstru (thing:341357).
 * Released under Creative Commons - Attribution - Share Alike license */

shape = "round"; // [round,square]

// All dimensions are in millimeters. For square shape, this is the length of one side.
outer_diameter = 40;

// Width of the filter wires. You shouldn't try to go below your nozzle diameter, although it might work within certain limits.
strand_width = .4;

// Thickness (height) of the filter wires. If 'Offset strands' is enabled, the filter grid will be twice this thick.
strand_thickness = .4;

// Spacing between filter wires, i.e. hole size.
gap_size = .8;

// Thickness (width) of the outer rim.
rim_thickness = 1.7;

// Height of the outer rim.
rim_height = 3;

// If yes, the wires will be placed in different layers, which leads to a quicker and possibly better print, especially when using thin strands.
offset_strands = "yes"; // [yes,no]

// For most accurate results with thin strands, set this to your first layer height. This will ensure the strands only start printing from the second layer, avoiding any problems due to the first layer being squished, or using a wider extrusion, etc.
lift_strands = 0;

// Number of segments for round shape, low values can be used to obtain polygons that fit inside a circle of the specified outer diameter. For instance, 3 yields a triangle.
$fn = 50;

/* [Hidden] */

// A hollow tube
module tube(orad,irad,height) {
    if(shape == "round") {
        difference() {
          cylinder( r=orad,h=height);
          translate([0,0,-1]) cylinder( r=irad,h=height+2);
        }
    } else {
        translate([0,0,height/2]) {
            difference() {
              cube([2*orad,2*orad,height], center=true);
              translate([0,0,-1]) cube([2*irad,2*irad,height+4], center=true);
            }
        }
    }
}

// Grid
module grid(width,length,strand_width,strand_thick, gap,do_offset) {

   wh = width / 2;
   lh = length / 2;
   // Let's enforce symmetry just for the heck of it
   wh_align = (strand_width + gap) * floor(wh/(strand_width + gap)) + strand_width + gap/2;
   lh_align = (strand_width + gap) * floor(lh/(strand_width + gap)) + strand_width + gap/2;

   for ( ix = [-wh_align:strand_width+gap:wh_align]) {
	translate([-lh,ix,0]) cube([length,strand_width,strand_thick]) ;
   }

   for ( iy = [-lh_align:strand_width+gap:lh_align]) {
	if (do_offset=="yes") {
		translate([iy,-wh,strand_thick]) cube([strand_width,width,strand_thick]) ;
	} else {
		translate([iy,-wh,0]) cube([strand_width,width,strand_thick]) ;
	}
   }
}

// Outer ring
module ring(or, rim_thick, rim_height, sieve_thick) {
	tube(or,or-rim_thick+.4,sieve_thick);
	translate([0, 0, sieve_thick]) tube(or,or-rim_thick,rim_height-sieve_thick);
}

// Module  : Sieve
// Params :
// 	od = Outer Dia of the cylinder
// 	strand = thickness of grid strands
// 	gap = gap between strands
// 	rim_thick=thickness of outer rim
// 	rim_height=height of outer rim
// 	do_offset=offset the strands ("yes" or "no")
//
module sieve(od,strand_width,strand_thick,gap,rim_thick,rim_height,do_offset) {
	
	or=od/2;
	
    // Add .01 margin to ensure good overlap, avoid non-manifold
    if(lift_strands > 0) {
        tube(or, or-rim_thick, lift_strands+.01);
    }
    translate([0, 0, lift_strands]) {
        difference() {
            grid(od,od,strand_width,strand_thick, gap,do_offset);
            translate([0,0,-1]) tube(od*2,or-.1,rim_height+2);
        }
        if(do_offset == "yes") {
            translate([0, 0, 2*strand_thick-.01]) tube(or, or-rim_thick, rim_height-2*strand_thick-lift_strands+.01);
        } else {
            translate([0, 0, strand_thick-.01]) tube(or, or-rim_thick, rim_height-strand_thick-lift_strands+.01);
        }
    }
    tube(or, or-rim_thick+.4, rim_height);
}

// Ensure rim has correct thickness, even for low $fn values
rim_corrected = (shape == "round" ? rim_thickness / sin(90 - 180/$fn) : rim_thickness);
sieve(outer_diameter, strand_width, strand_thickness, gap_size, rim_corrected, rim_height, offset_strands);
