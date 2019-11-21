// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Simple wedge generator
//
// Written by Roland Sieker <ospalh@gmail.com>, 2017
// Licence: CC-0
// Have fun.

//
length = 50; // [1:0.1:200]
width = 20; // [1:0.1:200]
height = 20; // [1:0.1:200]
// The height of the sharp end. Typically 0
height_2 = 0; // [0:0.1:190]



module wedge()
{
   translate([0,width/2,0])
   rotate([90,0,0])
   {
      linear_extrude(width)
      {
         polygon([[-length/2,0], [length/2,0], [length/2,height], [-length/2,height_2]]);

      }
   }
}

wedge();
