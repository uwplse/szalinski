//!OpenSCAD
/*
>>> made by UniversalMaker
*/
// thickness of the wall in mm
Material_thickness = 1;
// top part width of the key in mm
key_handle_width = 10;
// top part height of the key in mm
key_handle_height = 2;
// top part length of the key in mm
key_handle_length = 10;
// drilling hole diameter in mm
hole_diameter = 1;
// position of the hole in mm
hole_x_position = 0;
// position of the hole in mm
hole_y_position = 3;

difference() {
  linear_extrude( height=key_handle_width, twist=0, scale=[1, 1], center=false){
    difference() {
      square([(key_handle_length + Material_thickness), (key_handle_height + Material_thickness)], center=true);

      square([key_handle_length, key_handle_height], center=true);
    }
  }

  translate([hole_x_position, 50, hole_y_position]){
    {
      $fn=40;    //set sides to 40
      rotate([90, 0, 0]){
        cylinder(r1=hole_diameter/2, r2=hole_diameter/2, h=100, center=false);
      }
    }
  }
}