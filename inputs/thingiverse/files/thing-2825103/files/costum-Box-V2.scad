
With_a_top = "yes";//[yes,no]
// in mm
width = 20;
// in mm
height = 20;
// in mm
depth = 20;
// in mm
wall_thickness = 1;
/* [advanced] */
Printer_accuracy = 0.2;
/* [Hidden] */
if (With_a_top == "yes") {
  union(){
    translate([(width + 5), 0, wall_thickness]){
      // Parametric box
      // change the numbers in the variable blocks to change the dimensions of the box and the wall thickness.
      difference() {
        cube([((width + wall_thickness * 2) + Printer_accuracy), ((depth + wall_thickness * 2) + Printer_accuracy), (height + wall_thickness * 1)], center=true);

        translate([0, 0, wall_thickness]){
          cube([(((width + wall_thickness * 2) + Printer_accuracy) - 2 * wall_thickness), (((depth + wall_thickness * 2) + Printer_accuracy) - 2 * wall_thickness), (height + wall_thickness)], center=true);
        }
      }
    }
    // Parametric box
    // change the numbers in the variable blocks to change the dimensions of the box and the wall thickness.
    difference() {
      cube([width, depth, height], center=true);

      translate([0, 0, wall_thickness]){
        cube([(width - 2 * wall_thickness), (depth - 2 * wall_thickness), height], center=true);
      }
    }
  }
} else {
  // Parametric box
  // change the numbers in the variable blocks to change the dimensions of the box and the wall thickness.
  difference() {
    cube([width, depth, height], center=true);

    translate([0, 0, wall_thickness]){
      cube([(width - 2 * wall_thickness), (depth - 2 * wall_thickness), height], center=true);
    }
  }
}
