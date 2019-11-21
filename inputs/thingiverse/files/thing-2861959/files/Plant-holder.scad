//!OpenSCAD

stick_length = 150;
Grabber_length = 5;
stick_side_length = 3;
grabber_diameter = 10;
Opening_diameter = 4;
plastk_thickness = 2;
union(){
  linear_extrude( height=Grabber_length, twist=0, scale=[1, 1], center=false){
    difference() {
      circle(r=((grabber_diameter + plastk_thickness) / 2));

      circle(r=(grabber_diameter / 2));
      translate([(Opening_diameter / -2), -1000, 0]){
        square([Opening_diameter, 1000], center=false);
      }
    }
  }
  linear_extrude( height=stick_length, twist=0, scale=[1, 1], center=false){
    translate([0, ((grabber_diameter / 2 + plastk_thickness) + (stick_side_length / 2 - plastk_thickness)), 0]){
      square([stick_side_length, stick_side_length], center=true);
    }
  }
}