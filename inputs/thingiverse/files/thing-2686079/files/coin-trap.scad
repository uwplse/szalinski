// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Coin trap
//
// customizable coin traps
// Copyright 2013 mathgrrl
// Copyright 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA-NC 4.0

/* Parameters */



// The size of coin to trap, in millimetres. Start value is for a 1 Euro coin
coin_diameter = 23.3;  // [15:0.1:35]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]


/* [Hidden] */

// Done with the customizer

// *******************************************************
// Some shortcuts. These shouldn't be changed


// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
pfc = 15;
rfa = 180;
rfb = 30;
rfc = 15;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;
function fc() = (preview) ? pfc : rfc;


// other parameters based on the coin diameter
coin_radius = coin_diameter/2;
corner_radius = coin_diameter/10;
corner_distance=coin_radius-corner_radius+1;
cylinder_radius=coin_radius-1.5*corner_radius;
cylinder_bevel_distance=corner_distance+2*corner_radius;
cylinder_bevel_radius=cylinder_radius+corner_radius/2;
sphere_radius=coin_radius+1;

//////////////////////////////////////////////////////////////////////////
// RENDERS ///////////////////////////////////////////////////////////////

// build the trap
difference()
{
   box_hull();			// enclosing box area with rounded edges5
   cylinder_holes();	// three cylindrical holes
   cylinder_bevels(); 	// six spherical holes to bevel the holes
   sphere_hole();		// one spherical hole for coin clearance
}

//////////////////////////////////////////////////////////////////////////
// MODULES ///////////////////////////////////////////////////////////////

// overall rounded cube shape
module box_hull()
{
   hull()
   {
      translate([corner_distance,corner_distance,corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([-corner_distance,corner_distance,corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([corner_distance,-corner_distance,corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([corner_distance,corner_distance,-corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([-corner_distance,-corner_distance,corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([-corner_distance,corner_distance,-corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([corner_distance,-corner_distance,-corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
      translate([-corner_distance,-corner_distance,-corner_distance])
      {
         sphere(corner_radius, $fn=fb());
      }
   }
}

// holes for the sides
module cylinder_holes()
{
   rotate([0,0,0])
   {
      translate([0,0,-(coin_radius+5)])
      {
         cylinder(coin_diameter+10,cylinder_radius,cylinder_radius, $fn=fa());
      }
   }
   rotate([90,0,0])
   {
      translate([0,0,-(coin_radius+5)])
      {
         cylinder(coin_diameter+10,cylinder_radius,cylinder_radius, $fn=fa());
      }
   }
   rotate([0,90,0])
   {
      translate([0,0,-(coin_radius+5)])
      {
         cylinder(coin_diameter+10,cylinder_radius,cylinder_radius, $fn=fa());
      }
   }
}

// beveling for the side holes
module cylinder_bevels(){
   translate([cylinder_bevel_distance,0,0])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
   translate([0,cylinder_bevel_distance,0])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
   translate([0,0,cylinder_bevel_distance])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
   translate([-cylinder_bevel_distance,0,0])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
   translate([0,-cylinder_bevel_distance,0])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
   translate([0,0,-cylinder_bevel_distance])
   {
      sphere(cylinder_bevel_radius, $fn=fa());
   }
}

// center hole to guarantee coin clearance
module sphere_hole()
{
   sphere(sphere_radius, $fn=fa());
}
