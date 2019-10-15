/* [Default values] */
// Line segments for circles
FN = 100; // [1:1:360]
// Unit size (mm)
U = 44.45;
// Horizontal pitch size (mm)
HP = 5.07; // 5.07 for a little bit of margin

$fn=FN;

/* [Panel] */
// Height of module (mm) - Would not change this if you are using Eurorack
height = 128.5; // A little less then 3U
// Thickness of module (mm) - Would not change this if you are using Eurorack
thickness = 2;  // Website specifies a thickness of 2mm
// Width of module (HP)
width = 8; // [1:1:84]

/* [Holes] */
// Four hole threshold (HP)
four_hole_threshold = 10;
// Center two holes
two_holes_type = "opposite"; // [center, opposite, mirror]
// Hole radius (mm)
hole_r = 1.7;
// Hole distance from the side (HP)
hole_dist_side = hp_mm(1.5);
// Hole distance from the top (mm)
hole_dist_top = 2.5;

panel(width);


// h[p]
module panel(h) {
    width_mm = hp_mm(h);
    difference() {
        cube(size = [width_mm, height, thickness]);
        
        if (h < four_hole_threshold) {
            if (two_holes_type == "center") {
                translate([width_mm/2, hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2);
           
                translate([width_mm/2, height-hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2); 
            } else if (two_holes_type == "opposite") {
                translate([hole_dist_side, hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2);
           
                translate([width_mm - hole_dist_side, height-hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2); 
            } else if (two_holes_type == "mirror") {
                translate([hole_dist_side, hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2);
           
                translate([hole_dist_side, height-hole_dist_top, -1])
                cylinder(r=hole_r, h=thickness*2); 
            }
        } else {
            translate([hole_dist_side, hole_dist_top, -1])
            cylinder(r=hole_r, h=thickness*2);
           
            translate([hole_dist_side, height - hole_dist_top, -1])
            cylinder(r=hole_r, h=thickness*2);
            
            translate([width_mm - hole_dist_side, hole_dist_top, -1])
            cylinder(r=hole_r, h=thickness*2);
           
            translate([width_mm - hole_dist_side, height - hole_dist_top, -1])
            cylinder(r=hole_r, h=thickness*2); 
        }
    }
}

// http://www.rean-connectors.com/en/products/din-chassis-connectors/nys325
module nys325_midi_socket() {
    cylinder(r=7.55, h=thickness*2);
    translate([0, 11.3, -1])
    cylinder(r=1.6, h=thickness*2);
    translate([0, -11.3, -1])
    cylinder(r=1.6, h=thickness*2);
}

module audio_jack_3_5mm() {
    cylinder(r=3, h=thickness*2);
}

module toggle_switch_6_8mm() {
    cylinder(r=3.4, h=thickness*2);
}
// http://www.mouser.com/ds/2/414/Datasheet_RotaryPanelPot_P160series-1133272.pdf
module pot_p160() {
    cylinder(r=3.75, h=thickness*2);
    translate([7.8, 0, -1])
    cylinder(r=1.5, h=thickness*2);
}

// https://www.elfa.se/Web/Downloads/_t/ds/els-511sygwa-s530-e1_eng_tds.pdf
module x1_7seg_14_22mm_display() {
    cube([12.25, 19.25, thickness]);
}

module x2_7seg_14_22mm_display() {
    cube([25, 19.25, thickness]);
}

// https://www.elfa.se/Web/Downloads/2e/wa/qmCC56-12EWA.pdf
module x4_7seg_14_22mm_display() {
    cube([50.5, 19.25, thickness]);
}

// https://cdn.sparkfun.com/datasheets/Components/Switches/MX%20Series.pdf
module cherry_mx_button() {
	union(){
		cube([14,14,thickness]);

		translate([-1,1,0])
		cube([14+2*1,thickness,thickness]);

		translate([-1,14-1-3,0])
		cube([14+2*1,3,thickness]);
	}
}
// 1U  = 1.75" = 44.45mm
// 1HP = 1/5"  = 5.08mm

// u[nits]
function units_mm(u) = u * U; 

// h[p]
function hp_mm(h) = h * HP; 