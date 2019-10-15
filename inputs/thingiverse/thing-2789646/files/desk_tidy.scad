// ////////////////////////////////////////////////////////////
//
// Modular desk tidy.
//
// Copyright 2018 Kevin F. Quinn
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License. To view a
// copy of the license, visit
// https://creativecommons.org/licenses/by-sa/4.0/
//
// History
// 2018-02-11 1.0 Initial publication
//
// A configurable modular desk tidy.
// Inspired by the Mew Mew system on Thingiverse (7007, 289516, 1723801)
// 

// Essential design is a hexagon base, interlocking slots and bars.
//
// Configure the diameter, height, wall thickness, and how high the
// slot/lugs are.
//
// Choose whether you want a lug or a slot (or nothing) on each face
// with the six face parameters.
//
// Simplest way to ensure all the pieces can interlock is to used
// the defaults here, and orient all the pieces with the three slot
// faces towards you for assembly - the front faces of your set will
// have the redundant slots, and the rear faces the redundant lugs.
//
// To get a set that present plain faces on all the external edges
// of the assembled set, generate each piece with the set of lugs and
// slots that suffice. Hint - to ensure your set is actually possible
// to assemble, the simplest approach is to follow the same pattern;
// for each individual piece, select slots for the connecting faces
// that are towards the front, and lugs for the connecting faces
// that are towards the back.

// Diameter of the base hexagon (i.e. vertex to opposing vertex)
module_diameter=55; // [10:140]

// Height of the module
module_height=20; // [20:10:100]

// Thickness of the module walls
module_wall=2; // [0.8:0.4:2.4]

// Lug/slot height
slot_height=18; // [2:2:40]

// Clearance to allow between slots and the lugs
clearance=0.3; // [0.1:0.05:0.4]

// Configuration of first side; whether it is plain, has a lug, or has a slot
face_1="lug"; // ["plain","lug","slot"]
// Configuration of second side, as the first
face_2="lug"; // ["plain","lug","slot"]
// Configuration of third side, as the first
face_3="lug"; // ["plain","lug","slot"]
// Configuration of fourth side, as the first
face_4="slot"; // ["plain","lug","slot"]
// Configuration of fifth side, as the first
face_5="slot"; // ["plain","lug","slot"]
// Configuration of sixth side, as the first
face_6="slot"; // ["plain","lug","slot"]

module endcustomizer() {}
sp=0.1; // spill distance for differences (just keeps the preview clean)


module tidy(diameter, height, wall, fv) {

  distance_to_edge=(diameter/2)*cos(30);

  difference() {
    
    union() {
      difference() {
      // main hexagonal tower
      cylinder(d=diameter, h=height, $fn=6);
      // centre    
      translate ([0,0,wall])
      cylinder(d=diameter-wall*2, h=height-wall+sp, $fn=6);
      }
      // lugs
      for (face=[0:1:5]) {
        if (fv[face]=="lug") {
          rotate(a=30+face*60,v=[0,0,1]) {
            translate([distance_to_edge,-wall/2,0])
            cube([wall+clearance,wall,slot_height]);
            translate([distance_to_edge+wall+clearance,0,0])
            scale([1.0,1.5,1.0])
            difference() {
              cylinder(r=wall, h=slot_height, $fn=90);
              translate([-wall,-wall,-sp])
              cube([wall,wall*2,slot_height+sp*2]);
            }
          }
        }
      }
    }

    // slots
    for (face=[0:1:5]) {
      if (fv[face]=="slot") {
        rotate(a=30+face*60,v=[0,0,1]) {
          translate([distance_to_edge-wall-sp,-wall/2-clearance,-sp])
          cube([wall+sp*2,wall+clearance*2,slot_height+clearance+sp]);
          translate([distance_to_edge-wall,0,-sp])
          scale([1.0,1.5,1.0])
          difference() {
            cylinder(r=wall+clearance, h=wall+sp*2, $fn=90);
            translate([clearance,-wall-clearance,0])
            cube([wall+clearance,(wall+clearance)*2,wall+sp*2]);
          }
        }
      }
    }
  }

}

tidy(diameter=module_diameter,
     height=module_height,
     wall=module_wall,
     fv=[face_1,face_2,face_3,face_4,face_5,face_6]);
