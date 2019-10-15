// diameter of the rod
rod_dia     = 10;

// diameter of the screw holes
screw_dia   = 3;

// linear distance between the vertical screw holes
screw_dist  = 14;

// width (x and y) of the block
cube_width  = 20;

// height of the block
cube_height = 20;

difference()
{
  translate([-cube_width/2,-cube_width/2,0]) cube(size=[cube_width,cube_width,cube_height]);  
  union()
  {  
    translate([0,0,cube_height/2]) cylinder(h=cube_height+2,r1=rod_dia/2,r2=rod_dia/2,center=true, $fn=60);
// vert screw holes
    translate([screw_dist/2,screw_dist/2,cube_height/2]) cylinder(h=cube_height+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=60);
    translate([-screw_dist/2,screw_dist/2,cube_height/2]) cylinder(h=cube_height+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=60);
    translate([screw_dist/2,-screw_dist/2,cube_height/2]) cylinder(h=cube_height+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=60);
    translate([-screw_dist/2,-screw_dist/2,cube_height/2]) cylinder(h=cube_height+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=60);
// hor screw hole      
    translate([0,0,cube_height/2]) rotate([90,0,0]) cylinder(h=cube_width+2,r1=screw_dia/2,r2=screw_dia/2,center=true, $fn=60);
  }    
}