//
// Customized Enclosure
//

/*[Dimensions]*/

// Width of the enclosure
width = 120.0;
// Height of the enclosure
height = 72.0;
// Depth of the enclosure
depth = 20.0;
// Thickness of the walls and lid
thickness = 1.5;
// Amount of corner rounding
fillet_radius = 5.0;

// 
// builds a solid rectangle with rounded corners (Z-only)
//
module block(width, height, depth, fillet_radius) {
    
    difference() {
        cube([width, height, depth], center = true);
        
        fudge = 0.1;
        fudge_depth = depth + 1.0;
        
        translate([-(width / 2), -(height / 2), -(fudge_depth / 2)])
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

module lid(width, height, fillet_radius, thickness) {
    translate([0.0, height + 10, thickness / 2.0])
        block(width, height, thickness, fillet_radius);
}

enclosure(width, height, depth, fillet_radius, thickness);
lid(width, height, fillet_radius, thickness);
