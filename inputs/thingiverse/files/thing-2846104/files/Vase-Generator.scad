
scale_X_direction = 1;
scale_Y_direction = 1;
// height of the Vase in mm
height = 100;
// Defines the angle of the twist
twist = 150;
// The more sides, the rounder your Vase is.
Base_sides_number = 10;
// Radiusof the vase
radius = 40;

linear_extrude( height=height, twist=twist, scale=[scale_X_direction, scale_Y_direction], center=false){
  {
    $fn=Base_sides_number;    //set sides to Base_sides_number
    circle(r=radius);
  }
}