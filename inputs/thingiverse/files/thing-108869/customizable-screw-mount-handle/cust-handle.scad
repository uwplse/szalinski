bottom_width=13;
bottom_radius=2;
top_width=22;
top_radius=5;
height=65;
screw_head=8;
screw_shaft=3.5;
screw_sink=5;
resolution=60;

$fn=resolution;

difference(){
  hull(){
    rotate_extrude ()
      translate([bottom_width/2-bottom_radius,0,0])
        circle(r=bottom_radius);

  translate ([0,0,height-top_radius])
    rotate_extrude ()
      translate([top_width/2-top_radius,0,0])
        circle(r=top_radius);
        }
  translate([0,0,-bottom_radius])
    cylinder(r=screw_shaft/2,h=screw_sink+1,$fn=60);
  translate([0,0,screw_sink-bottom_radius])
    cylinder(r=screw_head/2,h=height,$fn=60);
              }