$fn =500;
Diameter_in_Millimeters=100;
difference() {
translate([0, 6, 0]) { cube([100, 20, 50], center=true); }
translate([-51,Diameter_in_Millimeters-2,0]) { rotate([0, 90, 0]) { cylinder(h = 102, r = Diameter_in_Millimeters); } }
}