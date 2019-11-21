// light cover blocker

width=24;
height=82;
thick=2;
screw_spacing=60;
screw_hole_diameter=3.5;

module lightcover() {
  $fn=50;
  switch_hole_width=10.4;
  switch_hole_height=24;
  guard_radius=17;
 
  linear_extrude(thick) 
    plate_sketch();   
  
  translate([-switch_hole_width/2-thick,0,0])    
    rotate([0,90,0])
      linear_extrude(thick)
        guard_sketch();   
  
  translate([switch_hole_width/2,0,0])    
    rotate([0,90,0])
      linear_extrude(thick)
        guard_sketch();   
  
  module plate_sketch() {
    difference() {
    square([width,height], true);
    square([switch_hole_width,
      switch_hole_height], true);
    translate([0,screw_spacing/2,0])
      circle(d=screw_hole_diameter);
    translate([0,-screw_spacing/2,0])
      circle(d=screw_hole_diameter);
    }     
  }
 
  module guard_sketch() {        
    difference() {
      circle(guard_radius);
      translate([0,-50,0])
        square([100,100], false);
    }
 
  }
}

lightcover();