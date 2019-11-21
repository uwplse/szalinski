/*
Customizable Soldering Jig For Soldering PCBs With Alignment Holes
Author: Brian Khuu (2019)

If you use alignment pins in your project to help align your castellation modules with your PCB, you may find this useful.

Defaults below assumes you are using a 1mm alignment pins.

*/
$fn=20;

/* Overall */

// Tolerance
tol=0.6;

// Base Thickness
base_thickness=0.5;

/* Alignment Pin */

// Diameter of the alignment pin
CONFIG_pindia=1;

// Outer Diameter of the alignment pin
CONFIG_pindiaouter=3;

// Alignment Pin bottom flange Depth
CONFIG_pindepth=5;

/* Alignment Pins and Non Alignment Pins */

// Alignment Pins Positions
align_pin_pos_entries = [
[3.302   , 5.4864 ],
[2.5908  , 52.8828],
[27.5336 , 54.7624],
[27.2288 , 5.4864 ]
];

// Non Alignment Pins Positions
non_alignment_pin_pos_vec = [
[27.5336/2 , 100 ],
[27.5336/2 , 90  ]
];

/* Calc */
pindia      = CONFIG_pindia      + tol;
pindiaouter = CONFIG_pindiaouter      ;
pindepth = CONFIG_pindepth      ;

// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Add_all_values_in_a_list
function add(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;

difference()
{
  union()
  {
    /* Alignment Pins */
    hull()
    for(pin_pos = align_pin_pos_entries)
    {
      translate([pin_pos[0], pin_pos[1], 0]) 
        cylinder(r=pindiaouter, base_thickness);
    }

    for(pin_pos = align_pin_pos_entries)
    {
      translate([pin_pos[0], pin_pos[1],  base_thickness]) 
        cylinder(r1=pindiaouter, r2=pindiaouter/2, pindepth);
    }

    /* Non Alignment Pins */
    hull()
    {
      sumx=add( [ for(pin_pos = align_pin_pos_entries)  pin_pos[0] ] );
      sumy=add( [ for(pin_pos = align_pin_pos_entries)  pin_pos[1] ] );
      translate([sumx/len(align_pin_pos_entries), sumy/len(align_pin_pos_entries), 0])
        cylinder(r=pindiaouter, base_thickness);

      for(pin_pos = non_alignment_pin_pos_vec)
      {
        translate([pin_pos[0], pin_pos[1],  0]) cylinder(r=2, base_thickness);
      }
    }

    for(pin_pos = non_alignment_pin_pos_vec)
    {
      translate([pin_pos[0], pin_pos[1],  0]) cylinder(r1=2, r2=1, base_thickness+pindepth);
    }
  }

  /* Holes for the Alignment Pins*/
  for(pin_pos = align_pin_pos_entries)
  {
    translate([pin_pos[0], pin_pos[1], base_thickness]) 
      cylinder(r=pindia/2, base_thickness+100);
    translate([pin_pos[0], pin_pos[1], pindepth-1]) 
      cylinder(r1=pindia/2, r2=pindia/2 + 0.2, 2);
  }
}