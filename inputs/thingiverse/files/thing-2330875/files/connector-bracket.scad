width=15.45;
height=40;
thick=3;
first_screw_offset=10;
screw_spacing=20;
num_screw_holes=2;
screw_hole_diameter=3.5;


linear_extrude(thick)
   sketch(); 

module sketch() {
  $fn=60;
  difference() {
    square([width,height], false);
    for(i=[0:num_screw_holes-1]) {
      translate([width/2, first_screw_offset+ (i*screw_spacing), 0])
        circle(d=screw_hole_diameter);
    }
  }
}