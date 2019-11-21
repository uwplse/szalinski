// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// NN
//
// Copyright 2018 - 2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */


// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Outer diameter of tube (mm)
diameter = 12.7;  // [5:0.1:40]

// Thickness of the tube wall
wall = 0.9;   // [0.4:0.1:5]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


// w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate hight
c = 0.4;  // Clearance

gap = 1;  // The central gap for the two plug/clamp arms
cgap = 2; // Cylinder gap
r_r = 2;  // Rounding radius. Reduce this for tubes < ~ 5mm
h_p = 5;  // hight of the plug bit

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r



some_distance = 50;
ms = 0.01;  // Muggeseggele.

r_m = diameter/2;  // main radius
r_red = r_m - r_r;  // reduced radius of the visible cap

r_pm = r_m - wall + c; // main radius of the plug
r_pb = r_m -wall - cgap;

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 2;
rs = 0.25;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

endcap();
//2d_vcap();
// %visible_cap();
// #plug();
// ground_plug();

// *******************************************************
// Code for the parts themselves


module endcap()
{
   visible_cap();
   plug();
}


module visible_cap()
{
   rotate_extrude()
   {
      2d_vcap();
   }
}

module 2d_vcap()
{
   square([r_red, r_r]);
   intersection()
   {
      translate([r_red, r_r])
      {
         circle(r_r);
      }
      translate([0,0,-ms])
      {
         square([r_m+ms, r_r+2*ms]);
      }
   }
   translate([0, r_r])
   {
      square([r_m+ms, p]);
   }
}

module plug()
{
   translate([0,0,r_r+p-ms])
   {
      ground_plug();
   }
}


module ground_plug()
{
   difference()
   {
   intersection()
   {
      cylinder(r1=r_pb, r2=r_pm, h=h_p);
      cube([diameter, 2*r_pb, 3*r_m], center=true);
   }
   cube([gap, diameter, 3*r_m], center=true);
   }
}
