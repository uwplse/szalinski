// Width of extrusion beams
customizer_extrusion_w = 20;
// Width of channel in extrusion. Set to 0 to disable guides.
customizer_channel_w = 5;
// Number of holes of the base (the side with the guides the full length)
customizer_base_holes = 2;
// Number of holes of the riser (the side with partial length guides)
customizer_riser_holes = 2;
// Radius of mounting holes
customizer_hole_r = 2.25;
// Enable T bracket mode
customizer_t_bracket = 0; // [0,1]
// Thickness of the solid section of the bracket
thickness = 3;

module trapezoid(width_base, width_top,height,thickness) {

  linear_extrude(height = thickness) polygon(points=[[0,0],[width_base,0],[width_base-(width_base-width_top)/2,height],[(width_base-width_top)/2,height]], paths=[[0,1,2,3]]); 
  
}
        
// extrusion_w: Wide of extrusion pieces
// channel_w: Width of the extrusion's channel (guide will slope from this size to 80% of this size and be 40% of this size tall)
// base_holes: Number of mounting holes on the base (the side where the channel goes the entire length of the side)
// riser_holes: Number of mounting holes on the riser
// hole_r: Size of mounting holes
// corner_r: Corner rounding. Defaults to 25% extrusion width. 0 < corner_r <= 0.5 * extrusion_width
module l_bracket(extrusion_w, channel_w, base_holes, riser_holes, hole_r, corner_r = 0) {
    side_slope = 1.5;
    corner_r = corner_r <= 0 ? 0.2 * extrusion_w : corner_r > extrusion_w / 2 ? extrusion_w / 2 : corner_r;
    difference() {
        union() {
            hull() {
                perim_r1 = max(corner_r - side_slope, 0);
                // Origin corner
                translate([corner_r, corner_r, 0]) cylinder(r1=perim_r1, r2=corner_r, h=thickness, $fn=16);
                // Bottom right corner
                translate([(extrusion_w * base_holes) - corner_r, corner_r, 0]) cylinder(r1=perim_r1, r2=corner_r, h=thickness, $fn=16);
                // Top of base
                translate([(extrusion_w * base_holes) - corner_r, extrusion_w - corner_r, 0]) cylinder(r1=perim_r1, r2=corner_r, h=thickness, $fn=16);
                // Side of riser
                translate([corner_r, (extrusion_w * riser_holes) - corner_r + extrusion_w, 0]) cylinder(r1=perim_r1, r2=corner_r, h=thickness, $fn=16);
                // Top left corner
                translate([extrusion_w - corner_r, (extrusion_w * riser_holes) - corner_r + extrusion_w, 0]) cylinder(r1=perim_r1, r2=corner_r, h=thickness, $fn=16);
            }
            
            if (channel_w > 0)
            {
                translate([1, extrusion_w / 2 - channel_w / 2, thickness]) rotate([90, 0, 90]) trapezoid(channel_w, channel_w * 0.8, channel_w * 0.4, extrusion_w * base_holes - 2);
                translate([extrusion_w * 0.5 + channel_w * 0.5, extrusion_w * 1.1, thickness]) rotate([0, 90, 0]) rotate([0, 90, 90]) trapezoid(channel_w, channel_w * 0.8, channel_w * 0.4, extrusion_w * riser_holes - (extrusion_w * 0.1) - 1);
            }
        }
        for(i=[extrusion_w * 1.5:extrusion_w:extrusion_w * (0.5 + riser_holes)]) {
            translate([extrusion_w / 2, i, -1]) cylinder(r=hole_r, h=thickness + channel_w + 2, $fn=16);
            translate([extrusion_w / 2, i, thickness]) cylinder(r1=hole_r, r2 = hole_r * 1.5, h=channel_w * 0.5, $fn=16);
            translate([extrusion_w / 2, i, -1]) cylinder(r1=hole_r * 1.5, r2 = hole_r, h=1.5, $fn=16);
        }
        for(i=[extrusion_w/2:extrusion_w:extrusion_w * (0.5 + base_holes)]) {
            translate([i, extrusion_w / 2, -1]) cylinder(r=hole_r, h=thickness + channel_w + 2, $fn=16);
            translate([i, extrusion_w / 2, thickness]) cylinder(r1=hole_r, r2 = hole_r * 1.5, h=channel_w * 0.5, $fn=16);
            translate([i, extrusion_w / 2, -1]) cylinder(r1=hole_r * 1.5, r2 = hole_r, h=1.5, $fn=16);
        }

    }
}

// Cheap and dirty T bracket by mirroring and overlaying a pair of L brackets :)
module t_bracket(extrusion_w, channel_w, base_holes, riser_holes, hole_r, corner_r = 0) {
    l_bracket(extrusion_w, channel_w, base_holes, riser_holes, hole_r, corner_r);
    translate([extrusion_w, 0, 0]) mirror([1, 0, 0]) l_bracket(extrusion_w, channel_w, base_holes, riser_holes, hole_r, corner_r);
}

if (customizer_t_bracket > 0)
    t_bracket(customizer_extrusion_w, customizer_channel_w, customizer_base_holes, customizer_riser_holes, customizer_hole_r);
else
    l_bracket(customizer_extrusion_w, customizer_channel_w, customizer_base_holes, customizer_riser_holes, customizer_hole_r);