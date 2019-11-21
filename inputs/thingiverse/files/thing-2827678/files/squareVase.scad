//!OpenSCAD

height = 40;
scale_X = 1;
scale_Y = 1;
twist_angle = 90;
Base_square_X = 15;
Base_square_Y = 10;
color([0.2,0.2,1]) {
  linear_extrude( height=height, twist=twist_angle, scale=[scale_X, scale_Y], center=false){
    square([Base_square_X, Base_square_Y], center=true);
  }
}