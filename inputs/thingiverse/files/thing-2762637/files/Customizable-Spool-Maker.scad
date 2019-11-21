/***********************
 * Editable Parameters *
 ***********************/
// Resolution of all the Cylinders In this project
fragments = 256;
// Diameter of main disk
disk_diameter = 110;
// Height of main disk
disk_height = 2;
// Diameter of very inner hole
inner_diameter = 32;
// Width of inner hole
inner_width = 3;
// Width of outer hole
outer_width = 3;
// Hole diameter for filamet on the main disk
outer_hole_diameter = 3;
// Dole diameter for filament on the outside inner hole
inner_hole_diameter = 2;
// Height of innter holes
inner_height = 25;
// Fin width, (width of area between outer and inner holes)
fin_width = 4;

/****************************
 * Helpful Pre Calculations *
 ****************************/
outer_diameter = inner_diameter + inner_width + (fin_width * 2);

module make_filament_holes(ta, tb, tz, h, d) {
    translate([ta, tb, tz]) cylinder(h=h, d=d, $fn=fragments);
    translate([-ta, tb, tz]) cylinder(h=h, d=d, $fn=fragments);

    translate([ta, -tb, tz]) cylinder(h=h, d=d, $fn=fragments);
    translate([-ta, -tb, tz]) cylinder(h=h, d=d, $fn=fragments);

    translate([tb, ta, tz]) cylinder(h=h, d=d, $fn=fragments);
    translate([tb, -ta, tz]) cylinder(h=h, d=d, $fn=fragments);

    translate([-tb, ta, tz]) cylinder(h=h, d=d, $fn=fragments);
    translate([-tb, -ta, tz]) cylinder(h=h, d=d, $fn=fragments);
}    

module make_inner_filament_holes(ta, h, d) {
    offseta = 3;
    offsetb = 2;
    nudgea = 3.5;
    nudgeb = 2.5;
    translate([ta - nudgeb, 0, disk_height + offseta])
        rotate([0, 90, 0])
            cylinder(h=h, d=d, $fn=fragments);
    
    translate([-ta - nudgea, 0, disk_height + offseta])
        rotate([0, 90, 0])
            cylinder(h=h, d=d, $fn=fragments);
    
    translate([0, -ta + nudgeb, disk_height + offsetb])
        rotate([90, 0, 0])
            cylinder(h=h, d=d, $fn=fragments);
    
    translate([0, ta + nudgea, disk_height + offsetb])
        rotate([90, 0, 0])
            cylinder(h=h, d=d, $fn=fragments);
}

module make_fins(ta, tb, tz, x, y, z) {
    anglea = 22.5;
    angleb = 67.5;
    rotate([0, 0, anglea]) translate([0,ta, tz]) cube([x, y, z]);
    rotate([0, 0, anglea]) translate([0,tb, tz]) cube([x, y, z]);
    rotate([0, 0, anglea]) translate([ta,0, tz]) cube([y, x, z]);
    rotate([0, 0, anglea]) translate([tb,0, tz]) cube([y, x, z]);

    rotate([0, 0, angleb]) translate([0,ta, tz]) cube([x, y, z]);
    rotate([0, 0, angleb]) translate([0,tb, tz]) cube([x, y, z]);
    rotate([0, 0, angleb]) translate([ta,0, tz]) cube([y, x, z]);
    rotate([0, 0, angleb]) translate([tb,0, tz]) cube([y, x, z]);
}

// Main Thing
difference() {
    union() {
        // Main Disk
        cylinder(h=disk_height, d=disk_diameter, $fn=fragments);
        // Outer Inside Cylinder
        translate([0, 0, disk_height])
            cylinder(h=inner_height, d=outer_diameter + outer_width, $fn=fragments);
    }
    // Outer Inside Cylinder Cutout
    translate([0, 0, -1])
        cylinder(h=inner_height + disk_height + 2, d=outer_diameter, $fn=fragments);

    // Outer filament holes
    make_filament_holes(
        4,
        (disk_diameter / 2) - 5,
        -1,
        4,
        outer_hole_diameter
    );
    
    // Inner filament holes
    make_inner_filament_holes(outer_diameter / 2, outer_width + 2, inner_hole_diameter);
}

difference() {
    // Inner Cylinder
    cylinder(h=inner_height + disk_height, d=inner_diameter + inner_width, $fn=fragments);
    // Inner Cylinder Cutout
    translate([0, 0, -1])
        cylinder(h=inner_height + disk_height + 2, d=inner_diameter, $fn=fragments);
}

// Fins
make_fins(
    (inner_diameter + inner_width) / 2,
    -(((inner_diameter + inner_width) / 2) + fin_width),
    0,
    1,
    fin_width,
    inner_height + disk_height
);