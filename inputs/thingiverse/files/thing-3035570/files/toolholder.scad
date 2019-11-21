// ////////////////////////////////////////////////////////////
//
// Ender 3 Tool Holder
//
// A simple tool holder that mounts onto the extruded aluminium
// profile, fits neatly to the top bar behind the right hand
// vertical brace, above the power supply.
//
// Copyright 2018 Kevin F. Quinn
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License. To view a
// copy of the license, visit
// https://creativecommons.org/licenses/by-sa/4.0/
//
// History
// 2018-08-05 1.0 Initial publication

/* Printing notes
 * --------------
 *
 * First, refine the profile_clearance value to get a nice snug
 * fit for the extrusion profile mating section. Select the
 * "profile only" piece to print and check quickly before
 * committing to printing the holder.
 *
 * The "small" variant holds all the supplied tools apart from
 * the spatula.
 *
 * The "large" variant also has capacity for the spatula.
 *
 * In both cases, print on its side with the profile face
 * sitting on the bed - no supports needed.
 */


// Select which part to generate - which kind of holder, or the profile-only test part
part=0; // [0:small - without spatula, 1:large - with spatula, 2:profile only]
// Clearance distance around the various tool holes
tool_clearance=0.3;
// Clearance distance for the extrusion profile - print the "profile only" piece to test quickly
profile_clearance=0.2;
// Corner radius of top part
corner_radius=2.0;
// Amount of extrusion profile to remove to accommodate the end cap (or set to 0 and just turn the end cap...)
holder_cap_size=0;

/* [Hidden] */

$fn=30;

PART_SMALL=0;
PART_LARGE=1;
PART_PROFILE=2;

keys_d=[4.5,3.5,3.0,2.5,2.0];
keys_size=1.0;
driver_dia=2.5;
driver_size=11.5;
spanners_w=[9.5,20];
spanner_d=2.0;
spatula_w1=38;
spatula_w2=24;
spatula_d1=1.0;
spatula_d2=8.0;
spatula_size_w=20;
spatula_size_d=15;
cutters_w=8.0;
cutters_d=22.0;

holder_w=40;
holder_d=[26,42,40];
holder_t=5;

roundness=0.2;

profile_size=20.0;
profile_edge_thickness=2.0;

c=profile_clearance;
c2=c*sqrt(2);

profile=[
  [0.0, -profile_edge_thickness],
  [0.0,0.0],
  [5.5,0.0],
  [7.0,1.5],
  [4.5,1.5],
  [7.0,4.0],
  [13.0,4.0],
  [15.5,1.5],
  [13.0,1.5],
  [14.5,0.0],
  [20.0,0.0],
  [20.0, -profile_edge_thickness]
];

offset=[
  [0.0,0.0],
  [0.0,-c],
  [c2,-c],
  [c2,c],
  [c2,c],
  [c2,-c],
  [-c2,-c],
  [-c2,c],
  [-c2,c],
  [-c2,-c],
  [0.0,-c],
  [0.0,0.0]
];

profile1=[
  for (p=[0:1:len(profile)-1]) [profile[p][0]+offset[p][0],profile[p][1]+offset[p][1]]
];

sp=0.1;
/*
5.5  1.5  6  1.5  5.5
______         _______
|   __\       /__    | 1.5
|   \2.5      2.5/   |
| |\ \          / /| | 2.5
\ | \ \________/ / | /
 \|  \    6     /  |/
...
 */

module slot_profile(h,x=0) {
  //color("green") linear_extrude(height=2) polygon(profile0);
  translate([0,0,profile_size])
  rotate(a=-90,v=[1,0,0])
  rotate(a=90,v=[0,0,1])
  translate([0,profile_edge_thickness-roundness,0])
  difference() {
    linear_extrude(height=h)
    offset(r=roundness) offset(delta=-roundness)
    //offset(r=-roundness) offset(delta=roundness)
    polygon(profile1);
    translate([0,-roundness,-sp])
    cube([profile_size,profile_size,x+sp]);
  }
}

function sum(n,s,k)=(n>0)?sum(n-1,s+k[n],k):(s+k[0]);

module blank_toolholder(depth) {
  slot_profile(holder_w,holder_cap_size);
  // main plate
  hull() {
    translate([0,0,profile_size-holder_t])
    cube([profile_edge_thickness,holder_w,holder_t]);
    for (y=[corner_radius,holder_w-corner_radius])
    translate([depth-corner_radius,y,profile_size-holder_t])
    cylinder(r=corner_radius,h=holder_t);
  }
  // Support brace underneath
  hull() {
    for (z=[roundness,profile_size-holder_t])
    for (y=[holder_w/4,holder_w*3/4])
    translate([0,y,z]) sphere(r=roundness);
    for (y=[holder_w*3/7,holder_w*4/7])
    translate([depth/3,y,profile_size-holder_t]) sphere(r=roundness);
  }
}

