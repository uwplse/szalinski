/*
    This is a simple cap for a rounded pipe. Uses include:
    - capping PVC pipe
    - chair foot
    - cup or bowl
    
    Author: Alex Kazim
*/

/* [Main] */

// diameter of the pipe to cap
inner_diam_top = 25.5;

// top wall thickness
wall_thickness_top = 3;

// diameter of the pipe to cap
inner_diam_base = 25.5;

// thickness at the base
wall_thickness_base = 3;

// height of the cap
height = 20;

// thickness of the floor
floor_thickness = 5;

/* [Hidden] */

$fn = 50;

AKRoundCap(inner_diam_top,wall_thickness_top,inner_diam_base,wall_thickness_base,height,floor_thickness);

// Open-ended round end-cap; some examples:
// - pipe or round shaft
// - chair leg
// - cup or bowl
// 
// idt - inner diameter at top of cap (open-end)
// wtt - wall thickness at top of cap
// idb - inner diameter at base of cap (closed-end)
// wtb - wall thickness at base of cap
// h - z-height of cap
// ft - floor thickness
module AKRoundCap(idt,wtt,idb,wtb,h,ft) {
    outer_radius_base = (idb + wtb)/2;
    outer_radius_top = (idt + wtt)/2;
    
    difference() {
        cylinder(h,outer_radius_base,outer_radius_top);
        translate([0,0,ft]) {
            cylinder(h-ft,idb/2,idt/2);
        }
    }
}
