//
// Original code from Matt Stultz's
// Parametric Mirror Clip
// http://www.thingiverse.com/thing:16845
//
// Mods by Rob Lazure, May 26, 2015
// added overhang for different mirror borders
//     countersink screw option for #6 flat head dry wall screws
//   -------------------------------------------
//   modified to have 0.5 mm increments in the sliders
//   Aug 9, 2018
//   -------------------------------------------

///// inputs ////////////////

// How thick is the mirror?
MirrorThickness = 5; // [2:0.5:12]

// Holding over the mirror
Overhang = 6; // [2:0.5:15]

// Do you want to use a countersink for the screw?
countersink = "yes"; // [yes,no]

///////////////////////////////

/* [Hidden] */
use <MCAD/boxes.scad>;  // for Thingiverse
// include  <mcad/boxes.scad>;  // for Openscad on PC

ScrewDiameter = 5;
ScrewBlock = 15;
ClipThickness = 5;

BoxLength= ScrewBlock + Overhang;
CenterPos = BoxLength/2;
Shift =  CenterPos - ScrewBlock;
countersinkheight = (ClipThickness + MirrorThickness)/2 ;


include  <mcad/boxes.scad>;  // for Openscad

// Clip without the countersink - keeping a 15 x 15 area for the screw
module clip()
{
difference()
{
 translate([Shift,0,0])roundedBox([ScrewBlock+Overhang,14,ClipThickness+MirrorThickness],4,true);
translate([-7.5,0,0]) cylinder(ClipThickness+MirrorThickness+1,ScrewDiameter/2,ScrewDiameter/2,true);
translate([8,0,ClipThickness/2]) cube([16,15,MirrorThickness],center=true);
    translate([0,-7.5,(ClipThickness+MirrorThickness)/2-1]) cube([16,15,2],center=false); // trim for presentation
}
}
module printClip()
{

if (countersink=="yes")
 { 
    difference() {

        clip();
        translate([-7.5,0,-countersinkheight]) cylinder(h=5, r1=5, r2=ScrewDiameter/2, center= false,$fn=10);
}
} 
    else clip();
}
  
// orient for the slicer plate
 translate([0,0,(ClipThickness+MirrorThickness)/2]) printClip();