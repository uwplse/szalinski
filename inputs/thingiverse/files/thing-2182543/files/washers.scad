/* Dimensions */

OuterDiameter = 12;
InnerDiameter = 7;

ThicknessStart = 5;
ThicknessIncrement = 1;

WasherRows = 5;

/* [Hidden] */
outer = OuterDiameter/2;
inner = InnerDiameter/2;

strip_height = 0.6;
strip_width = 2;
strip_overlap = 0.5;

$fn = 40; // Smoothness

module washer (height) {
    difference() {
        cylinder(height,outer,outer);
        translate([0,0,-1]) cylinder(height+2,inner,inner);
    }
}

module double_washer(height) {
    translate ([-outer - strip_width/2, 0, 0])
        washer(height);
    translate ([outer + strip_width/2 , 0, 0])
        washer(height);
}

for (i=[0:WasherRows-1]) {
    translate ([0, (outer*2*i)+1*i, 0])
        double_washer(ThicknessStart + ThicknessIncrement * i);
}

translate ([-strip_width/2 - strip_overlap/2,0,0]) {
    cube([strip_width + strip_overlap,
        (OuterDiameter * (WasherRows - 1) + (WasherRows - 1 * 1)) ,
        strip_height]);
}