module hex_hole(d,l) {
  cylinder(d=d+tool_clearance*2,h=profile_size+sp*2);
  translate([0,0,profile_size])
  rotate(a=90,v=[0,1,0])
  cylinder(d=d+tool_clearance*2,h=2.5+d/2+sp);
}

module spatula_hole() {
  d=spatula_d1+tool_clearance*2;
  translate([-spatula_w1/2-tool_clearance,-spatula_d1/2-tool_clearance,-sp])
  cube([spatula_w1+tool_clearance*2,spatula_d1+tool_clearance*2,profile_size+sp*2]);
  hull() {
    translate([-spatula_w2/2-tool_clearance-d/2,0-sp])
    cylinder(d=d,h=profile_size+sp*2);
    translate([-spatula_w2/2-tool_clearance+spatula_d2/2-d/2,spatula_d2/2+tool_clearance-d/2,-sp])
    cylinder(d=d,h=profile_size+sp*2);
    translate([-spatula_w2/2-tool_clearance+spatula_d2/2-d/2,-spatula_d2/2-tool_clearance+d/2,-sp])
    cylinder(d=d,h=profile_size+sp*2);
    translate([spatula_w2/2+tool_clearance+d/2,0,-sp])
    cylinder(d=d,h=profile_size+sp*2);
    translate([spatula_w2/2+tool_clearance-spatula_d2/2+d/2,spatula_d2/2+tool_clearance-d/2,-sp])
    cylinder(d=d,h=profile_size+sp*2);
    translate([spatula_w2/2+tool_clearance-spatula_d2/2+d/2,-spatula_d2/2-tool_clearance+d/2,-sp])
    cylinder(d=d,h=profile_size+sp*2);
  }
  translate([0,0,profile_size-tool_clearance])
  scale([1.0,spatula_size_d/spatula_size_w,1.0])
  cylinder(d=spatula_size_w+tool_clearance*2,h=tool_clearance+sp);
}

module toolholder() {
  difference() {
    blank_toolholder(depth=holder_d[part]);
    // Hex key slots
    if (part==PART_SMALL) {
      // Along back edge
      for (key=[0:1:4]) {
        translate([holder_d[part]-2.5-keys_d[key]/2,holder_w-sum(key,0,keys_d)-key*2,-sp])
        hex_hole(d=keys_d[key]);
      }
    } else {
      // Along right hand side edge
      for (key=[0:1:4]) {
        translate([holder_d[part]-(sum(key,0,keys_d)+key*2)-spatula_size_d-profile_edge_thickness,2.5+keys_d[key]/2,-sp])
        rotate(a=-90,v=[0,0,1])
        hex_hole(d=keys_d[key]);
      }
    }
    
    // screw driver hole
    translate([driver_size/2+profile_edge_thickness/2,
               ((part==PART_LARGE)?holder_w/2:holder_w-driver_size/2-profile_edge_thickness),-sp]) {
      cylinder(d=driver_dia+tool_clearance*2,h=profile_size+sp*2);
      translate([0,0,profile_size+sp-tool_clearance])
      cylinder(d=driver_size+tool_clearance*2,h=tool_clearance+sp);
    }

    // Spanners
    if (part==PART_SMALL) {
      for (spanner=[0:1:1]) {
        translate([driver_size+(spanner_d+2)*spanner-tool_clearance,cutters_w+4-tool_clearance,-sp])
        cube([spanner_d+tool_clearance*2,spanners_w[spanner]+tool_clearance*2,profile_size+sp*2]);
      }
    } else {
      translate([driver_size,(holder_w-(profile_edge_thickness*2+cutters_w+spanner_d)),-sp])
      rotate(a=-30,v=[0,0,1])
      cube([spanners_w[0]+tool_clearance*2,spanner_d+tool_clearance*2,profile_size+sp*2]);

      translate([profile_edge_thickness*2,(max(keys_d)+profile_edge_thickness),-sp])
      rotate(a=30,v=[0,0,1])
      cube([spanners_w[1]+tool_clearance*2,spanner_d+tool_clearance*2,profile_size+sp*2]);
    }

    // Cutters
    translate([((part==PART_LARGE)?(holder_d[part]-spatula_size_d)/2-cutters_d/2:holder_d[part]/2-cutters_d/2),
    ((part==PART_LARGE)?(holder_w-profile_edge_thickness-cutters_w):profile_edge_thickness),-sp])
    cube([cutters_d,cutters_w,profile_size+sp*2]);

    // Spatula - only on large version
    if (part==PART_LARGE) {
      translate([holder_d[part]-spatula_size_d/2-profile_edge_thickness,holder_w/2,0])
      rotate(a=70,v=[0,0,1])
      spatula_hole();
    }

  }
}

if (part==PART_PROFILE) {
  rotate(a=90,v=[1,0,0])
  slot_profile(10);
} else {
  rotate(a=90,v=[1,0,0])
  toolholder();
}
