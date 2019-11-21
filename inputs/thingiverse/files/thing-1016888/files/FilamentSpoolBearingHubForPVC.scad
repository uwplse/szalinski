// Units are in mm.

// The overall size of the hub flange.
flange_diameter = 60;
// The size of the PVC pipe going through the hub.  This is tHe perfect size for 3/4" PVC.  It will bend a little and your bushings may be a little loose so there is no need to add tolerance here unless your PVC is actually a different size.  Measure it.  It will fail if you don't have it just right.
pvc_diameter = 26.6;    
// The size of the hole in the center of the hub.  It must be larger than the rod going through it.
center_hole_diameter = 32;    
// The size of the bushing.  This should be the EXACT size of the hole in your spool. The default should fit spools from MonoPrice.com
bushing_diameter = 38;
// The size of your bearing.  This is the correct value for a 608 skate bearing.
bearing_diameter = 22;
// The inner diameter of your bearing.  This is the correct value for a #6 screw which is what I use.  For a 608 bearing, 8 is the maximum.
bearing_screw_diameter = 4;
// The diameter of the head or washer of your bearing screw. Give yourself a little extra room.
bearing_screw_head_diameter = 11;
// Indicates whether to apply cutouts to save material when printing.  
use_cutouts = 1; // [0:No,1:Yes]
// The thickness of the flange.
thickness = 2;
// The length of the bushing; how far it extends into the spool.
bushing_height = 12;
//bushing_height = 1;
//bushing_height = thickness * 3;
// If the cutouts cut too far into the center, use this to move the cutouts.
cutout_position_offset = 15;
// If the cutouts are too small, use this to enlarge them.  Adjusting the cutouts allows you to minimize printing material.
cutout_size_offset = 10;

// Higher resolution rendering for cleaner holes.  40 is good.
$fn = 40;


bushing_thickness = bushing_diameter - pvc_diameter;
// Something wrong with OpenSCAD.NET.  Assigning a variable to itself or roundtrip will give it a strange value and breaks things.
//c = (bushing_height == 1) ? thickness * 3 : bushing_height;
//c = bushing_height ;
//bushing_height = c;

function bearing_screw_offset() = pvc_diameter/2 + bearing_diameter/2;
function bearing_screw_head_clearance_hole_height() = bushing_height;
function bearing_screw_head_clearance_hole_zoffset() = bearing_screw_head_clearance_hole_height() + thickness / 2;


difference () {
    union() {
        // Plate
        cylinder(r = flange_diameter/2, h = thickness, center = true);
        // Spool bushing
//        translate ([0, 0, (bushing_height - thickness) / 2]) cylinder(r = pvc_diameter/2 + bushing_thickness, h = bushing_height, center = true);
        translate ([0, 0, (bushing_height - thickness) / 2]) cylinder(r = (pvc_diameter + bushing_thickness) / 2, h = bushing_height, center = true);
    }      
    // Hub inner hole
    //cylinder(r = pvc_diameter/2, h = bushing_height * 10, center = true);
    cylinder(r = center_hole_diameter/2, h = bushing_height * 10, center = true);

    // Larger cutouts, for saving material (optional).
    if (use_cutouts) {
        rotate ([0, 0, 0]) translate ([flange_diameter/2 + cutout_position_offset, 0, 0]) cylinder(r = flange_diameter/4 + cutout_size_offset, h = thickness * 100 + 2, center = true);
        rotate ([0, 0, 120]) translate ([flange_diameter/2 + cutout_position_offset, 0, 0]) cylinder(r = flange_diameter/4 + cutout_size_offset, h = thickness * 100 + 2, center = true);
        rotate ([0, 0, 240]) translate ([flange_diameter/2 + cutout_position_offset, 0, 0]) cylinder(r = flange_diameter/4 + cutout_size_offset, h = thickness * 100 + 2, center = true);
    }
    // Smaller holes, for bearing screws.
    rotate([0, 0, 60+0]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, 0]) cylinder(r = bearing_screw_diameter/2, h = thickness + 2, center = true);
    rotate([0, 0, 60+120]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, 0]) cylinder(r = bearing_screw_diameter/2, h = thickness + 2, center = true);
    rotate([0, 0, 60+240]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, 0]) cylinder(r = bearing_screw_diameter/2, h = thickness + 2, center = true);


    // Holes for clearing bearing screw heads.
//    rotate([0, 0, 60+0]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, (thickness + 2) * 10 / 2 + thickness / 2]) cylinder(r = bearing_screw_head_diameter/2, h = (thickness + 2) * 10, center = true);
//    rotate([0, 0, 60+120]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, thickness * 2]) cylinder(r = bearing_screw_head_diameter/2, h = (thickness + 2) * 10, center = true);
//    rotate([0, 0, 60+240]) translate ([pvc_diameter/2 + bearing_diameter/2, 0, thickness * 4]) cylinder(r = bearing_screw_head_diameter/2, h = (thickness + 2) * 10, center = true);

    rotate([0, 0, 60+0]) translate ([bearing_screw_offset(), 0,bearing_screw_head_clearance_hole_zoffset()]) cylinder(r = bearing_screw_head_diameter/2, h = bearing_screw_head_clearance_hole_height() * 2, center = true);
    rotate([0, 0, 60+120]) translate ([bearing_screw_offset(), 0, bearing_screw_head_clearance_hole_zoffset()]) cylinder(r = bearing_screw_head_diameter/2, h = bearing_screw_head_clearance_hole_height() * 2, center = true);
    rotate([0, 0, 60+240]) translate ([bearing_screw_offset(), 0, bearing_screw_head_clearance_hole_zoffset()]) cylinder(r = bearing_screw_head_diameter/2, h = bearing_screw_head_clearance_hole_height() * 2, center = true);

}
