adapter_length = 30;
hole_depth = 10;
hole_wall_thickness = 2;
// outer diameter of plug across the flats: 5/16 * 25.4
plug_od = 7.9375; 
// diameter of hole across the flats: 1/4 * 25.4
hole_diameter = 6.35; 
clearance = 0.1;

difference() {
  union() {
    cylinder(h=adapter_length, r=plug_od/sqrt(3) - clearance, $fn = 6);
    cylinder(h=hole_depth + hole_wall_thickness, r=hole_diameter/sqrt(3) + clearance + hole_wall_thickness, $fn = 6);
  }
  translate([0, 0, -clearance]) cylinder(h=hole_depth + 2*clearance, r=hole_diameter/sqrt(3) + clearance, $fn = 6);
}
