// Switch between render mode and preview.
view_mode = "Preview"; // [Preview,Render]
// Quality of curved surfaces.
quality = 70; // [10:10:200]

/* [Fan Dimensions] */

// The size of the fan to fit on.
fan_size = 80;
// Diameter of the screw holes.
hole_size = 4.5; // [1:0.1:10]
// Spacing between the center of each hole in an adjacent pair.
hole_spacing = 71.5;

/* [Shroud Dimensions] */

// Height of the shroud.
shroud_height = 40;
// Angle of the shroud cutoff.
shroud_angle = 22.5; // [0:0.5:45]
// Shroud offset from the front edge of the base.
shroud_offset = 10;
// Enable or disable the brace under the dome.
enable_brace = "Yes"; // [Yes,No]
// Wall thickness.
shroud_thickness = 3; // [1:0.5:5]

/* [Hidden] */

$fn = quality;

// Turn Yes and No into booleans.
shroud_brace = enable_brace == "Yes" ? true : false;

// Make four cylinders.
module cylinders(xyz, r, center=false) {
    translate(center ? -[xyz[0] / 2, xyz[1] / 2, xyz[2] / 2] : []) union() {
        translate([r,          r,          0]) cylinder(h=xyz[2], r=r);
        translate([r,          xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, r,          0]) cylinder(h=xyz[2], r=r);
        translate([xyz[0] - r, xyz[1] - r, 0]) cylinder(h=xyz[2], r=r);
    }
}

// Make a cube with four rounded sides.
module roundcube(xyz, r, center=false) {
    hull() cylinders(xyz, r, center);
}

// Make the shroud, cylinder + sphere.
module shroud(size, center=false) {
    sphere(d=size, center=true);
    cylinder(d=size, h=size / 2);
}

// Full shroud with base, holes, and fillets.
module print_shroud() {
    difference() {
        // Full shroud with base.
        union() {
            // Angle cut shroud shell.
            translate([fan_size / 2 - shroud_offset, 0, 0]) difference() {
                // Completed shroud shell with the brace.
                translate([shroud_offset - fan_size / 2, 0, 0]) rotate([0, 90]) union() {
                    // Shroud shell.
                    difference() {
                        // Larger exterior shape.
                        resize([shroud_height * 2, fan_size, fan_size]) shroud(fan_size, center=true);

                        // Smaller, scaled down, shape.
                        resize([shroud_height * 2 - shroud_thickness * 2, fan_size - shroud_thickness * 2, fan_size - shroud_thickness * 2])
                            shroud(fan_size - shroud_thickness * 2, center=true);
                    }

                    // Cylinder and cube to make the middle brace.
                    resize([shroud_height * 2 - shroud_thickness, shroud_thickness, fan_size - shroud_thickness])
                    if (shroud_brace) rotate([90]) {
                        cylinder(d=fan_size, h=shroud_thickness, center=true);
                        translate([0, fan_size / 4, 0]) cube([fan_size, fan_size / 2, shroud_thickness], center=true);
                    }
                }
                // Trim off bottom.
                translate([shroud_offset - fan_size / 2, 0, -shroud_height * 2 / 4 - shroud_thickness])
                    cube(size=[fan_size + 2,  fan_size + 2, shroud_height * 2 / 2], center=true);

                // Offset block.
                translate([fan_size / 2, 0, fan_size / 4]) cube([fan_size, fan_size, fan_size / 2], center=true);

                // Angle block.
                rotate([0, -shroud_angle]) translate([fan_size / 2, 0, shroud_height * 2 / 2])
                    cube([fan_size, fan_size, shroud_height * 2], center=true);
            }

            // Full base with hole. Must be done twice because of the preview clipping issues.
            translate([0, 0, -shroud_thickness / 2]) difference() {
                cube([fan_size, fan_size, shroud_thickness], center=true);
                cylinder(d=fan_size - shroud_thickness * 2, h=shroud_thickness + 2, center=true);
            }
        }

        // Clean off the bottom of the sphere inside the hole.
        translate([0, 0, -shroud_thickness / 2 - 1]) difference() {
            cylinder(d=fan_size - shroud_thickness * 2, h=shroud_thickness + 2, center=true);
            cube([fan_size, shroud_thickness, shroud_thickness + 2], center=true);
        }

        // Cylinders for holes.
        translate([0, 0, shroud_height * 2 / 2 - shroud_thickness])
            cylinders([hole_spacing + hole_size, hole_spacing + hole_size, shroud_height * 2 + 2], r=hole_size / 2, center=true);

        // Fillet box.
        translate([0, 0, shroud_height * 2 / 2 - shroud_thickness]) difference() {
            cube([fan_size + 2, fan_size + 2, shroud_height * 2 + 2], center=true);
            roundcube([fan_size, fan_size, shroud_height * 2 + 2], (fan_size - hole_spacing) / 2, center=true);
        }
    }
}

// If preview is off, render the whole thing.
if (view_mode == "Render") render() print_shroud(); else print_shroud();
