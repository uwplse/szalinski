$fn=96;

pot();

module shape(what, size)
{
    if (what==0)
        hearth_shape(size);
    else if (what==1)
        diamond_shape(size);
    else if (what==2)
        circle(size/2, center=true);
    else if (what==3)
        rotate([0,0,40])
            parametric_star(stars_count, size/4, size/2);
    else if (what==4)
        moon_shape(size/2);
        
}

module moon_shape(size) {
    dx=size;
    k=1.4;
    le=size+dx-size*k;
    translate([size-le/2,0])
    difference()
    {
        circle(r=size);
        translate([dx,0,0])
            circle(r=size*k);
    }    
}

module hearth_shape(size) {
     union() {
         sz=size*0.7;
        square(sz,sz, center=true);
        translate([0,sz/2,0]) circle(sz/2);
        translate([sz/2,0,0]) circle(sz/2);
    }
}

module diamond_shape(size) {
    square(size, center=true);
}

module border_ray(size,thickness,height) {
   linear_extrude(height=height) 
          minkowski() {
               hearth_shape(size);
               circle(thickness+0.1); //because 0 would produce an empty object
        }
}

module border_ray_box(size,height,thickness) {
    difference() {
         border_ray(size,thickness,height);
//         translate([0,0,thickness])  border_ray(size,0,height);
    }
}

module base_1()
{
    difference()
    {
        union()
        {
            cylinder(d1=base_size_bottom, d2=base_size_top, h=h, center=true);
            translate([0,0,h/2])
            rotate_extrude(convexity=10)
                translate([base_size_top/2-border_r1/2,0,0])
                    circle(d=border_r1);
        }
        translate([0,0,thick])
            cylinder(d1=base_size_bottom-thick, d2=base_size_top-thick, h=h, center=true);
    }
}

//module base_2()
//{
//    ep = 4*base_size_bottom;
//    scale([0.5,0.5,1])
//    {
//    difference()
//    {
//    scale([1,1,2])
//        difference()
//        {
//            sphere(r=r2);
//            sphere(r=r2-thick);
//        }
//    translate([0,0,h/2+ep/2]) 
//        cube(size=ep, center=true);
//        
//    translate([0,0,-h/2-ep/2]) 
//        cube(size=ep, center=true);
//    }
//    translate([0,0,-h/2])
//        linear_extrude(height=thick)
//            #circle(r=base_size_bottom);
//    translate([0,0,h/2])
//        rotate_extrude(convexity=10)
//            translate([r2*border_ray+border_r1/2,0,0])
//                circle(r=border_r1);
//}
//}
//
module base_sphere()
{
    rotate_extrude(convexity=10) base_sphere_shape();
}

module base_sphere_shape()
{
    bst = base_size_top/2;
    bsb = base_size_bottom/2;
    bsm = base_size_middle/2;
    
    x1=bst;
    y1=h/2;
    x2=bsm;
    y2=0;
    x3=bsb;
    y3=-h/2;
    
    
    echo("P1 ", x1, y1);
    echo("P2 ", x2, y2);
    echo("P3 ", x3, y3);
    
    x12=x1*x1;
    y12=y1*y1;
    x22=x2*x2;
    y22=y2*y2;
    x32=x3*x3;
    y32=y3*y3;
    
    xc = ((x32-x22)/(y3-y2)-(x12-x22)/(y1-y2)+y3-y1)/(2*(x3-x2)/(y3-y2)-2*(x1-x2)/(y1-y2));
    yc = (-2*xc*(x3-x2)/(y3-y2)+(x32-x22)/(y3-y2)+y3+y2)/2;
    echo("C=",xc,yc);
    
    xr = x1-xc;
    yr = y1-yc;
    r = sqrt(xr*xr+yr*yr);
    echo("R=",r);

    sqs = abs(y3-y1);
    
