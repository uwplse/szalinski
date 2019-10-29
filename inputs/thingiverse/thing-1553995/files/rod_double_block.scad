// diameter of the rod
rod_dia     = 10;

// diameter of the screw holes
screw_dia   = 3;

// distance between the two rods
rod_dist    = 3;

// thickness of the wall 
cube_wall   = 3;


difference()
{
  translate([-(2*rod_dia+2*cube_wall+rod_dist)/2,-(rod_dia+2*cube_wall)/2,0]) cube(size=[2*rod_dia+2*cube_wall+rod_dist,rod_dia+2*cube_wall,rod_dia+2*cube_wall]);  
  union()
  {  
// vert rod      
    translate([-(rod_dia+rod_dist)/2,0,(rod_dia+2*cube_wall)/2]) cylinder(h=rod_dia+2*cube_wall+2,r1=rod_dia/2,r2=rod_dia/2,center=true, $fn=50);
// hor screw     
    translate([-(rod_dia+rod_dist)/2,0,(rod_dia+2*cube_wall)/2]) rotate([90,0,0]) cylinder(h=rod_dia+2*cube_wall+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=50);
// vert rod      
    translate([+(rod_dia+rod_dist)/2,0,(rod_dia+2*cube_wall)/2]) cylinder(h=rod_dia+2*cube_wall+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=50);
// hor rod      
    translate([+(rod_dia+rod_dist)/2,0,(rod_dia+2*cube_wall)/2]) rotate([90,0,0]) cylinder(h=rod_dia+2*cube_wall+2,r1=rod_dia/2,r2=rod_dia/2,center=true, $fn=50);
// long screw hole      
    translate([0,0,(rod_dia+2*cube_wall)/2]) rotate([0,90,0]) cylinder(h=2*rod_dia+2*cube_wall+rod_dist+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=50);
  }    
}