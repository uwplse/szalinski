myInitials = "MAK";

union() {
    translate([0,1,0])linear_extrude(1) {
        text(myInitials,$fn=32);
    };
    difference() {
        translate([0,0,-1])cube([40,12,1]);
        translate([36,6,-2])cylinder(r=2,h=5,$fn=32);
    };
};