// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Parametric hex-grid bottle tray
//
// copyright 2017--2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Loosely based on thingiverse thing  1345795,
// https://www.thingiverse.com/thing:1345795
// by Ian Pegg, https://www.thingiverse.com/deckingman/about
// CC-BY, Feb 2016
// And using an idea (the holes) by Tomas Ebringer
// https://www.thingiverse.com/Shii/about
// https://www.thingiverse.com/thing:1751410
// CC-BY, Sep 2016



// All length are in mm.
bottle_diameter = 56;  // [8:0.1:90]

// Number of bottles in a long (odd) row.  Every other (even) row is one position shorter.
x_count = 3;  // [2:1:10]
// Number of rows.
y_count = 2;  //   // [2:1:10]
// Change the basic shape of one holder
honeycombish = 0;  // [1:Use hexagons, 0:Use circles]
// Height of the walls of the holders
height = 18; // [8:0.1:90]
// Size of the hole in the bottom of each holder. 0 for no hole, larger than the diameter for just cylinders
hole_diameter = 30; // [0:0.1:91]

// Make grooves at the bottom to fit this onto the shelfs of a fridge
with_fridge_grooves = 0;  //  [0: no grooves, 1: add grooves]

// Distance from one rod of the fridge shelf to the next.
grating_spacing = 18.4; // [5:0.1:40]

// Diameter of one of these rods or bars
grating_bar_width = 2.8;  //  [0.4:0.1:5]


preview = true;


module dummy()
{
   // My way to stop the Thingiverse customizer
}

// ***************************************************
// Change these if you have to
bottom_height = 1.2;  // How thick (mm) the bottom will be
// Will end up as a multiple of your layer height after slicing.
// Use enough top and bottom solid layers. Getting infil here is kind-of pointles.

wall_width = 1.8;  // how thick the walls will be (mm).
min_wall_width = 0.85;  // Your nozzle diameter

cs = 0.4; // Space added to the bottle diameter.
// Increase for looser fit and for shrinking prints.


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


be = (with_fridge_grooves) ? 2*bottom_height : bottom_height;

// ***************************************************
// Change below only if you know what you are doing.

r_i = bottle_diameter/2 + cs;
r_h = hole_diameter/2;
r_o = r_i + wall_width;

x_step = 2*r_i+min_wall_width;
thf = sqrt(3)/2;  // (equilateral) triangle height factor
y_step = x_step*thf;

ms = 0.02; // Muggeseggele. To make the quick renderer work a little better.

difference()
{
   full_shape();
   holes();
   if (with_fridge_grooves)
   {
      grooves();
   }
}


module full_shape()
{
   for (y_c = [0:y_count-1])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_cylinder(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_cylinder((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}


module holes()
{
   for (y_c = [0:y_count-1])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_hole(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_hole((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}



module one_hole(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      translate([0, 0, be])
      {
         cylinder(r=r_i, h=height);
      }
      if (hole_diameter)
      {
         translate([0,0, -ms])
         {
            if (honeycombish)
            {
               rotate(30)
               {
                  cylinder(r=r_h/thf, h=be+2*ms, $fn=6);
               }
            }
            else
            {
               cylinder(r=r_h, h=be+2*ms);
            }
         }
      }
   }
}

module one_cylinder(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      if (honeycombish)
      {
         rotate(30)
         {
            cylinder(r=r_o/thf, h=height, $fn=6);
         }
      }
      else
      {
         cylinder(r=r_o, h=height);
      }
   }
}


module grooves()
{
   de = 2*r_i+wall_width;
   hrl = ceil((r_i+wall_width+grating_bar_width)/grating_spacing) + 1;
   hrr = ceil((r_i+2*wall_width+grating_bar_width+(y_count-1)*y_step)/grating_spacing) + 1;
   // The count are too high more or less on purpose. Works fine to
   // subtract a few of them from nothing.

   for (o=[-hrl:hrr])
   {
         echo(o);
         translate([(x_count-1)*de*0.5, (o+0.5)*grating_spacing, 0])
         {
            cube([2*(r_i+wall_width+cs+grating_bar_width+ms)+(x_count-1)*de, grating_bar_width, 2*bottom_height], center=true);
         }
      }

}
