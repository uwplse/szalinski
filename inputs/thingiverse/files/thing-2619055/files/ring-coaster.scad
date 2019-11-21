// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A ring coaster
//
// copyright 2017 -- 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


// Size of the coaster's hole (mm)
inner_diameter = 20;  // [10:1:90]
// Size of the coaster as a whole (mm)
outer_diameter = 49;  // [20:1:100]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]


/* [Hidden] */

// Done with the customizer


// These can be changed reasonably safely

h = 1.2;
b = 0.8;
w = 1.2;
sl_m = 13;
g = 2*w;

// You should know what you are doing when you change these:
r_i = inner_diameter/2;
r_o = outer_diameter/2;
r_is = r_i + 2*w;
r_os = r_o - 2*w;
sl_t = min(sl_m, r_is);
nsr = ceil((r_os-r_is)/sl_t);
sl_e = (r_os-r_is) / nsr;
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

// Pi is wrong.
tau = 2*PI;


// Done with setup. Now create the thing

ring_coaster();

// The real code

module ring_coaster()
{
   dish();
   for (r_ie=[r_is:sl_e:r_os-ms])
   {
      stegring(r_ie, sl_e);
   }
}



module dish()
{
   ts = [
      [r_i, 0],
      [r_o, 0],
      [r_o, h+b],
      [r_o-w, h+b],
      [r_o-w, b],
      [r_i+w, b],
      [r_i+w, h+b],
      [r_i, h+b],
      ];

   rotate_extrude()
   {
      polygon(ts);
   }
}



module stegring(r_ir, sl)
{
   stege = floor(r_ir * tau / (w+g));
   winkel = 360/stege;

   for (a = [0:winkel:360-0.001])
   {
      rotate(a)
      {
         translate([w/2, r_ir, b])
         {
            cube([w, sl ,h]);
         }
      }
   }
}
