// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Another tea portioner.
//
// The same pot, funnel and striker, and chute principle as the first, but
// using a number of design lessons i've since learned, and some new ideas.
//
// Copyright 2017 - 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// ... to preview. You will get all three parts when you click "Create Thing".
part = "portioner"; // [portioner: portioner cup, funnel: funnel/striker, stand: stand]

// Cubic centimetres
volume = 42;  // [8:1:150]
// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

// Size of the stand. Set this to 0 to just get a tray to keep the portioner clean for the striking. In mm.
stand_diameter = 80;  // [0:1:100]

// Size of the funnel at the top. Adjust this to how good your tea tossing aim is. :)  In mm.
funnel_diameter = 90;  // [30:1:120]

/* [Hidden] */

// *******************************************************
// Some more values that can be changed

h_in_r = 1;  // Height of the cylinder in radiuses. Tweaked by hand

w = 1.8;  // wall width for the horizontal flanges
p = 1.2;  // height of the bottomt plate
w_i = 1.2;  // Internal wall width. The bit between the two circular holes
w_f = 1.8;  // Wall for the funnel. I had some problems with varying wall widths, but fixed it otherwise.
stand_height = 15;
flange_height = 10;
stand_peg_height = 2;

chute_limit_diameter = 20;  // Make a hole at least this big
chute_limit_factor = 0.3;  // ... or at least this part of the top hole

ms = 0.1;  // Muggeseggele.

clearance = 0.5;  // mm for the parts that should fit into each other

funnel_angle = 60;  //

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference/r

// Somewhat comprehensible math to get r from V
// V = 1/2 (V sphere) + V cylinder
// V = 1/2 * (2tau r^2 * 1/3 r) + 1/2 tau r^2 * h
//
// (The V = 2tau/3 * r^2 can be split in 2tau r^2 * 1/3 r: think of infinitesimal
// pyramids with the base area of the surface area of a sphere, 2tau r^2, and
// the Volume of base area * 1/3 h, with h = r.)
// (Similarly, the area of a circle can be seen as a rectangle of
// infinitesimal circle sectors, with the outer bit alternatively at the
// top and bottom. That gives the area as r * 1/2 circumference, or r *
// 1/2tau r. No argument against tau or for pi.)
//

r_cm = pow(volume/(tau/3+tau/2*h_in_r),1/3);
r = r_cm * 10;  // Volume is done in ml, the rest of OpenSCAD uses mm.
// (And you don't uses mm^3 a.k.a. microlitre in everyday settings.)

r_1 = r + w_f;  // outer diameter, striker
r_2 = r_1 + clearance; // inner size of the measuring cup flange
r_3 = r_2 + w; // outer size of the measuring cup
r_4 = r_3 + clearance;  // inner size of the stand tray
r_5 = r_4 + w;  // outer size of the stand tray

d_cc = 2*r + w_i;  // distance cylinder cylinder

r_cb_i = max(r*chute_limit_factor, chute_limit_diameter/2);
r_cb = min(r_cb_i, r);
r_cb_0 = r_cb - clearance;

r_f = funnel_diameter/2;
d_ftb = r_f-r_1;
h_f = d_ftb / tan(90-funnel_angle);  // Funnel height
h_fg = flange_height+clearance;  // funnel grip height

some_distance = max(2*r_5,stand_diameter/2+r_3) + 10;

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
rfa = 180;
rfb = 30;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();

// I used this cylinder as a modifier to set the infill to higher
// values under the central bit of the portioner sphere, to get less
// sag.
// cylinder(r=0.7*r, h=r,$fn=fa());


module print_part()
{
   if ("portioner" == part)
   {
      portioner();
   }
   if (part == "funnel")
   {
      funnel();
   }
   if (part == "stand")
   {
      stand();
   }
}

