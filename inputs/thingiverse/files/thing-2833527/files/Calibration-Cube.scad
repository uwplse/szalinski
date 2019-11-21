//!OpenSCAD

Font_thickness = 1;
Font_size = 10;
edge_length = 10;
difference() {
  cube([edge_length, edge_length, edge_length], center=true);

  translate([0, 0, (edge_length / 2 - 1)]){
    // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
    linear_extrude( height=Font_thickness, twist=0, center=false){
      text("Z", font = "Roboto", size = Font_size*0.75, halign="center", valign="center");
    }

  }
  translate([(edge_length / 2 - 1), 0, 0]){
    rotate([90, 0, 90]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=Font_thickness, twist=0, center=false){
        text("X", font = "Roboto", size = Font_size*0.75, halign="center", valign="center");
      }

    }
  }
  translate([0, (edge_length / 2), 0]){
    rotate([90, 0, 0]){
      // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
      linear_extrude( height=Font_thickness, twist=0, center=false){
        text("Y", font = "Roboto", size = Font_size*0.75, halign="center", valign="center");
      }

    }
  }
}