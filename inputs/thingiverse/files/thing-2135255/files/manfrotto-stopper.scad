//cylinder(d=29.5, h=2, center=true);
//polygon(points=[[27 * cos(0),0],[100,0],[130,50],[30,50]]);
use <MCAD/3d_triangle.scad>;


$fn=50;

//--- Stopper size
h =40;
r=29.8;
flat = 14;
//--- podRadius = 29.5;
podRadius = 29.5;

//--- Radius of in-circle
vertices  =  3dtri_sides2coord(flat, flat, flat);
ir = 3dtri_radiusOfIn_circle (vertices[0],vertices[1],vertices[2]);
//--- Center of in-circle
ic = 3dtri_centerOfIn_circle (vertices[0],vertices[1],vertices[2],ir);


difference () {
  //--- 
  scale([.35, .35, .5]) // .38
  difference () {
    //--- Main pod outer shape
    scale([1.4, 1.4, .8])
        translate ([0,0,.1]-ic) 
        3dtri_rnd_draw (vertices[0], vertices[1], vertices[2], h, r);
    //--- Main pod inner shape
    translate (-ic)
        3dtri_rnd_draw (vertices[0], vertices[1], vertices[2], h, r);
  }
  
  //--- Extract 3 pods shape
  for (n = [ 0 : 2 ])
    translate([
        (r + podRadius/2 + .5) * sin(360 * n / 3 + 360/6),
        (r + podRadius/2 + .5) * cos(360 * n / 3 + 360/6),
        1
    ])
    cylinder(h=h+2, r=podRadius, center=true);
};