module preview_parts()
{
   portioner();
   translate([r_4+d_cc+funnel_diameter/2+10, 0, 0])
   {
      funnel();
   }
   translate([0, some_distance, 0])
   {
      stand();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stand();
      }
      translate([0,0,w+2*ms])
      {
         color("red")
         {
            portioner();
         }
      }
      translate([0,0,w+2*ms + r*(h_in_r + 1) + w + ms ])
      {
         color("black")
         {
            funnel();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module portioner()
{
   difference()
   {
      portioner_body();
      portioner_hollow();
   }
   translate([d_cc-w-clearance, 0, (1+h_in_r)*r])
   {
      translate([0, r_2+w/2, 0])
      {
         cylinder(d=w, h=flange_height+p, $fn=fb());
      }
      translate([0, -r_2-w/2, 0])
      {
         cylinder(d=w, h=flange_height+p, $fn=fb());
      }
   }
}


module funnel()
{
   difference()
   {
      funnel_body();
      funnel_hollow();
   }

   translate([d_cc, 0, 0])
   {
      translate([0, r+w_f/2, 0])
      {
         cylinder(d=w_f, h=h_fg+ms, $fn=fb());
      }
      translate([0, -r-w_f/2, 0])
      {
         cylinder(d=w_f, h=h_fg+ms, $fn=fb());
      }
   }

}


module stand()
{
   difference()
   {
      union()
      {
         stand_base();
         ccc(r_5, stand_height, w+clearance, 0);
      }
      ccc(r_4, stand_height, w+clearance, p+ms);
   }
   translate([d_cc, 0, p])
   {
      cylinder(r=r_cb_0, h=stand_peg_height, $fn=fa());
   }
}

module portioner_body()
{
   ccc(r_3, r*(h_in_r+1)+p+flange_height, w+clearance, 0);
}


module portioner_hollow()
{
   // Measuring hollow
   translate([0, 0, r+p])
   {
      sphere(r=r, $fn=fa());
      cylinder(r=r, h = r*h_in_r + ms, $fn=fa());
   }
   // chute
   translate([d_cc, 0, -ms])
   {
      cylinder(r1=r_cb, r2=r, h=r*(h_in_r+1)+p + 2*ms, $fn=fa());
   }
   // funnel flange hollow
   ccc(r_2, flange_height+ms, w+clearance, r*(h_in_r+1)+p);
   translate([0,0,0])
   {
      translate([d_cc-w-clearance, -r_5, r*(h_in_r+1)+p])
      {
          cube([2*r_2, 2*r_5, flange_height+ms]);
      }
   }
}


module funnel_body()
{
   // almost a ccc, w/o the last cylinder
   cylinder(r=r_1, h=h_fg+ms, $fn=fa());
   translate([0, -r_1, 0])
   {
      cube([d_cc, 2*r_1, h_fg+ms]);
   }
   translate([0, 0, h_fg])
   {
      cylinder(r1=r_1, r2=funnel_diameter/2+w_f, h=h_f, $fn=fa());
   }
}


module funnel_hollow()
{
   translate([0, 0, -ms])
   {
      cylinder(r=r, h=flange_height+clearance+3*ms, $fn=fa());
   }
   translate([0, 0, flange_height+clearance])
   {
      // N.B.: now ms here. Necessary for a consistant wall width.
      cylinder(r1=r, r2=funnel_diameter/2, h=h_f, $fn=fa());
   }
   translate([d_cc, 0, -ms])
   {
      cylinder(r=r, h=flange_height+clearance+3*ms, $fn=fa());
   }
   // Just for the preview
   translate([0, 0, flange_height+clearance+h_f-ms])
   {
      cylinder(d=funnel_diameter-2*ms, h=2*ms, $fn=fa());
   }
}

module stand_base()
{
   translate([r+0.5*w, 0, 0])
   {
      cylinder(d=stand_diameter, h=p, $fn=fa());
      translate([0,0,p])
      {
         cylinder(d1=stand_diameter, d2=2*r_5, h=stand_height-w, $fn=fa());
      }
   }

}

module ccc(r_i, h_i, o_x, o_z)
{
   // The cylinder cube cylinder combo used several times
   translate([0,0, o_z])
   {
      cylinder(r=r_i, h=h_i, $fn=fa());
      translate([d_cc-o_x, 0, 0])
      {
         cylinder(r=r_i, h=h_i, $fn=fa());
      }
      translate([0, -r_i, 0])
      {
         cube([d_cc-o_x, 2*r_i, h_i]);
      }
   }
}
