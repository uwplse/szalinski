$fn=50*1;
E=0.05*1;

// Diameter of the disc as a whole
disc_dia = 40;

// How thick the disc as a whole is (mm)
disc_thickness=2;

// Diameter of the shaft passing through the disc (possibly plus some margin, e.g. ~5%)
shaft_dia = 6.4;

// Which side to put the indents for the magnets? The top is the side with the collar.
magnet_indent_side = 1; // [1:Top, 0:Bottom]

// Diameter of the magnets (plus some margin, usualy ~10%)
magnet_dia = 5.5; 

// Depth of the magnet indents (mm)
magnet_depth = 0.5;

// How far between the edge of the disc and the edge of the magnets (mm)
magnet_margin = 2;

// Number of magnet indents
num_magnets = 8;

// How thick the collar should be (mm)
collar_thickness = 0.75;

// How long the collar should be (mm)
collar_length=5;



magnet_center_radius = disc_dia/2 - magnet_margin - magnet_dia/2;


difference() {
    union() {
        cylinder(d=disc_dia,h=disc_thickness);
        cylinder(d=shaft_dia+2*collar_thickness,h=disc_thickness+collar_length);
    }
    translate([0,0,-E]) cylinder(d=shaft_dia,h=20);
    for (theta = [0:360/num_magnets:360-1]) rotate(theta) {
        magnet_z = magnet_indent_side ? disc_thickness-magnet_depth : -E/2;
        translate([magnet_center_radius,0,magnet_z]) cylinder(d=magnet_dia,h=magnet_depth+E);
    }
}
    