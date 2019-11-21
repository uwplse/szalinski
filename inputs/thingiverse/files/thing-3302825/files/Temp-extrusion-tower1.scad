// You have to set the correct temperature in the GCode!!!
Side_Length = 20;
Temp_extrusion_multiplier_1 = 190;
Temp_extrusion_multiplier_2 = 195;
Temp_extrusion_multiplier_3 = 200;
Temp_extrusion_multiplier_4 = 210;
Temp_extrusion_multiplier_5 = 220;

module do_something(x) {
  union(){
    difference() {
      union(){
        difference() {
          cube([Side_Length, Side_Length, Side_Length], center=true);

          cube([(Side_Length - 2), (Side_Length - 2), 1000], center=true);
        }
        translate([(Side_Length / 2), 0, 0]){
          rotate([90, 0, 90]){
            // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
            linear_extrude( height=2, twist=0, center=false){
              text(str(x), font = "Roboto", size = 10*0.75, halign="center", valign="center");
            }

          }
        }
      }

      translate([(Side_Length / -3), 0, 0]){
        rotate([0, 90, 0]){
          cylinder(r1=(Side_Length / 3), r2=(Side_Length / 3), h=20, center=true);
        }
      }
      rotate([90, 0, 0]){
        cube([(Side_Length / 1.5), (Side_Length / 1.5), 100], center=true);
      }
    }
    translate([0, 0, (Side_Length / 2)]){
      cube([Side_Length, Side_Length, 2], center=true);
    }
  }
}


union(){
  translate([0, 0, Side_Length]){
    do_something(Temp_extrusion_multiplier_1);
  }
  translate([0, 0, (Side_Length * 2)]){
    do_something(Temp_extrusion_multiplier_2);
  }
  translate([0, 0, (Side_Length * 3)]){
    do_something(Temp_extrusion_multiplier_3);
  }
  translate([0, 0, (Side_Length * 4)]){
    do_something(Temp_extrusion_multiplier_4);
  }
  translate([0, 0, (Side_Length * 5)]){
    do_something(Temp_extrusion_multiplier_5);
  }
}