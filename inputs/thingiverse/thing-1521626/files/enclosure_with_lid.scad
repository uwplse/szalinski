//
// Customized Enclosure
//

/*[Dimensions]*/

// Width of the enclosure
width = 100.0;
// Height of the enclosure
height = 50.0;
// Depth of the enclosure
depth = 20.0;
// Thickness of the walls and lid
thickness = 1.5;
// Amount of corner rounding
fillet_radius = 5.0;

/* [Lid] */

// Lid Type
lid_type = "Partial"; //[None, Simple, Partial, Full]
// Width of partial lip
lip_width = 4;
// Additional height added to lip
lip_added_height = 1;
// Extra Lid spacing
lid_space = 1;


if (lid_type == "None") {
    enclosure(width, height, depth, fillet_radius, thickness);
}
if (lid_type == "Simple") {
    enclosure(width, height, depth, fillet_radius, thickness);
    simple_lid(width, height, fillet_radius, thickness);
}
if (lid_type == "Partial") {
    enclosure(width, height, depth, fillet_radius, thickness);
    partial_lip_lid(width, height, fillet_radius, thickness);
}
if (lid_type == "Full") {
    enclosure(width, height, depth, fillet_radius, thickness);
    full_lip_lid(width, height, fillet_radius, thickness);
}

// 
// builds a solid rectangle with rounded corners (Z-only)
//
module block(width, height, depth, fillet_radius) {
    
    difference() {
        cube([width, height, depth], center = true);
        
        fudge = 0.1;
        fudge_depth = depth + 1.0;
        
        translate([-(width / 2 + fudge), -(height / 2 + fudge), -(fudge_depth / 2)])
        intersection () {
            cube([fillet_radius, fillet_radius, fudge_depth], center = false); 
            difference() {
                    cube([2 * fillet_radius, 2 * fillet_radius, fudge_depth], center = false); 
                    translate([fillet_radius, fillet_radius, 0.0])
                    cylinder(r = fillet_radius, h = fudge_depth);
            }
        }

        translate([-(width / 2 + fudge), (height / 2 + fudge), -(fudge_depth / 2)])
        rotate([0.0, 0.0, -90])
        intersection () {
            cube([fillet_radius, fillet_radius, fudge_depth], center = false); 
            difference() {
                    cube([2 * fillet_radius, 2 * fillet_radius, fudge_depth], center = false); 
                    translate([fillet_radius, fillet_radius, 0.0])
                    cylinder(r = fillet_radius, h = fudge_depth);
            }
        }

        translate([(width / 2 + fudge), (height / 2 + fudge), -(fudge_depth / 2)])
        rotate([0.0, 0.0, 180])
        intersection () {
            cube([fillet_radius, fillet_radius, fudge_depth], center = false); 
            difference() {
                    cube([2 * fillet_radius, 2 * fillet_radius, fudge_depth], center = false); 
                    translate([fillet_radius, fillet_radius, 0.0])
                    cylinder(r = fillet_radius, h = fudge_depth);
            }
        }

        translate([(width / 2 + fudge), -(height / 2 + fudge), -(fudge_depth / 2)])
        rotate([0.0, 0.0, 90])
        intersection () {
            cube([fillet_radius, fillet_radius, fudge_depth], center = false); 
            difference() {
                    cube([2 * fillet_radius, 2 * fillet_radius, fudge_depth], center = false); 
                    translate([fillet_radius, fillet_radius, 0.0])
                    cylinder(r = fillet_radius, h = fudge_depth);
            }
        }
    }
}

module enclosure(width, height, depth, fillet_radius, thickness) {
    translate([0.0, 0.0, depth / 2.0])
    difference() {
        block(width, height, depth, fillet_radius);
        translate([0.0, 0.0, thickness]) 
            block(width - (2 * thickness), height - (2 * thickness), depth - thickness, fillet_radius);
    }
}

module simple_lid(width, height, fillet_radius, thickness) {
    translate([0.0, height + 10, thickness / 2.0])
        block(width, height, thickness, fillet_radius);
}

module partial_lip_lid(width, height, fillet_radius, thickness) {
    difference() {
        union() {
            translate([0.0, height + 10, thickness / 2.0])
                block(width, height, thickness, fillet_radius);
            translate([0.0, height + 10, thickness / 2.0 + thickness])
                block(width - (2 * thickness) - lid_space, height - (2 * thickness) - lid_space, thickness + lip_added_height, fillet_radius);
        }
        translate([0.0, height + 10, thickness / 2.0 + thickness + 1])
            block((width - (2 * thickness)) - lip_width, (height - (2 * thickness)) - lip_width, thickness + lip_added_height, fillet_radius );
    }
}

module full_lip_lid(width, height, fillet_radius, thickness) {
    union() {
        translate([0.0, height + 10, thickness / 2.0])
            block(width, height, thickness, fillet_radius);
        translate([0.0, height + 10, thickness / 2.0 + thickness])
            block(width - (2 * thickness) - lid_space, height - (2 * thickness) - lid_space, thickness + lip_added_height, fillet_radius);
    }
}
