// A configurable fan size adapter
// Create by : Sherif Eid
// sherif.eid@gmail.com

// v 1.0.4  : cleaned code, unified all in one file
// v 1.0.3  : added cone angle for the larger fan
// v 1.0.2  : fixed bug in sizing the fan plates
// v 1.0.1  : fixed output fan cone to tube size, increased size of fan opening
// v 1.0    : first release

// Here goes design variables, dimensions are in mm

// fans' parameters
// wall thickness
t_wall = 4;
// fan 1: diameter
d_fan1 = 30;
// fan 1: distance between screw openings
ls_fan1 = 24;  
// fan 1: screw openings' diameter
ds_fan1 = 3.4;  
// fan 2: diameter
d_fan2 = 60;  
// fan 2: distance between screw openings
ls_fan2 = 52;
// fan 2: screw opening diameters
ds_fan2 = 4.3;   

// larger fan cone parameters
// length to manifold elbow  
l_mani1 = 5;
// cone angle
a_cone = 100;
// length to manifold elbow  
l_mani2 = round(d_fan2/(2*tan(a_cone/2)));

// manifold parameters
// manifold angle
a_mani = 45;     
// z-axis rotation angle of the manifold elbow
az_mani = 20;     
// internal parameters
// pipe reduction ratio relative to fan 1 diameter
n_pipe = 1;
// angle factor
n_angle = 0.501;

// other advanced variables
// used to control the resolution of all arcs 
$fn = 50;        

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

module mani_elbow(a,d,t)
{
    // this is the manifold elbow
    // a  : angle of the elbow
    // d  : diameter of the elbow
    // t  : wall thickness
    
    translate([-1*n_angle*d,0,0]) rotate([-90,0,0]) difference()
    {
        difference()
        {  
            difference()
            {
                rotate_extrude() translate([n_angle*d,0,0]) circle(r = d/2);
                rotate_extrude() translate([n_angle*d,0,0]) circle(r = (d-2*t)/2);
            }
            translate([-2*d,0,-2*d]) cube([4*d,4*d,4*d]);
        }
        rotate([0,0,90-a]) translate([-4*d,-2*d,-2*d]) cube([4*d,4*d,4*d]);
    }
}

// body code goes here


difference() // fan 1 plate + pipe 
{
    union()
    {
        fanplate(d=d_fan1,ds=ds_fan1,t=t_wall,ls=ls_fan1);  // fan 1 plate
        cylinder(d=n_pipe*d_fan1,h=l_mani1+t_wall);    // fan 1 pipe length
    }
    cylinder(d=n_pipe*d_fan1-2*t_wall,h=l_mani1+t_wall);
}


// elbow, cone and second fan plate
rotate([0,0,az_mani]) union() {
    translate([0,0,l_mani1+t_wall]) mani_elbow(d=n_pipe*d_fan1,a=a_mani,t=t_wall);
    translate([n_pipe*n_angle*d_fan1*(cos(a_mani)-1),0,t_wall+l_mani1+n_pipe*n_angle*d_fan1*sin(a_mani)]) rotate([0,-1*a_mani,0]) difference()
    {
        union()
        {
            cylinder(d1=n_pipe*d_fan1,d2=n_pipe*d_fan2,l_mani2);
            translate([0,0,l_mani2]) fanplate(d=d_fan2,ds=ds_fan2,t=t_wall,ls=ls_fan2);  // fan 2 plate
        }
        cylinder(d1=n_pipe*d_fan1-2*t_wall,d2=n_pipe*d_fan2-2*t_wall,l_mani2+t_wall);
    }
}

