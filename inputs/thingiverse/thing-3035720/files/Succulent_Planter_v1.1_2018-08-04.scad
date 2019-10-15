//Succulent Spherical Planter
//by: BCM
//date: 8/4/2018
//units: mm
//description: Spherical succulent planter with a top and bottom where the bottom has some drainage reserve
//version 1.0: Base

////////////////////////////////////////////////////
/////////////       INPUTS /////////////////////////
////////////////////////////////////////////////////

option = 1; //1: Planter, 2: Base, 3: Assembly

$fn = 200; //Poloygons on a sphere constant
EPS = 0.001; //Arbitrarily small number to avoid coincident faces
offset=0; //Offset for displaying assembly

r1 = 50; //Outside radius

t = 3; //Thickness

z1 = 80; //Top coordinate
z2 = 35; //Planter/base connection
z7 = 17.5; //Bottom coordinate
//Height = z1 - z7

g1 = 5; //Gap on bottom for reservoir
g2 = 0.5; //Gap between planter and base at connection
g3 = 2; //Gap between planter and base circles


b1 = 15; //Foot lengths
b2 = 10; //Planter hole diameter
b4 = 15; //Foot widths

x2 = 15; //Footing offsets

////////////////////////////////////////////////////
/////////////       CALCULATED PARAMETERS  /////////
////////////////////////////////////////////////////
r2 = r1 - t; //Base inside radius
r3 = r2 - g3; //Planter outside radius for height of base
r4 = r3 - t; //Planter inside radius


z6 = z7 + t ;//Top of inside of base
z5 = z6 + g1; //Bottom of planter
z4 = z5 + t; //Top of inside of planter
z3 = z2 - g2; //Top of base


theta = asin((z1-r1)/r1);
x1=r1*cos(theta);

////////////////////////////////////////////////////
/////////////       RENDERS ////////////////////////
////////////////////////////////////////////////////

if (option == 3){
    translate([0, 0, r1])
        intersection(){
            union(){
                Planter();
                translate([0, 0, -offset])
                    Base();
            }
            translate([0, r1/2, 0])
                cube([2*r1, r1, 2*r1], center=true);
        }
    }

if(option == 2){
    Base();
}

if(option == 1){
    Planter();
}
////////////////////////////////////////////////////
/////////////       FUNCTIONS //////////////////////
////////////////////////////////////////////////////







////////////////////////////////////////////////////
/////////////       MODULUES ///////////////////////
////////////////////////////////////////////////////

module Planter()
//Top planter
{
    difference()
    {
        //Elements added
        union()
        {
            //Full thickness top sphere
            Partial_Sphere(r1, z2, z1, r1);
            
            //Reduced thickness bottom sphere
            Partial_Sphere(r3, z5, z1, r1);
        }
        
        //Elements removed
        union ()
        {
            //Inside sphere
            Partial_Sphere(r4, z4, z1+1, r1);
            
            //Top Cylinder
            //Avoids unnecessary smll hole
            cylinder(r=x1, h=r1);
            
            //Drain hole
            translate([0, 0, -r1])
                cylinder(r=b2, h=r1);
        }
    }
}

module Base()
{
    union()
    {
        difference()
        {
            Partial_Sphere(r1, z7, z3, r1);
            Partial_Sphere(r2, z6, z2, r1);
        }
        
        for(i=[0:90:270])
        {
            rotate([0, 0, i])
                translate([x2, -b4/2, -r1+z6-EPS])
                    cube([b1, b4, g1], center=false);
        }
    }
}


//*translate([0, 0, r1]) 
//    Partial_Sphere(90, 40, 180, r1);
module Partial_Sphere(radius, bot, top, r_out)
//Part of a sphere with a bottom and a top cut off
{
    difference()
    {
        union()
        {
            sphere(r=radius);
        }
        union()
        {
            translate([0, 0, -r_out+bot/2-EPS])
                cube([2*radius+EPS, 
                        2*radius+EPS, 
                        bot+EPS],
                    center=true);
            translate([0, 0, top/2+EPS])
                cube([2*radius+EPS, 
                        2*radius+EPS, 
                        2*r_out-top+EPS],
                    center=true);
        }
    }
}