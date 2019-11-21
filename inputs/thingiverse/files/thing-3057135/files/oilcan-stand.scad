// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A stand for my oil can that catches the oil dripping out the tip
//
// Copyright 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0



// Diameter of the oil can
d_can = 79;  // [20:1:150]
// Height of the oiling tip above ground
h_tip = 133;  // [20:1:170]
// Distance of the tip from the center of the can
x_tip = 142;   // [20:1:200]


// Set this to "render" when done, then hit "Create Thing"
preview = 1; // [0: render, 1: preview]


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


clearance = 0.5;  // extra size for the can
b = 1.5;  // Thickness of the bottom plate
b_c = 4;  // Thickness of the connector
r_catcher = 10;  // radius of the oil catcher pot
w = 1.8;  // wall strength;
r_stem = 3;  // diameter of the oil catcher pot stem
h_can = 10;  // height of the can wall
h_clear = 5;  // distance from the tip to the catcher pot
pot_bottom_height = 8;  // To give the catcher got a bit of a flat bottom
l_horns = 20;


// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is wrong

r_can = d_can/2;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// Calculated
h_ct = h_tip-h_clear+b;
h_cc = 2*r_catcher;
h_cb = h_ct - h_cc;

// *******************************************************
// End setup



oilcan_stand();

module oilcan_stand()
{
   difference()
   {
      union()
      {
         solid_can_stand();
         connector();
         stem();
         solid_catcher();
         horns();
      }
      can_hollow();
      catcher_hollow();
   }
}

module solid_can_stand()
{

   cylinder(r=r_can+w+clearance, h=h_can+b);
}

module connector()
{
   translate([0,-r_stem,0])
   {
      cube([x_tip, 2*r_stem, b_c]);
   }
}

module stem()
{
   translate([x_tip,0,0])
   {
      cylinder(r=r_stem, h=h_ct);
   }
}

module solid_catcher()
{
   translate([x_tip,0,h_cb-2*w])
   {
      cylinder(r1=ms, r2=r_catcher+w, h=h_cc+2*w);
   }
}

module horns()
{
   horn();
   mirror([0,1,0])
   {
      horn();
   }
}

module horn()
{
   translate([x_tip-r_catcher-w, -2*w, h_ct-ms-w])
   {
      rotate([30, 0, 0])
      {
         cube([w, 2*w, l_horns+2*w]);
      }
   }
}

module can_hollow()
{
   translate([0,0, b])
   {
      cylinder(r=r_can, h=h_can+ms);
   }
}

module catcher_hollow()
{

   translate([x_tip,0,h_cb])
   {
      intersection()
      {
         cylinder(r1=ms, r2=r_catcher+ms, h=h_cc+2*ms);
         translate([0,0,pot_bottom_height])
         {
            cylinder(r=r_catcher+2*ms, h=h_cc+2);
         }
      }
   }

}
