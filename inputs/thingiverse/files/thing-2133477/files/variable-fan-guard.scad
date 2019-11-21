// A configurable fan guard adapter
// Created by : Doug Pickering
// FanGuard@doug.pm5.co.uk

// Based on :
// A configurable fan size adapter, Created by : Sherif Eid


 
// v 1.0    : first release

// Here goes design variables, dimensions are in mm

// fans' parameters
// wall thickness
t_wall = 2.5;
// fan 1: diameter
d_fan1 = 120;
// fan 1: distance between screw openings
ls_fan1 = 105;  
// fan 1: screw openings' diameter
ds_fan1 = 4.3;  
// Honeycomb radius (from point to point)
h_rad = 4; // radius of honeycomb
// honeycomb Wall thickness
h_wall = 1; 
 
 
// other advanced variables
// used to control the resolution of all arcs 
$fn = 90;        

// modules library
module fanplate(d,ls,t,ds) 
{
    /*
    d   : diameter of the fan
    ls  : distance between screws
    t   : wall thickness
    ds  : diameter of screws 
    */
    difference()
    {
        difference()
        {
            difference()
            {
                difference()
                {
                    //translate([d*0.1+d/-2,d*0.1+d/-2,0]) minkowski()
                    translate([-0.45*d,-0.45*d,0]) minkowski()
                        { 
                         //cube([d-2*d*0.1,d-2*d*0.1,t/2]);
                         cube([d*0.9,d*0.9,t/2]);
                         cylinder(h=t/2,r=d*0.05);
                        }
                    translate([ls/2,ls/2,0]) cylinder(d=ds,h=t);
                }
                translate([ls/-2,ls/2,0]) cylinder(d=ds,h=t);
            }
            translate([ls/-2,ls/-2,0]) cylinder(d=ds,h=t);
        }
        translate([ls/2,ls/-2,0]) cylinder(d=ds,h=t);
    }
}

module honeycomb(length,width,radius,height,hthick)
{
    r = (radius* 1.15)-(hthick/2);
    xstep = radius*2;
    hxstep = xstep/2;
    ystep = radius*3.55;  
    hystep = ystep/2;
    
    for(b = [0:ystep:(length/2)+ystep])
    {
    for(a = [0:xstep:length/2])
    {
        translate([b,a,0])
        cylinder(r=r,h=height,$fn=6);
        translate([b+hystep,a+hxstep,0])
        cylinder(r=r,h=height,$fn=6);
        
        if (b>0)
        {
        translate([-b,a,0])
        cylinder(r=r,h=height,$fn=6);
        translate([-b+hystep,a+hxstep,0])
        cylinder(r=r,h=height,$fn=6);
        }

if (a>0)
{
        translate([b,-a,0])
        cylinder(r=r,h=height,$fn=6);
        translate([b+hystep,-a+hxstep,0])
        cylinder(r=r,h=height,$fn=6);
        
        if (b>0)
        {
        translate([-b,-a,0])
        cylinder(r=r,h=height,$fn=6);
        translate([-b+hystep,-a+hxstep,0])
        cylinder(r=r,h=height,$fn=6);
        }
    }

    }
}
}

// body code goes here


difference() // fan 1 plate + pipe 
{
    union()
    {
      fanplate(d=d_fan1,ds=ds_fan1,t=t_wall,ls=ls_fan1);   
    }
    intersection()
    {
    cylinder(d=d_fan1-2*t_wall,h=t_wall);
           honeycomb(d_fan1,d_fan1,h_rad,t_wall,h_wall);
    }
}


