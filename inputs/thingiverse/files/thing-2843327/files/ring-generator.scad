// Sets the pahses of the torus (only for round mode)
faces_of_round_shape = 16;
// Height of the cylinder version in mm
height = 5;
// Defines the roundness of the shape
sides_of_roundness = 8;
cylinder_or_round = "round";//[round,cylinder]
// Thickness of the wall in mm
thickness = 1;
// Diameter ofthe hole in mm
diameter = 4;
if (cylinder_or_round == "round") {
  // torus
  rotate_extrude($fn=sides_of_roundness) {
    translate([(diameter + thickness), 0, 0]) {
      circle(r=thickness, $fn=faces_of_round_shape);
    }
  }
} else {
  difference() {
    linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
      {
        $fn=sides_of_roundness;    //set sides to sides_of_roundness
        circle(r=(diameter + thickness));
      }
    }

    linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
      {
        $fn=sides_of_roundness;    //set sides to sides_of_roundness
        circle(r=diameter);
      }
    }
  }
}
