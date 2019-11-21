// A fully parameterized vial rack
//   Author: Nick Wells
// Revision: 1.0 16/06/2006 Initial release
// http://customizer.makerbot.com/docs

// All units in mm
// vial stand

// Number of Vials
number_of_vials = 4; //[1:1:20]

// Vial Spacing
vial_spacing    = 15; // [15:1:50]

// Stand Height
stand_height    = 40; // [20:1:100]

// Render Quality
$fn=50;

/* [Hidden] */
slot_width      = 11;
mink            = 1;

rotate([180,0,0])VialRack();
module VialRack()
{
  difference()
  {
    Stand();
    Vials();
  }
}
module Stand()
{
  difference()
  {
    stand_body();
    stand_cutout();
  }
}

module stand_body()
{
  minkowski()
  {
    hull()
    {
      cylinder(h=stand_height,d=vial_spacing);
      translate([0,vial_spacing*(number_of_vials-1),0])cylinder(h=stand_height,d=vial_spacing);
     
      // Base
      translate([0,0,stand_height])hull()
      {
        cylinder(h=0.1,d=vial_spacing*1.5);
        translate([0,vial_spacing*(number_of_vials-1),0])cylinder(h=0.1,d=vial_spacing*1.5);
      }
    }
    sphere(mink);
  }
}
module stand_cutout()
{
  // Y Slots
  hull()
  {
    translate([0,(vial_spacing/2)*(number_of_vials-1),slot_width])rotate([90,0,00])cylinder(d=slot_width,h=vial_spacing*(number_of_vials-1),center=true);
    translate([0,(vial_spacing/2)*(number_of_vials-1),stand_height-slot_width])rotate([90,0,0])cylinder(d=slot_width,h=vial_spacing*(number_of_vials-1),center=true);
  }
  
  
  for (v = [0:number_of_vials-1])
  {
    // Holes
    hull()
    {
      translate([0,vial_spacing*v,slot_width/2+2])rotate([90,0,90])cylinder(d=slot_width,h=vial_spacing*2,center=true);
      translate([0,vial_spacing*v,stand_height-slot_width/2-2-mink])rotate([90,0,90])cylinder(d=slot_width,h=vial_spacing*2,center=true);
    }
  }
}

module Vial()
{
  vrim = 12.75;
  vdia = 11+0.5;
  vdep = 25;
  vtip = 4;
  $fn=100;
  // cap
  render()color("grey")
  {
    cylinder(d=vrim,h=6);
    // rim
    translate([0,0,7])cylinder(d=vrim,h=1);
    hull()
    {
      // body
      cylinder(d=vdia,h=vdep);
      // tip
      translate([0,0,45])sphere(vtip/2);
    }
  }
}
module Vials()
{
  for (v = [0:number_of_vials-1])
  {
    translate([0,vial_spacing*v,-8-mink])render()Vial();
  }
}

