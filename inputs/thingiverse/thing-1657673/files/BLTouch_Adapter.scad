// Horizontal offset
horizontalOffset = 6; // [0:5]

// Vertical offset
verticalOffset = 10; // [0:50]

// Base cylinder height
baseHeight = 1; // [1, 2, 3]

// Hole diameter
holeDiameter = 2.5; // [3]

difference() {
    hull() {
        cylinder(baseHeight, 3.5, 3.5, $fn=50);
        translate([horizontalOffset, 0, verticalOffset]) cylinder(baseHeight, 3.5, 3.5, $fn=50);
    }
    translate([0, 0, -1]) cylinder(55, holeDiameter/2, holeDiameter/2, $fn=50);
    translate([horizontalOffset, 0, -1]) cylinder(55, holeDiameter/2, holeDiameter/2, $fn=50);
}