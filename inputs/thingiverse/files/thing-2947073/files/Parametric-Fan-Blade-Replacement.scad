height = 10.5;
hubInnerDiameter = 25.0;
hubThickness = 1.2;
outerDiameter = 54.0;
bladeThickness = 0.8;
blades = 17;

fan();

module fan() {
    linear_extrude(height=height) union() {
        difference() {
            circle(hubInnerDiameter/2 + hubThickness, $fa=4);
            circle(hubInnerDiameter/2, $fa=4);
        }
        intersection() {
            for (s=[1:blades]) {
                rotate([0, 0, 360/blades * s]) translate([hubInnerDiameter/2 + hubThickness - bladeThickness, 0]) square([bladeThickness, outerDiameter], center=false);
            }
            circle(outerDiameter/2);
        }
    }
}