$fn = 80;

// the overall thickness of the walls
support_thickness = 5;

// the overall width of the holder
support_width = 62;

// the diameber of the screw hol
support_screw_diameter = 4;

// the top diameter of the screw for countersinking
support_screw_diameter_top = 6.5;
support_screw_width = support_width + 10;

// the amount of support for the triangle beneath
support_multiplier = 8;

// the diameter of the spool, leave 2mm extra just for some leeway
spool_diameter = 202;

// the inner diameter of the spool, leave 1mm for leeway
spool_hole = 54.5;

// the thickness of the spool wall
spool_thickness = 4.5;

// the amount of lip to hold the spool wall
spool_lip = 4.5;

module spool() {
    color("green") difference() {
        cylinder(spool_thickness, spool_diameter / 2, spool_diameter / 2, true);
        cylinder(spool_thickness * 2, spool_hole / 2, spool_hole / 2, true);
    }
}

//translate([0, 0, spool_thickness / 2]) spool();

module holder() {
    // main flat part
    hull() {
        translate([0, 0, -support_thickness / 2]) cylinder(support_thickness, support_width / 2, support_width / 2, true);
        translate([0, (spool_diameter / 2) - (support_width / 2) + 5, -support_thickness / 2]) cube([support_width, support_width, support_thickness], true);
    }
    translate([0, 0, -support_thickness / 2 + support_thickness * .75]) cylinder(support_thickness * .75, spool_hole / 2 - 1, (spool_hole / 2 - 1), true);

    difference() {
        translate([0, (spool_diameter / 2) - (support_width / 2) + 5, (support_thickness + spool_thickness) / 2]) cube([support_width, support_width, support_thickness + spool_thickness], true);
        cylinder(50, spool_diameter / 2 - spool_lip, spool_diameter / 2 - spool_lip, true);
        translate([0, 0, spool_thickness / 2]) spool();
    }

    module support_blade() {
        hull() {
            translate([0, 0, -(support_thickness / 2)]) cube([support_thickness, support_thickness, support_thickness], true);
            translate([0, spool_diameter / 2 + 5 / 2, -support_thickness * support_multiplier / 2]) cube([support_thickness, support_thickness, support_thickness * support_multiplier], true);
        }
    }

    support_blade();
}


module mount() {
    difference() {
        union() {
            cube([support_screw_width, support_thickness + spool_thickness + support_thickness, support_thickness], true);
            translate([support_screw_width / 2, 0, 0]) cylinder(support_thickness, (support_thickness + spool_thickness + support_thickness) / 2, (support_thickness + spool_thickness + support_thickness) / 2, true);
            translate([-support_screw_width / 2, 0, 0]) cylinder(support_thickness, (support_thickness + spool_thickness + support_thickness) / 2, (support_thickness + spool_thickness + support_thickness) / 2, true);
        }
        translate([-support_screw_width / 2, 0, 0]) cylinder(support_thickness, support_screw_diameter / 2, support_screw_diameter / 2, true);
        translate([support_screw_width / 2, 0, 0]) cylinder(support_thickness, support_screw_diameter / 2, support_screw_diameter / 2, true);

        translate([-support_screw_width / 2, 0, support_thickness - 3]) cylinder(3, support_screw_diameter / 2, support_screw_diameter_top / 2, true);
        translate([support_screw_width / 2, 0, support_thickness - 3]) cylinder(3, support_screw_diameter / 2, support_screw_diameter_top / 2, true);
    }
}

holder();
//translate([0, support_length / 2 + support_width / 2 + support_thickness / 2, 2.25]) rotate([90, 0, 0]) mount();
translate([0, spool_diameter / 2 + support_thickness / 2, -support_thickness + (support_thickness * 2 + spool_thickness) / 2]) rotate([90, 0, 0]) mount();
