// Make it float challenge
// How many coins ?  Lets try make R100 in R2 coins, thats enough for 2 medium
// Pizza's from Romans, and no I have never eaten a Romans Pizza.

// Concept is a hexagon shaped platform with pylons like an oil rig, this was
// inspired by seeing the PetroSA rig in Mossel Bay, thought hey rigs are stable
// and carry a huge load
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

coin_diameter = 23; // Add an extra mm
coin_thickness = 2;
pylon_height = 140;
platform_radius = 100;  // Make sure this + pylon caps fits your printer

$fn = 128+0;

fit = 0+0;    // 1 test fit the cap to a mini pylon

// Select Top or Pylon
part  = 1;    // // [0:Pylon,1:Platform

module pylon (height=pylon_height)
{
    difference ()
    {
        union ()
        {
            cylinder (r=1.5+coin_diameter/2,h=height,center=true);
            // Lock tab
            translate ([-3,coin_diameter/-2,height/2-6]) rotate ([90,0,0]) cube ([2.8,2.8,2.8]);
        }
        translate ([0,0,2]) cylinder (r=0.6+coin_diameter/2,h=height, center=true);
    }
}


module pylonCap ()
{
   difference ()
    {
        cylinder (r=coin_diameter/2+3.5,h=15,center=false);
        union ()
        {
            // Cap cutout
            translate ([0,0,2]) cylinder (r=coin_diameter/2+1.5,h=15, center=false);
            // Coin slot
            translate ([-coin_diameter/2-1,1.25,-4]) rotate ([90,0,0]) cube ([coin_diameter+1,10,2.5]);
            // Pylon locking slot
            translate ([-3,-coin_diameter/2-0.5,8]) rotate ([90,0,0]) cube ([3,10,5]);
            translate ([-3,-coin_diameter/2-0.5,10]) rotate ([90,90,0]) cube ([3,7,5]);
        }
    }
}


module platform ()
{
    size = platform_radius;
    width = size / 1.75;

    for (rot = [-60, 0, 60])
    {
        
        rotate ([0,0,rot]) cube([width, size, 2], true);
        rotate ([0,0,rot]) translate ([width/2+6,width-2,-1]) rotate ([0,0,-30]) pylonCap ();
        rotate ([0,0,rot]) translate ([-width/2-6,-width+2,-1]) rotate ([0,0,150]) pylonCap ();
    }
}
 


// test the fit lock clip 
if (fit)
{
    pylon (height = 20);
    translate ([0, 0, 14]) rotate ([180,0,183]) color ("green") pylonCap ();
}
else if (part)
{
    platform();
}
else
{
    pylon();
}
