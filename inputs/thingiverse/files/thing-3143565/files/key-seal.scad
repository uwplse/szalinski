// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Key seal.
//
// Copyright 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// The bow is the "grip" of the key
bow_shape = 0; // [0: circular, 1: rectangular]

// Diameter of the key's circular bow.
bow_diameter = 16.5;  // [5:0.1:40]

// Size of the rectangular bow normal to the insertion direction
bow_width = 19;  // [5:0.1:40]

// Size of the rectangular bow in insertion direction
bow_length = 12;  // [5:0.1:40]


// Thickness of the key.
thickness = 2;  // [0.5:0.1:5]


// The length of the bit you insert into the lock from tip to bow
blade_length = 18.5;  // [5:0.1:40]

// The width of the blade
blade_width = 5.3;  // [1:0.1:20]

// The shoulder is the bit that stops you from pushing in the key too far. This is the extra width of the protrusion.
shoulder_width = 2.5;  // [1:0.1:10]

// Distance from the bow to the shoulder.
shoulder_length = 6.5;  // [1:0.1:15]

// Key ring hole diameter
ring_hole_diameter = 4;  // [0.5:0.1:5]

// Distance of the ring hole from the edge of the key
ring_hole_land = 2.5;  // [0.5:0.1:5]

// How much the ring hole is offset towards the cuts and shoulder side. Manual correction of the land width needed for circular bows.
ring_hole_offset = 0;  // [-20:0.1:20]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]


/* [Hidden] */

// Done with the customizer.

// *******************************************************
// Extra parameters. These can be changed reasonably safely.

w = 0.8;  // external wall width
p = 0.4;  // height of the bottomt plate
c = 0.4;  // clearance

lh = 0.2; // layer height
nw = 0.4;  // nozzle width

sh = lh * 2;  // We do two layers of strakes or stringers

// *******************************************************
// Some shortcuts. These shouldn't be changed

angle = 60; // Overhangs much below 60 degrees are a problem for me
xy_factor = 1/tan(angle);  // To get from a height to a horizontal width
                           // inclined correctly
z_factor = tan(angle);  // the other way around

rb = bow_shape ? bow_length/2 : bow_diameter / 2;
kw = bow_shape ? bow_width/2 : bow_diameter / 2;
h = thickness;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa,  all for preview or rendering.
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

key_seal();

// Test
// %solid_key_seal();
// %key_hollow();
// #strakes();

// *******************************************************
// Code for the parts themselves


module key_seal()
{
   difference()
   {
      solid_key_seal();
      key_hollow();
   }
   intersection()
   {
      solid_key_seal();
      strakes();
   }
}

module solid_key_seal()
{

   if (bow_shape)
   {
      translate([-bow_width/2-c-w, -bow_length/2-c-w, 0])
      {
         cube([bow_width+2*c+2*w, bow_length+2*c+2*w, h+2*p+c+sh]);
      }
   }
   else
   {
      cylinder(r=rb+w+c, h=h+2*p+c+sh);
   }
   translate([-blade_width/2-c-w, 0, 0])
      {
         cube([blade_width+2*c+2*w, blade_length+w+rb+w+c, h+2*p+c+sh]);
      }
   cube([blade_width/2+shoulder_width+c+w, rb+shoulder_length+c+w, h+2*p+c+sh]);
}

module key_hollow()
{
   translate([0,0,p])
   {
      if (bow_shape)
      {
         translate([-bow_width/2-c, -bow_length/2-c, 0])
         {
            cube([bow_width+2*c, bow_length+2*c, h+c+sh]);
         }
      }
      else
      {
         cylinder(r=rb+c, h=h+c+sh);
      }
      translate([-blade_width/2-c, 0, 0])
      {
         cube([blade_width+2*c, some_distance, h+c+sh]);
      }
      cube([blade_width/2+shoulder_width+c, rb+shoulder_length+c, h+c+sh]);
   }
   translate([ring_hole_offset, -rb + ring_hole_land + ring_hole_diameter/2,-ms])
   {
      cylinder(d=ring_hole_diameter, h=h+2*p+c+sh+2*ms);
   }
}


module strakes()
{

   translate([-rb-c-w,-kw-c-w,h+p+c])
   {
      for (so=[0:5*nw: blade_length+w+2*rb+2*w+2*c])
      {
         translate([0,so,0])
         {
            cube([2*rb+2*c+2*w, nw, lh]);
         }
      }

      translate([0,0, lh])
      {
         for (st=[0:5*nw: 2*rb+2*w+2*c])
         {
            translate([st, 0, 0])
            {
               cube([nw, blade_length+w+2*rb+2*w+2*c, lh]);
            }
         }
      }
   }
}
