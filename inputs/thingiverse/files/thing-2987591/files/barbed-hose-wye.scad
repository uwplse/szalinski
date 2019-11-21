// Barbed hose Wye.

// Subfaces per curved surface
$fn = 90;


// Barb sizes are based upon the measured hose I.D.
hose_id = 15;

// Wall thickness of the main body.
wall_thickness = 1.31;
// Extra mm per side for the barbs.
barb_wall_thickness = 1;

barb_spacing = 6;
barb_section_length = 30;

union() {
    translate([0, 0, -barb_section_length * 1.25]) barb();
    rotate([40, 0, 0]) mirror([0, 0, 1]) translate([0, 0, -barb_section_length * 1.5]) barb();
    rotate([-40, 0, 0]) mirror([0, 0, 1]) translate([0, 0, -barb_section_length* 1.5]) barb();

    // Center Portion
    difference() {
        hull() {
            translate([0, 0, (-barb_section_length * 1.25) + barb_section_length])
                cylinder(d = hose_id + 0.25, h = 0.1);
            rotate([40, 0, 0]) 
                mirror([0, 0, 1]) 
                    translate([0, 0, (-barb_section_length * 1.5) + barb_section_length]) 
                        cylinder(d = hose_id + 0.25, h = 0.1);
            rotate([-40, 0, 0]) 
                mirror([0, 0, 1]) 
                    translate([0, 0, (-barb_section_length * 1.5) + barb_section_length]) 
                        cylinder(d = hose_id + 0.25, h = 0.1);
        }
        hull() {
            translate([0, 0, (-barb_section_length * 1.25) + barb_section_length])
                cylinder(r = (hose_id / 2) - wall_thickness, h = 0.1);
            rotate([40, 0, 0]) 
                mirror([0, 0, 1]) 
                    translate([0, 0, (-barb_section_length * 1.5) + barb_section_length]) 
                        cylinder(r = (hose_id / 2) - wall_thickness, h = 0.1);
        }
        hull() {
            translate([0, 0, (-barb_section_length * 1.25) + barb_section_length])
                cylinder(r = (hose_id / 2) - wall_thickness, h = 0.1);
            rotate([-40, 0, 0]) 
                mirror([0, 0, 1]) 
                    translate([0, 0, (-barb_section_length * 1.5) + barb_section_length]) 
                        cylinder(r = (hose_id / 2) - wall_thickness, h = 0.1);
        }
        // Cleanup entry points.
        translate([0, 0, (-barb_section_length * 1.25) + barb_section_length - 0.1])
            cylinder(r = (hose_id / 2) - wall_thickness, h = 0.2);
        rotate([40, 0, 0]) 
            mirror([0, 0, 1]) 
                translate([0, 0, (-barb_section_length * 1.5) + barb_section_length - 0.1]) 
                    cylinder(r = (hose_id / 2) - wall_thickness, h = 0.2);
        rotate([-40, 0, 0]) 
            mirror([0, 0, 1]) 
                translate([0, 0, (-barb_section_length * 1.5) + barb_section_length - 0.1]) 
                    cylinder(r = (hose_id / 2) - wall_thickness, h = 0.2);
    }
}



module barb() {
    difference() {
        union() {
            for (i = [0 : 1 : ((barb_section_length - 10) / barb_spacing) - 1] ){
                translate([0, 0, 5 + (i * barb_spacing)]) 
                    cylinder(d1 = hose_id - .25, d2 = hose_id + (2 * barb_wall_thickness), h = barb_spacing);
            }
            cylinder(d1 = hose_id - 1, d2 = hose_id, h = 1);
            translate([0, 0, 1]) cylinder(d = hose_id, h = barb_section_length - 1);
        }
        cylinder(r = (hose_id / 2) - wall_thickness, h = barb_section_length);
    }
}