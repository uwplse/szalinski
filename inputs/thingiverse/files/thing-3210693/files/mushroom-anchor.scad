// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// simple, functional small mushroom anchor
//
// Copyright 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// Radius of the cap in millimetres
r = 20;  // [5:1:50]

// size of the "chain" hole
hl = 4;  // [1:0.5:10]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]



/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

l_to_r = 2.5;  // Length of the stem in rs
r_to_h = 0.35;

w = 2.4;  // Wall width
p = 1.8; // cap width
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


h = r * r_to_h;
r_i = r - h * xy_factor;
l = r * l_to_r;


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

// *******************************************************
// End setup



// *******************************************************
// Generate the part

mushroom_anchor();



// *******************************************************
// Code for the parts themselves

module mushroom_anchor()
{
   anchor_cap();
   anchor_stem();
}

module anchor_cap()
{
   difference()
   {
      cylinder(r1=r_i, r2=r, h=h);
      translate([0, 0, -ms])
      {
         cylinder(r1=r_i-p, r2=r-p, h=h+2*ms);
      }
   }
   cylinder(r=r_i, h=p);
}

module anchor_stem()
{
   le = l - w  - hl/2;
   difference()
   {
      union()
      {
         translate([0,0,le/2])
         {
            cube([w,2*w+hl,le], center=true);
         }

         translate([0, 0, le])
         {
            rotate([0, 90, 0])
            {
               cylinder(r=w+hl/2, h=w, center=true);
            }
         }
      }
      translate([0, 0, le])
      {
         rotate([0, 90, 0])
         {
            cylinder(r=hl/2, h=w+2*ms, center=true);
         }
      }
   }
}
