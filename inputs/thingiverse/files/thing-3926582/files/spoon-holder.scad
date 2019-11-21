// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// tea spoon holder
//
// (c) 2018-2019 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

/* [Global] */

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Sizes] */

// Diameter of the dish
dish_d = 50;  // [30:0.5:240]
// Hight of the dish
dish_h = 5; // [5:0.25:24]
grip_width = 8; // [3:0.1:20]
grip_thickness = 3.6; // [1:0.1:20]
holder_length = 30; // [5:1:50]

/* [Hidden] */

// Done with the customizer

// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
// p = 1.2;  // Bottom, top plate hight
c = 1;  // Clearance
dish_angle = 60; // Overhangs much below 60 degrees are a problem for me
r_r = 4;  // rounding radius, dish
// For the spoon rest thing we use w as rounding radius.
spoon_angle = 15;
g_thick = grip_thickness + c;
g_w = grip_width + c;

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(dish_angle);
// To get from a hight to a horizontal width inclined correctly
z_factor = tan(dish_angle);  // The other way around

r_d = dish_d/2;
r_a = r_r + w;
r_m = r_r + w/2;

x_k = r_m * sin(dish_angle);
h_k = r_m * (1 - cos(dish_angle));
h_r = dish_h - h_k - w;
x_r = h_r * xy_factor;
l_r = sqrt(h_r*h_r+x_r*x_r);
r_z = r_d - x_r - x_k;

some_distance = 50;
ms = 0.01;  // Muggeseggele.

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

full_holder();

// holder();
// dish();
// 2d_dish();
// holder();
// upright_holder();

// *******************************************************
// Code for the parts themselves


module full_holder()
{
   difference()
   {
      union()
      {
         shift_and_cut()
         {
            massive_holder();
         }
         dish();
      }
      shift_and_cut()
      {
         holder_hollow();
      }
   }
}

module shift_and_cut()
{
   translate([0,-w-g_thick/2-r_d,0])
   {
      intersection()
      {

         rotate([-spoon_angle,0, 0])
         {
            children();
         }
         translate([0,0,2*holder_length])
         {
            cube(4*holder_length, center=true);
         }

      }
   }
}


module massive_holder()
{
   hull()
   {
      translate([0,0,holder_length+w])
      {
         translate([g_w/2, g_thick/2, 0])
         {
            sphere(r=w);
         }
         translate([-g_w/2, g_thick/2, 0])
         {
            sphere(r=w);
         }
         translate([g_w/2, -g_thick/2, 0])
         {
            sphere(r=w);
         }
         translate([-g_w/2, -g_thick/2, 0])
         {
            sphere(r=w);
         }
      }
      translate([0,0,-w])
      {
         translate([g_w/2, g_thick/2, 0])
         {
            cylinder(r=w, h=ms);
         }
         translate([-g_w/2, g_thick/2, 0])
         {
            cylinder(r=w, h=ms);
         }
         translate([g_w/2, -g_thick/2, 0])
         {
            cylinder(r=w, h=ms);
         }
         translate([-g_w/2, -g_thick/2, 0])
         {
            cylinder(r=w, h=ms);
         }

      }
   }
}

module holder_hollow()
{
   translate([0,0,holder_length/2+2*w])
   {
      cube([g_w, g_thick, holder_length+2*w], center=true);
   }
}



module dish()
{
   rotate_extrude()
   {
      2d_dish();
   }
}


module 2d_dish()
{
   square([r_z,w]);
   translate([r_z-ms,r_a])
   {
      difference()
      {
         circle(r=r_a);
         circle(r=r_r);
         translate([-1.5*r_a,0])
         {
            square(3*r_a, center=true);
         }
         rotate(dish_angle)
         {
            translate([0,-r_r-w-ms])
            {
               square([r_a+ms,r_r+r_a+w+ms]);
            }
         }
      }
   }

   translate([r_z+x_k, w/2+h_k])
   {
      rotate(dish_angle)
      {
         translate([-ms, -w/2])
         {
            square([l_r+2*ms,w]);
         }
      }
   }
   translate([r_d,dish_h-w/2])
   {
      circle(r=w/2);
   }
}
