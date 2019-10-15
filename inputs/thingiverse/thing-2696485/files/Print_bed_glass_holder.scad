// Print bed glass holder
// (c) 2017 Michael Neuendorf <michael@neuendorf-online.de>

// The gap size in mm. Glass thickness plus convinient space
gap_size = 4;
// The space between slots in mm
void = 15;
// The number of slots
slot_count = 3;

// The width in mm
width = 20;

// Whether screw mounts should applied
screw_mounts = 1; // [0:No, 1:Yes]

/*[Hidden]*/
bottom_thickness = 3;
screw_dia = 3;
screw_driver_dia = 8;

height = gap_size * 2 + bottom_thickness;
length = (slot_count - 1) * void + (slot_count + 2) * gap_size;


holder();

module holder() {
    translate([-width / 2, -length / 2, 0])
    union() {
        difference() {
            cube([width, length, height]);
            
            for (y = [gap_size:void+gap_size:gap_size + (slot_count - 1) * (gap_size + void)]) {
                translate([bottom_thickness, y, bottom_thickness])
                cube([width - bottom_thickness + 0.1, gap_size, height - bottom_thickness + 0.1]);
            }
            
            if ((screw_mounts == 1) && (slot_count > 1)) {
                translate([width / 2, 2* gap_size + void / 2, 0])
                screw_hole();
                
                if (slot_count > 2) {
                    translate([width / 2, length - 2* gap_size - void / 2, 0])
                    screw_hole();
                }
            }
        }
        
        if ((screw_mounts == 1) && (slot_count ==1)) {
            translate([width / 2, 0, 0])
            rotate([0,0,90])
            outer_screw_mount();

            translate([width / 2, length, 0])
            rotate([0,0,-90])
            outer_screw_mount();
        }
    }
}

module outer_screw_mount() {
    difference() {
        union() {
            translate([-screw_driver_dia / 2, 0, 0])
            cylinder(d = screw_driver_dia, h = bottom_thickness, $fn=25);

            translate([-screw_driver_dia / 2, -screw_driver_dia / 2, 0])
            cube([screw_driver_dia / 2, screw_driver_dia, bottom_thickness]);
        }

        translate([-screw_driver_dia / 2, 0, -0.05])
        cylinder(d = screw_dia, h = bottom_thickness+0.1, $fn=25);
    }
    
}

module screw_hole() {
    union() {
        translate([0,0,-0.05])
        cylinder(d = screw_dia, h = bottom_thickness + 0.1, $fn=25);
        translate([0, 0, bottom_thickness])
        cylinder(d = screw_driver_dia, h = height - bottom_thickness + 0.1, $fn=25);
    }
}