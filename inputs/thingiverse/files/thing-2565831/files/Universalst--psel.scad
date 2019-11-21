// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Universalstoepsel. Aus flexiblem Filament zu drucken
//
// Copyright 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// Basically the inner diameter of the bottle (glass, whatever)
stopper_diameter = 8.0; // [5:0.1:90]
// The height of the conical part
stopper_height = 5;  // [2.5:0.1:60]
//
flange_height = 2.4; // [1.8:0.1:15]
flange_width = 3.2;  // [1.8:0.1:24]

// Add a notch for a string, rubber band or similar
with_notch = 0; // [0:No, 1:Yes]
// Radius of the string notch
notch_r = 1.2;  // [0.1:0.1:3]

// Make the stopper elliptical by scaling it in only one direction:
elliptical = 0;  // [0:No, 1:Yes]
// Ratio semi-minor axis/semi-major axis
axis_ratio=0.75;  // [0.2:0.05:1]


/* [Hidden] */

r_f = 1.2;  // filleting radius
r_r = 0.4;  // rounding radius

r_o = stopper_diameter/2 - 0.7 * r_f;
r_u = r_o * 0.6;
r_k = stopper_diameter/2 + flange_width;


h = stopper_height;
h_g = h + flange_height;


// a_fn = 60; b_fn = 20;  // draft
a_fn = 270; b_fn = 45;  // final

if (elliptical)
{
   if (with_notch)
   {
      elliptischer_stoepsel_mit_nut();
   }
   else
   {
      elliptischer_stoepsel();
   }
}
else
{
   if (with_notch)
   {
      stoepsel_mit_nut();
   }
   else
   {
      stoepsel();
   }
}




module elliptischer_stoepsel_mit_nut()
{
   difference()
   {
      elliptischer_stoepsel();
      notches(r_k*axis_ratio);
   }
}


module elliptischer_stoepsel()
{
   scale([axis_ratio, 1, 1])
   {
      stoepsel();
   }
}

module stoepsel_mit_nut()
{
   difference()
   {
      stoepsel();
      notches(r_k);
   }
}


module stoepsel()
{
   translate([0,0,h+flange_height])
   {
      mirror([0,0,1])
      {
         rotate_extrude($fn=a_fn)
         {
            stoepsel_form();
         }
      }
   }
}

module stoepsel_form()
{
   rot_points = [
      [0, 0],
      [r_u-r_r, 0],
      [r_u-r_r, r_r],
      [r_u, r_r],
      [r_o, h-r_f],
      [r_o, h],
      [r_k-r_r, h],
      [r_k-r_r, h+r_r],
      [r_k, h+r_r],
      [r_k, h+flange_height-r_r],
      [r_k-r_r, h+flange_height-r_r],
      [r_k-r_r, h+flange_height],
      [0, h+flange_height],
      ];
  polygon(rot_points);
  translate([r_u-r_r, r_r])
  {
     circle(r=r_r, $fn=b_fn);
  }
  translate([r_o, h-r_f])
  {
     difference()
     {
        square([r_f, r_f]);
        translate([r_f,0])
        {
           circle(r=r_f, $fn=b_fn);
        }
     }
  }
  translate([r_k-r_r, h+r_r])
  {
     circle(r=r_r, $fn=b_fn);
  }
  translate([r_k-r_r, h+flange_height-r_r])
  {
     circle(r=r_r, $fn=b_fn);
  }
}


module notches(w)
{
   rotate([0, 90, 0])
   {
      cylinder(r=notch_r, h=2*w, center=true, $fn=b_fn);
   }
   z_notch();
   mirror()
   {
      z_notch();
   }
   module z_notch()
   {
      translate([w, 0, 0])
      {
         cylinder(r=notch_r, h=h_g, $fn=b_fn);
      }
   }
}
