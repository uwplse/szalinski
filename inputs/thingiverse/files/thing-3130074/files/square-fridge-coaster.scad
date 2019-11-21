// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A simple "coaster" to stop condiment bottles from falling over when
// placed on the bars of a the grid in the fridge
//
// Copyright 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Distance from one bar of the fridge shelf grid to the next. All sizes are in millimetres.
bar_spacing = 18.4;  // [5:0.1:30]
// Diameter of one shelf grid bar
bar_width = 2.8;  // [0.5:0.1:7]
// Height of the coaster pot.
pot_height = 20;  // [3:0.5:50]

// Breadth (x direction size) of the bottle to hold
x_width = 39;  // [10:0.1:80]

// Depth (y direction size) of the bottle to hold
y_width = 39;  // [10:0.1:80]

// Width of the flange. How much the bottom is wider than the pot on top.
flange = 3;  // [0:0.5:15]


/* [Hidden] */

// Done with the customizer

preview = 0; // [0:render, 1:preview]
// Kept, but not used


// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.4;  // Clearance
angle = 60; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around


xw = x_width + c;
yw = y_width + c;
xww = xw + 2*w;
yww = yw + 2*w;

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
// Generate the parts

fridge_coaster();

// *******************************************************
// Code for the parts themselves


module fridge_coaster()
{

   hrc = ceil((xw+w+bar_width+flange)/bar_spacing) + 1;
   difference()
   {
      union()
      {
         translate([0,0,p+pot_height/2+ms])
         {
            cube([xww, yww, 2*p+pot_height+2*ms], center=true);
         }
         translate([0,0,p])
         {
            cube([xww+2*flange, yww+2*flange, 2*p], center=true);
         }
      }
      translate([0,0,2*p])
      {
         translate([0,0,p+pot_height/2+ms])
         {
            cube([xw, yw, 2*p+pot_height+2*ms], center=true);
         }
      }
      for (o=[-hrc:hrc])
      {
         echo(o);
         translate([(o+0.5)*bar_spacing,0, 0])
         {
            cube([bar_width, yww + 2*(c+bar_width+flange+ms), 2*p], center=true);
         }
      }
   }
}
