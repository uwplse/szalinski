// Millimeters to enlarge the screw's socket of, AKA "how accurate is your printer?"
margin=0.1; // [0.1, 0.2]
// Do you want a groove in the handle?
shapedHandle=1; // [1:Yes, 0:No]
// How many sides do you want the handle to have?
sides=16; // [3:1:100]

module screw_head() {
    scale([1.15, 1, 1]) cylinder(1, (3.3+margin)/2, (3.3+margin)/2, $fn=100);
}

difference() {
    if (shapedHandle) {
        union() {
            cylinder(15, 4, 4, $fn=sides);
            translate([0, 0, 15]) hull() {
                cylinder(1, 4, 4, $fn=sides);
                translate([0, 0, 5]) cylinder(1, 3.5, 3.5, $fn=sides);
            }
            hull() {
                translate([0, 0, 20]) cylinder(1, 3.5, 3.5, $fn=sides);
                translate([0, 0, 25]) cylinder(1, 4, 4, $fn=sides);
            }
            translate([0, 0, 25]) cylinder(5, 4, 4, $fn=sides);
        }
    } else {
        cylinder(30, 4, 4, $fn=sides);
    }
    translate([0, 0, -1]) scale([1, 1, 4]) screw_head();
}