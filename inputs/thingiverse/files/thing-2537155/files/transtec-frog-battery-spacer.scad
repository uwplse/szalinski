// The height of the spacer
height = 2.5; // [2.5:0.5:5]

// Through-hole or retained by screws?
retain = 1; // [0:Through-hole, 1:Retained]

module screw_hole_big() {
    cylinder(d=7, h=2+height, $fn=50);
}

module screw_hole_small() {
    cylinder(d=3.5, h=2+height, $fn=50);
}

difference() {
    hole_height = retain ? 0.6 : -1;
    cube([40, 40, height], center=false);
    {
        translate([4.75, 35.25, hole_height]) screw_hole_big();
        translate([35.25, 35.25, hole_height]) screw_hole_big();
        translate([35.25, 4.75, hole_height]) screw_hole_big();
        translate([4.75, 4.75, hole_height]) screw_hole_big();
    }
    if (retain) {
        translate([4.75, 35.25, -1]) screw_hole_small();
        translate([35.25, 35.25, -1]) screw_hole_small();
        translate([35.25, 4.75, -1]) screw_hole_small();
        translate([4.75, 4.75, -1]) screw_hole_small();
    }
};
