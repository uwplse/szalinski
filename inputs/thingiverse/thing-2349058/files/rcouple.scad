/* [Main Dimensions] */
// Outside diameter (mm) 
out_dia=50;
// Height (mm) 
height=45;
// Cut diameter (mm)
cut_dia=30;

/* [Inner Dimensions] */
// Inner diameter (mm) 
in_dia=21;
// Depth (mm)
in_depth=10; // [5,10,15,20,25]
/* [Options] */
//  Line segments for circles (3 for triangles, 6 for hex, etc.)
FN=100; // [3:1:25]
// Override line segement count (any positive value)
OFN=0;

$fn=OFN?OFN:FN;

/* [Hidden] */
Num_copies=2;
// Num_copies=1+0; // stop customizer from picking this up

for (i=[1:Num_copies])
translate([(i-1)*out_dia*3,0,0])
difference()
{
  cylinder(center=false,r=out_dia/2, h=height);
   translate([0,0,-1])
     cylinder(center=false,r=cut_dia/2,h=1+height-in_depth);
   translate([0,0,,height-in_depth])
     cylinder(center=false,r=in_dia/2,h=1+in_depth);
}/* [Main Dimensions] */
// Outside diameter (mm)
out_dia=50;
// Height (mm)
height=45;
// Cut diameter (mm)
cut_dia=30;

/* [Inner Dimensions] */
// Inner diameter (mm)
in_dia=21;
// Depth (mm)
in_depth=10; // [5,10,15,20,25]
/* [Options] */
// Line segments for circles (3 for triangles, 6 for hex, etc.)
FN=100; // [3:1:25]
// Override line segement count (any positive value)
OFN=0;

$fn=OFN?OFN:FN;

/* [Hidden] */
Num_copies=2;
// Num_copies=1+0; // stop customizer from picking this up

for (i=[1:Num_copies])
  translate([(i-1)*out_dia*3,0,0])
    difference()
    {
      union()
      {
      cylinder(center=false,r=out_dia/2, h=height);
      translate([-out_dia/2,-out_dia/2,height/2-height/8])
      cube([out_dia,out_dia,height/4]);
     }
  translate([0,0,-1])
  cylinder(center=false,r=cut_dia/2,h=1+height-in_depth);
  translate([0,0,,height-in_depth])
  cylinder(center=false,r=in_dia/2,h=1+in_depth);
  }