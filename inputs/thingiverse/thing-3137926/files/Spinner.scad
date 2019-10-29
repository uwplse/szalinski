// The quality of the rings
$fn = 50;
// The tolerance of the bearing size (make it higher if the bearings don't fit and lower if they fall out) (default = 0.3)
Tolerance = 0.3;
// How many bearings you want to have around the inner bearing
BearingAmount = 8;
// How long you want the arms to be
ArmLength = 34; //[100]
// How thick you want the arms to be
ArmThickness = 2; //[5]
// How much space should there be between arms
LengthBetweenArms = 4; //[24]
// The height of your bearings
BearingHeight = 7 + Tolerance;
// The radius of your bearings
BearingRadius = 11 + Tolerance/2;
// The thickness of the walls around the bearing
HolderThickness = 3; // [15]

difference() {
    cylinder(BearingHeight, r = BearingRadius+HolderThickness, true);
    translate([0, 0, -0.001])
    cylinder(BearingHeight+0.002, r = BearingRadius, true);
}
difference() {
for (i = [1: BearingAmount]) {
        rotate([0, 0, (360/BearingAmount) * i]) {
            translate([ArmLength, 0, 0]) {
                difference() {
                    cylinder(BearingHeight, r = BearingRadius+HolderThickness, true);
                    translate([0, 0, -0.001])
                    cylinder(BearingHeight+0.002, r = BearingRadius, true);
                }
            }
        difference() {
            translate([0, -(ArmThickness/2), 0]) {
                    translate([0, LengthBetweenArms/2])
                    cube([ArmLength, ArmThickness, BearingHeight]);
                    translate([0, -LengthBetweenArms/2])
                    cube([ArmLength, ArmThickness, BearingHeight]);
            }
            translate([ArmLength, 0, -0.001])
                cylinder(BearingHeight+0.002, r = BearingRadius, true);
        }
    }
}
    translate([0, 0, -0.001])
    cylinder(BearingHeight+0.002, r = BearingRadius, true);
}