    translate([0,-h/2]) square([bsb,thick]);
    if (base_top_round)
    {
        al1 = asin((y1-yc)/r);
        al2 = asin((y1-yc)/(r-thick));
        xp2 = xc+(r-thick)*cos(al2);
        x = (x1+xp2)/2;
        translate([x,y1])    circle(d=x1-xp2);
        echo("X1=",x1);
        echo("X1bis=", xc+r*cos(al1));
    }
    intersection()
    {    
        difference()
        {
            translate([xc, yc]) circle(r=r);
            translate([xc, yc]) circle(r=r-thick);
        }
        translate([sqs/2,0]) square(sqs, center=true);
    }
    
    
//    translate([x1,y1]) cylinder(r=1, h=10);
//    translate([x2,y2]) cylinder(r=1, h=10);
//    translate([x3,y3]) cylinder(r=1, h=10);
     
    
}

module base_shape()
{
    sce=[1,1];
   difference()
    {
        linear_extrude(height=h, center=true, scale=sce)
            shape(base_shape, base_size_bottom);
        sc = (base_size_bottom-thick)/base_size_bottom;
        translate([thick, thick]/10)
        echo("SC=",sc);
        scale([sc,sc])
        linear_extrude(height=h*2, center=true, scale=sce)
            shape(base_shape, base_size_bottom*sc);
    }
   translate([0,0,-h/2])
       linear_extrude(height=thick)
            shape(base_shape, base_size_bottom);
    
}

module base()
{
    if (base_shape==-2)
        base_1();
    else if (base_shape==-1)
        base_sphere();
    else
        base_shape();
}

thick=4;
base_top_round=1;                   // for ellipsoid yet
base_size_bottom=30;               // base support size [10:1:80]
base_size_middle = 60;              // middle size for ellipsoid base
base_size_top=40;                   // for cone base
base_shape=-1;       // [-2: cone, -1: ellipsoid, 0: hearth, 1: diamond, 2: circle, 3: star, 4: moon]
border_ray = 0.82;    // big border ray factor
border_r1 = 3;    // small ray border
h=75; // height

holes_per_layer=10;
holes_size=5;       // Size of holes
holes_shape=2;      //  [0: hearth, 1: diamond, 2: circle, 3: star, 4: moon]
holes_offset_z=10;   // offset border_rays
holes_offset_h=1;  // holes horizontal offset [0:0.1:3]
holes_zspace=1;  // z holes spacing (percent of hole size) [0:0.01:2]
holes_without_top=5;    // z height without holes at top of holder
holes_start_angle=0;
holes_rotation=0;      // Care, if support is needed this will produce bad print

stars_count=5;

e=holes_size/2;

module pot()
{

    difference()
    {
//        color("orange")
        color([0.5,0.75,0])
                base();
        for(z= [-h/2+thick+e+holes_offset_z: holes_size*(1+holes_zspace) : h/2-e-holes_without_top ])
            for(a = [ 0 : 360 / holes_per_layer : 360 ])
                rotate([0,0,a+holes_start_angle+z*holes_offset_h])
            translate([0,0,z])
                rotate([90, holes_rotation])
                    linear_extrude(height=100)
                        shape(holes_shape, holes_size);
    }
}

//-- Parametric star
//-- (c)  2010 Juan Gonzalez-Gomez (Obijuan) juan@iearobotics.com
//-- GPL license

//-- The 2*N points of an N-ponted star are calculated as follows:
//-- There are two circunferences:  the inner and outer.  Outer points are located
//-- at angles: 0, 360/N, 360*2/N and on the outer circunference
//-- The inner points have the same angular distance but they are 360/(2*N) rotated
//-- respect to the outers. They are located on the inner circunference

//--- INPUT PARAMETERS:
//--- N: Number of points
//-- ri: Inner radius
//-- ro: outer radius
module parametric_star(N=5, ri=15, re=30) {

  //-- Calculate and draw a 2D tip of the star
 //-- INPUT: 
 //-- n: Number of the tip (from 0 to N-1)
  module tipstar(n) {
     i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
    e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
    i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
    polygon([ i1, e1, i2]);
  }

  //-- Draw the 2D star 
  
   //-- The star is the union of N 2D tips. 
   //-- A inner cylinder is also needed for filling
   //-- A flat (2D) star is built. The it is extruded
    union() {
      for (i=[0:N-1]) {
         tipstar(i);
      }
      rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    }
}
