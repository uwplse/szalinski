// Text on your sign
Text = "© Universal Maker";
// Thickness of theplastic in your sign(in mm)
Thickness = 2;
// width of the sign in mm
width = 70;
// heigth of the sign in mm
height = 30;
// Angle (be careful with angles over 45 degrees !!!
Angle = 20;
// height of the font in mm
Font_height = 8;
// thickness of the font in mm
Font_thickness = 1.5;
difference() {
  union(){
    rotate([0, (Angle * -1), 0]){
      union(){
        cube([Thickness, width, height], center=false);
        translate([2, (width / 2), (height / 2)]){
          rotate([90, 0, 90]){
            // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
            linear_extrude( height=Font_thickness, twist=0, center=false){
              text(str(Text), font = "Roboto", size = Font_height*0.75, halign="center", valign="center");
            }

          }
        }
      }
    }
    translate([((cos((90 - Angle)) * height) * -2), 0, 0]){
      rotate([0, Angle, 0]){
        cube([Thickness, width, height], center=false);
      }
    }
  }

  cube([1000, 1000, 1.5], center=true);
}