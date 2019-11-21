// The angle to tilt pcb
tilt_angle = 45;

/* [Hidden] */
layer_height=.2; extrusion_width=.5;
epsilon=.01;

module ppmount(
 size_pcb = [41,13,2],
 h_standoff = 7,
 offset_hole = 1.6+3.1/2,
 d_screwhole = 2.7,
 h_over = 4-2,
 s = 2.5,
 d_mountscrewhole=3.1,
 w_ext = 20,
 w_slot = 6.5,
 depth_slot = 6.5,
 l_mountscrew = 8,
 d_mountscrewhead = 6,
 h_mountscrewhead = 3,
 depth_slide = 1,
 w_tnut = 10,
 a_tilt = 45,
) {
 fnd=PI*2;
 s_screw = 2*extrusion_width;

 d2 = d_screwhole+2*s_screw;
 d1 = d2+2*h_standoff;
 h_mount = l_mountscrew-depth_slot/2;
 
 difference() {
  union() {
   linear_extrude(height=size_pcb.x,convexity=16)
   difference() {
    union() {
     hull() {
      rotate([0,0,-a_tilt])
      square(size=[h_over+size_pcb.z+h_standoff+s,s+size_pcb.y+s]);
      mirror([0,1]) square([h_mount,w_ext]);
      
     }//hull
     translate([0,-w_ext/2])
     circle(d=w_slot,$fn=w_slot*fnd);
    }//union
    rotate([0,0,-a_tilt]) {
     translate([-1,s+depth_slide])
     square(size=[1+h_over+size_pcb.z+h_standoff,size_pcb.y-2*depth_slide]);
     hull() translate([h_over+size_pcb.z/2,s+size_pcb.y/2]) {
      square(size=[size_pcb.z,size_pcb.y],center=true);
      square(size=[size_pcb.z+2*depth_slide,size_pcb.y-2*depth_slide],center=true);
     }
    }//rotate
   }//difference
   rotate([0,0,-a_tilt])
   intersection() {
    for(z=[offset_hole,offset_hole+d1])
    translate([h_over+size_pcb.z+h_standoff+epsilon,s+size_pcb.y/2,size_pcb.x-z])
    rotate([0,-90,0])
    cylinder(d1=d1,d2=d2,h=h_standoff+epsilon,$fn=d1*fnd);
    translate([0,s,0])
    cube(size=[h_over+size_pcb.z+h_standoff+1,size_pcb.y,size_pcb.x]);
   }//intersection
  }//union
  // 2020 mount
  translate([0,-w_ext/2,size_pcb.x/2]) rotate([0,90,0]) {
   translate([0,0,h_mount])
   cylinder(d=d_mountscrewhead,h=h_over+size_pcb.z+h_standoff+s+1,$fn=d_mountscrewhead*fnd);
   translate([0,0,-1])
   cylinder(d=d_mountscrewhole,h=h_over+size_pcb.z+h_standoff+s+2,$fn=d_mountscrewhole*fnd);
  }
  // T-nut cutout
  hull()
  for(sz=[-1,1]) translate([-epsilon,0,size_pcb.x/2+sz*w_tnut/2])
  rotate([0,-135,0])
  translate([0,-w_slot/2-1-w_ext/2,0])
  cube(size=[w_slot*sqrt(2)/2+2,w_slot+2,w_slot*sqrt(2)/2+2]);
  // pcb mount
  rotate([0,0,-a_tilt])
  translate([0,s+size_pcb.y/2,size_pcb.x-offset_hole]) rotate([0,90,0])
  cylinder(d=d_screwhole,h=h_over+size_pcb.z+h_standoff+s+1,$fn=d_screwhole*fnd);
 }//difference
 
 * difference() {
  union() {
   linear_extrude(height=size_pcb.x,convexity=16) {
    polygon(points=[
     [0,0],[0,s+depth_slide],
     // side
     [h_over-depth_slide,s+depth_slide],[h_over,s],
     [h_over+size_pcb.z,s], [h_over+size_pcb.z+depth_slide,s+depth_slide],
     [h_over+size_pcb.z+h_standoff,s+depth_slide],
     // bottom
     [h_over+size_pcb.z+h_standoff,s+size_pcb.y-depth_slide],
     // side
     [h_over+size_pcb.z+depth_slide,s+size_pcb.y-depth_slide],
     [h_over+size_pcb.z,s+size_pcb.y],[h_over,s+size_pcb.y],
     [h_over-depth_slide,s+size_pcb.y-depth_slide],
     [0,s+size_pcb.y-depth_slide],
     // outside
     [0,s+size_pcb.y+s],[h_over+size_pcb.z+h_standoff+s,s+size_pcb.y+s],
     [h_over+size_pcb.z+h_standoff+s,0],
     // 2020 mount part
     [h_mount,-w_ext],[0,-w_ext]
    ],convexity=16);
    translate([0,-w_ext/2])
    circle(d=w_slot,$fn=w_slot*fnd);
   }//linear_extrude
   intersection() {
    for(z=[offset_hole,offset_hole+d1])
    translate([h_over+size_pcb.z+h_standoff+epsilon,s+size_pcb.y/2,z])
    rotate([0,-90,0])
    cylinder(d1=d1,d2=d2,h=h_standoff+epsilon,$fn=d1*fnd);
    translate([0,s,0])
    cube(size=[h_over+size_pcb.z+h_standoff+1,size_pcb.y,size_pcb.x]);
   }//intersection
  }//union
  // 2020 mount
  translate([0,-w_ext/2,size_pcb.x/2]) rotate([0,90,0]) {
   translate([0,0,h_mount])
   cylinder(d=d_mountscrewhead,h=h_over+size_pcb.z+h_standoff+s+1,$fn=d_mountscrewhead*fnd);
   translate([0,0,-1])
   cylinder(d=d_mountscrewhole,h=h_over+size_pcb.z+h_standoff+s+2,$fn=d_mountscrewhole*fnd);
  }
  // pcb mount
  translate([0,s+size_pcb.y/2,offset_hole]) rotate([0,90,0])
  cylinder(d=d_screwhole,h=h_over+size_pcb.z+h_standoff+s+1,$fn=d_screwhole*fnd);
  // T-nut cutout
  hull()
  for(sz=[-1,1]) translate([-epsilon,0,size_pcb.x/2+sz*w_tnut/2])
  rotate([0,-135,0])
  translate([0,-w_slot/2-1-w_ext/2,0])
  cube(size=[w_slot*sqrt(2)/2+2,w_slot+2,w_slot*sqrt(2)/2+2]);
 }//difference
}

ppmount(a_tilt = tilt_angle);
