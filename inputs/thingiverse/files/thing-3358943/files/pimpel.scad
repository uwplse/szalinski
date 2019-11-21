car_len=65;
car_wid=30;
car_h=15;
axle_wid=10;
axle_correction=0.26;
seat_widx=14;
seat_widy=12;
tolerance=0.25;

$fn=32;


module peg(rotation) {
  rotate([-90,rotation,0]) {
  sphere(5);
  c=6; 
  translate([0,0,-21])
    cylinder(r=c, h=15, $fn=3);
  translate([0,0,-6])
    linear_extrude(height=6, scale=0.1)
      circle(r=c,  $fn=3);
/*  mirror([0,0,1])
    linear_extrude(height=5, scale=0.1)
      circle(r=c,  $fn=3);*/
}}

rotate([90,0,0])
peg();