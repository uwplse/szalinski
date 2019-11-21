// Customizable PCB foot
// All units in mm

screw_diameter = 3.97;
screw_height = 3.5;
// Must be >= that the screw diameter
base_top_diameter = 7;
// Must be >= that the top diameter
base_bottom_diameter = 15;
base_height = 10;
make_cap = "yes"; // [yes,no]
// Must be < than the screw height
cap_height = 3;
// Must be >= that the base bottom diameter
cap_displacement = 20;

translate([0,0,base_height]) {
  cylinder(h=screw_height, d1=screw_diameter, d2=screw_diameter);
  translate([0,0,-base_height])
    cylinder(h=base_height, d1=base_bottom_diameter, d2=base_top_diameter);
}

if (make_cap == "yes") {
  translate([cap_displacement,0,0])
    difference() {
      cylinder(h=cap_height, d1=base_top_diameter, d2=base_top_diameter);
      translate([0,0,1])
        cylinder(h=screw_height, d1=screw_diameter, d2=screw_diameter);
    }
}
