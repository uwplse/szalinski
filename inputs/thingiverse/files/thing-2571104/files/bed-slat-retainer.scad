// Bed slat retainer
// RJL Oct 2017

$fs=0.5+0; // The plus hides from Customizer.
$fa=1+0;
manifold = 0.01+0;

/* [Retainer Values] */
// Width of retainer (exterior).
width = 56.6; 
// Depth, not counting arc area
depth = 24;     
// Dia. of arc of top/bottom; Changing this will require changing chord_offset and vice versa.
arc_diameter = 137; 
// Distance from chord of arc to curve. Use 0 for straight front.
chord_offset = 6.1; 
// Top panel has the pegs (but in use is actually the bottom panel!).
top_panel_thickness = 1; 
bottom_panel_thickness = 1.5;
// Other walls
wall_thickness = 1; 
// Gap where slat goes.
slat_height = 9;    
// Rear hole size, presumably for air escape?
rear_hole = 4.4;    
// Distance between rear hole centres.
rear_hole_centre_distance = 29;     

/* [Pegs} */
// Distance of centre of peg from rear
peg_from_rear = 12;     
// Distance between peg centres.
peg_centre_distance = 36.5;     
peg_main_dia = 6.2;
peg_main_height = 4.5;
peg_cone_top_dia = 3;
peg_cone_bottom_dia = 8.2;
peg_cone_height = 8;
// The compression slot (cutout) in the pegs.
peg_cutout_width = 2;
peg_cutout_height = 4.6;
peg_cutout_offset = 2.5;    // Bottom of cutout above top panel
// -- End of parameters ---
total_height = bottom_panel_thickness+slat_height+top_panel_thickness;
echo ("Total height: ", total_height);

total_depth = depth+chord_offset; // Just for reference; not used in calculations.
echo ("Total depth: ", total_depth);

// Print on edge ("rear wall") with supports (pegs being horizontal), so rotate in slicer (unless bridging works well).

// --- Modules ---

module panel (thickness) {
    difference(){
    translate ([arc_diameter/2, arc_diameter/2, 0]) cylinder(d=arc_diameter, h=thickness);
    translate ([0, chord_offset , -manifold]) cube([arc_diameter, arc_diameter, thickness+manifold*2]);
    }
    translate ([arc_diameter/2-width/2, chord_offset , 0]) cube ([width, depth, thickness]);
}

module peg () {
    
    difference () {
    union() {
    cylinder(d=peg_main_dia, h=peg_main_height);
    translate([0, 0, peg_main_height]) cylinder(d1=peg_cone_bottom_dia, d2=peg_cone_top_dia, h=peg_cone_height);
    }
     translate([-peg_cutout_width/2, -peg_cone_bottom_dia/2, peg_cutout_offset]) cube([peg_cutout_width, peg_cone_bottom_dia, peg_cutout_height]);
  }
}

// --- Execute ---

// Bottom panel
panel(bottom_panel_thickness);

// Top panel
translate([0, 0, bottom_panel_thickness+slat_height]) panel(top_panel_thickness);

// Left wall
translate([arc_diameter/2-width/2, chord_offset, bottom_panel_thickness]) cube ([wall_thickness, depth, slat_height]);

// Right wall
translate([arc_diameter/2+width/2-wall_thickness, chord_offset, bottom_panel_thickness]) cube ([wall_thickness, depth, slat_height]);

// Rear wall
difference() {
translate([arc_diameter/2-width/2, chord_offset+depth-wall_thickness, bottom_panel_thickness]) cube ([width, wall_thickness, slat_height]);
//  Rear holes
translate([ arc_diameter/2-rear_hole/2-rear_hole_centre_distance/2, chord_offset+depth-wall_thickness, total_height/2-rear_hole/2]) cube([rear_hole, wall_thickness*2,rear_hole]);
translate([ arc_diameter/2-rear_hole/2+rear_hole_centre_distance/2, chord_offset+depth-wall_thickness, total_height/2-rear_hole/2]) cube([rear_hole, wall_thickness*2,rear_hole]);
}

translate([arc_diameter/2-peg_centre_distance/2, chord_offset+depth-peg_from_rear, total_height]) peg();
translate([arc_diameter/2+peg_centre_distance/2, chord_offset+depth-peg_from_rear, total_height]) peg();

