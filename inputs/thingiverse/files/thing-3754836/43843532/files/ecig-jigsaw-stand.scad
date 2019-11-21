// height of the jigsaw layer, mm
h_jigsaw = 4;
// diameter of the atomizer threads
d_thread = 8;
// length of the atomizer threads
l_thread = 6;
// maximum diameter of the atomizer we're going to accomodate
d_tank = 28;


/* [Hidden] */
layer_height=.2; extrusion_width=.5;
epsilon=.01;

module piece(
 h_jigsaw = 4,
 l_thread = 5+1,
 d_thread = 7+1,
 d_tank = 28,
 l_jigsaw = 2.5,
 s_z = layer_height*5,
 s_xy = extrusion_width*2,
 tolerance_xy = extrusion_width/2,
 tolerance_z = layer_height*2, /* TODO: not implemented */
) {
 fnd=PI*2; fnr=2*fnd;
 
 w = d_tank;
 
 offset_jigsaw = s_xy;
 r_jigsaw = (w/2-offset_jigsaw-s_xy/2)*sin(45)/(1+sin(45));
 w_jigsaw = r_jigsaw;
 y_jigsaw = offset_jigsaw+r_jigsaw;
 
 module js_profile(l_extra=1) {
  translate([-w_jigsaw/2,-l_extra])
  square([w_jigsaw,y_jigsaw+l_extra]);
  translate([0,y_jigsaw])
  circle(r=r_jigsaw,$fn=r_jigsaw*fnr);
 }
 module profile() {
  difference() {
   square([w,w],center=true);
   for(zr=[0,90]) rotate([0,0,zr])
   translate([-0,-w/2]) js_profile();
  }
  for(zr=[0,90]) rotate([0,0,zr])
  translate([0,w/2]) offset(r=-tolerance_xy) js_profile();
 }
 
 linear_extrude(height=h_jigsaw+epsilon,convexity=16)
 profile();
 translate([0,0,h_jigsaw]) {
  translate([-w/2,-w/2,0]) cube(size=[w,w,s_z]);
  difference() {
   cylinder(d=d_tank,h=s_z+l_thread,$fn=d_tank*fnd);
   translate([0,0,s_z])
   cylinder(d=d_thread,h=l_thread+1,$fn=d_thread*fnd);
  }
 }

}

piece(
 h_jigsaw = h_jigsaw,
 d_thread = d_thread,
 l_thread = l_thread,
 d_tank = d_tank
);