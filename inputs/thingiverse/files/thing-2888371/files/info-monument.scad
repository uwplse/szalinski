//!OpenSCAD

width = 45;
depth = 30;
height = 30;
cutter_cube_angle = 40;
lower_cutter_cube_offset = 20;
my_1_line_font_size = 20;
my_1_line_text = "UM";
my_2_line_font_size = 5;
my_2_line_text = "Universal Maker";

union(){
  difference() {
    cube([width, depth, height], center=false);

    rotate([cutter_cube_angle, 0, 0]){
      translate([0, lower_cutter_cube_offset, (-1000 - lower_cutter_cube_offset)]){
        cube([1000, 1000, 1000], center=false);
      }
    }
    rotate([cutter_cube_angle, 0, 0]){
      translate([0, 0, (height / 4)]){
        cube([1000, 1000, 1000], center=false);
      }
    }
  }
  rotate([cutter_cube_angle, 0, 0]){
    translate([(width / 2 - len(my_1_line_text) * 9), 20, 7]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=2, twist=0, center=false){
        text(str(my_1_line_text), font = "Roboto", size = my_1_line_font_size*0.75);
      }

    }
  }
  rotate([cutter_cube_angle, 0, 0]){
    translate([5, 10, 7]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=2, twist=0, center=false){
        text(str(my_2_line_text), font = "Roboto", size = my_2_line_font_size*0.75);
      }

    }
  }
}