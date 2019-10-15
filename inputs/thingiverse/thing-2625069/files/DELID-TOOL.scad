// View the tool base, cover, or both.
part = "cover"; // [base:Base Only,cover:Cover Only,assembly:Full Assembly,both:Base and Cover]

print_part();

/* [CPU Dimensions] */

// Total width of the CPU's PCB.
cpu_width = 45;
// Total depth of the CPU's PCB.
cpu_depth = 42.5;
// Total height of the entire CPU (including the IHS).
cpu_height = 4.6;

// Total height of just the PCB.
pcb_height = 1.6;
// Height of the lip (thin base) of the IHS.
lip_height = 1.1;
// Depth of the lip (thin base) on the IHS.
lip_depth = 2.1;
// Cutout width for the middle of some new lake-generation processors.
lip_cutout = 0;

/* [Box Margins] */

// Margin on the X sides of the tool.
width_margin = 5; // [2:1:10]
box_width = cpu_width + width_margin * 2;
// Margin on the Y sides of the tool.
depth_margin = 5; // [2:1:10]
box_depth = cpu_depth + depth_margin * 3;
// Margin on the top and bottom of the tool.
height_margin = 5; // [2:1:10]
box_height = cpu_height + height_margin * 2;
// Clearance for the components on the bottom of the CPU.
bottom_clearance = 2; // [1:0.2:3]
// Margin to the sides of the components on the bottom of the CPU.
bottom_margin = 20; //[2:1:10]

/* [Hidden] */

// Resolution quality of the curves and fillets.
$fn = 30;

cover_height = cpu_height - pcb_height;
fillet_radius = (height_margin + depth_margin) / 4;

// Make a cube with four rounded sides.
module roundcube(xyz, r, center=false) {
    translate(center ? -[xyz[0] / 2, xyz[1] / 2, xyz[2] / 2] : []) hull() {
        translate([r,          r,          0]) cylinder(h=xyz[2], r=r);
        translate([r,          xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, r,          0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
    }
}

// Total geometry of the tool base.
module print_base() {
    difference() {
        // The main cube to cut from.
        rotate([90]) roundcube([box_width, box_height, box_depth], fillet_radius, center=true);

        // Large section on top, half cube.
        translate([0, depth_margin / 2 + 0.5, box_height / 4 + 0.5])
            cube([cpu_width, cpu_depth + depth_margin * 2 + 1, box_height / 2 + 1], center=true);

        // PCB cutout.
        translate([0, depth_margin / 2, -pcb_height / 2 + 0.5])
            cube([cpu_width, cpu_depth, pcb_height + 1], center=true);

        // Bottom components clearance.
        translate([0, depth_margin / 2, -pcb_height / 2 - bottom_clearance / 2 + 0.5])
            cube([cpu_width - bottom_margin * 2, cpu_depth - bottom_margin * 2, bottom_clearance + 1], center=true);
    }
}

// Total geometry of the tool cover.
module print_cover() {
    // translate([0, -depth_margin])
    union() {
        // Round cube for the front part.
        translate([0, box_depth / 2 + depth_margin / 2]) rotate([90])
            roundcube([box_width, box_height, depth_margin], fillet_radius, center=true);

        difference() {
            // Filleted cube for the part pressuring the IHS.
            translate([0, box_depth / 2 - depth_margin * 1.5 - lip_depth / 2, -cover_height]) hull() {
                translate([ cpu_width / 2 - cover_height, 0, 0]) rotate([90])
                    cylinder(r=cover_height, h=depth_margin * 3 + lip_depth, center=true);
                translate([-cpu_width / 2 + cover_height, 0, 0]) rotate([90])
                    cylinder(r=cover_height, h=depth_margin * 3 + lip_depth, center=true);
            }

            // Cutout for the IHS lip.
            translate([0, -lip_depth / 2 + box_depth / 2 - depth_margin * 3 - 0.5, -lip_height / 2 + 0.5])
                cube([cpu_width, lip_depth + 1, lip_height + 1], center=true);

            // Cutout in the middle for some newer processors.
            translate([0, -lip_depth / 2 + box_depth / 2 - depth_margin * 3 - 0.5, -cover_height / 2 + 0.5])
                cube([lip_cutout, lip_depth + 1, cover_height + 1], center=true);
        }

        // Main top part of the cover.
        translate([0, depth_margin / 2, -box_height / 4 - cover_height / 2])
            cube([cpu_width, box_depth - depth_margin, box_height / 2 - cover_height], center=true);
    }
}

// Select the part to calculate by the part variable.
module print_part() {
    if (part == "base") { // View tool base.
        print_base();
    } else if (part == "cover") { // View tool cover.
        print_cover();
    } else if (part == "assembly") { // View tool assembly.
        color([1, 1, 0, 0.5]) translate([0, -depth_margin / 2]) print_base();
        color([0, 1, 1, 0.5]) translate([0,  depth_margin / 2]) rotate([0, 180]) print_cover();
    } else { // View tool spread out, printable form. Includes both option.
        translate([-box_width / 2 - 5, 0 / 2, 0]) print_base();
        translate([ box_width / 2 + 5, 0,     0]) print_cover();
    }
}
