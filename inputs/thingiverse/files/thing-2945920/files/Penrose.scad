//Choose which Rhombus you want
rhombus_angle=36; // [36,72]
//Height of the thicker part of the cutter.
handle_height=2;
//Height of the thinner part of the cutter.
cutter_height=10;
//thickness of the thicker part.
handle_thickness=2;
//thickness of the thinner part.
cutter_thickness=1;
//Length of each side in mm.
side_len=40;

module offset_shell(thickness = 0.5) {
  translate([0,0,thickness])
    difference() {
      render() {
        minkowski() {
          children();
          cube([2 * thickness, 2 * thickness, 2 * thickness], center=true);
        }
      }
      translate([0, 0, -5 * thickness]) scale([1, 1, 100])
        children();
    }
}
module rhombus(angle, r=1){
        coords = [[0,r*cos(angle/2)],
                  [r*sin(angle/2),0],
                  [0,-r*cos(angle/2)],
                  [-r*sin(angle/2),0]];
        polygon(coords);
 }

module make_cutter(angle=36,thickness=1,height=1,side_len=1) {
offset_shell(thickness)
  linear_extrude(height=height)
    rhombus(angle,side_len);
}

translate([0,0,0])
  make_cutter(rhombus_angle,handle_thickness,handle_height,side_len);
translate([0,0,handle_height])
  make_cutter(rhombus_angle,cutter_thickness,cutter_height,side_len);