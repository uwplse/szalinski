/*
 * Tube adapter
 * (c) 2018 Greizgh
 * License: CC-BY-SA
 */

// Geometry resolution
$fn=50;

/* [Outer shape] */
// Length of first section in mm
l1=40;
// First diameter in mm
d1=39;
// Second diameter in mm
d2=39;
// Length of second section in mm
l2=10;
// Third diameter in mm
d3=49;
// Length of final section in mm
l3=20;
// Final diameter in mm
d4=30; 

/* [Inner shape] */
// Inner diameter in mm
inner_diameter=24;
// Inner recess: length of the first section in mm
recess_l1=10; 
// Inner recess: max diameter of the first section in mm
recess_d1=30;
// Inner recess: length of the second section in mm
recess_l2=35;
// Inner recess: diameter of the second section in mm
recess_d2=35;
// Length of the final section in mm
recess_l3=10;
// Recess start, relative to the collar in mm
recess_offset=5;

/* [Slots] */
// width of a slot in mm
slot_width=5;
// Number of slots
slot_count=5;
// Start of the slot, relative to the collar in mm
slot_offset=5;

/* [Collar] */
// External diameter of the collar in mm
collar_diameter=54;
// Collar height in mm
collar_height=5;

// Tube adapter
module adapter(
    // External shape parameters
    l1=40, // Length of first section
    d1=39, // First diameter
    d2=39, // Second diameter
    l2=10, // Length of second section
    d3=40,
    l3=20, // Length of final section
    d4=30,
    // Inner shape parameters
    innerD=23, // Inner diameter
    // Inner recess
    il1=10, // Length of the first section
    id1=28, // max diameter of the first section
    il2=35, // Length of the second section
    id2=28,
    il3=10, // Length of the final section
    recessOffset=5, // Recess start, relative to the collar
    // slots
    slotW=5, // Slot width
    slotN=5, // Slot number
    slotOffset=5, // Start of the slot, relative to the collar
    // Collar
    collarD=54, // External diameter of the collar
    collarH=5 // Height of the collar
    ) {
  difference() {
    union() {
      cylinder(h=collarH, d=collarD);
      translate([0, 0, collarH]) {
          cylinder(h=l1, d1=d1, d2=d2);
          translate([0, 0, l1]) cylinder(h=l2, d1=d2, d2=d3);
          translate([0, 0, l1+l2]) cylinder(h=l3, d1=d3, d2=d4);
      };
    }
    cylinder(h=2*(l1+l2+l3+collarH+2), d=innerD, center=true);
    for (i = [0:slotN-1]) {
        rotate([0, 0, i*360/slotN]) translate([0, -slotW/2, collarH+slotOffset]) cube(size=[max(d1, d2, d3, d4), slotW, l1+l2+l3+2]);
    }
    // Inside 
    union() {
        translate([0, 0, collarH+recessOffset]) cylinder(h=il1, d1=innerD, d2=id1);
        translate([0, 0, collarH+recessOffset+il1]) cylinder(h=il2, d1=id1, d2=id2);
        translate([0, 0, collarH+recessOffset+il1+il2]) cylinder(h=il3, d1=id2, d2=innerD);
    }
  };
}




adapter(
l1=l1,
d1=d1,
d2=d2,
l2=l2,
d3=d3,
l3=l3,
d4=d4,
innerD=inner_diameter,
il1=recess_l1,
il2=recess_l2,
id1=recess_d1,
id2=recess_d2,
il3=recess_l3,
recessOffset=recess_offset,
slotW=slot_width,
slotN=slot_count,
slotOffset=slot_offset,
collarD=collar_diameter,
collarH=collar_height
);