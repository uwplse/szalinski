// Determines how edgy the roundings are
roundness_of_Torous_cross_section = 10;
// determinestheroundnessofthe cricle(10 is the best value because there could be some problems at bottom part if you have that)
Edges_of_rounding = 50;
// Pencil diameter in mm
Diameter_of_pencils = 8;
// Angle of the pencils pointing out in degrees
Angle_of_pencils = 30;
/*[Bottom]*/
// Do you wnat to have a a bottom inside the ring)
Bottom = "yes";//[yes,no]
// Thickness of the bottom  in mm (if it is enabled)
Thickness_of_the_bottom = 0;
/*[advanced]*/
// Thickness of the round part in mm
Thickness = 20;
// Diameter of the round part in mm
Diameter = 50;
// Number of wished pencils
number_of_pencils = 20;
/*[Hidden]*/
difference() {
  // torus
  rotate_extrude($fn=Edges_of_rounding) {
    translate([Diameter, 0, 0]) {
      circle(r=Thickness, $fn=roundness_of_Torous_cross_section);
    }
  }

  for (i = [0 : abs(360 / number_of_pencils) : 360]) {
    rotate([0, 0, i]){
      translate([Diameter, 0, 0]){
        rotate([0, Angle_of_pencils, 0]){
          cylinder(r1=Diameter_of_pencils, r2=8, h=100, center=false);
        }
      }
    }
  }

}
if (Bottom == "yes") {
  translate([0, 0, (Thickness * -1)]){
    cylinder(r1=Diameter, r2=10, h=1, center=false);
  }
}
