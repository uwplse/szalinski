/*

Revison Notes:
  RV0: 
    * remove support inside shoe - not needed
    *
  RV1:
    * only using shoe and sleeve 
    * supports did not print.  too thin?
    * decrease shoeX by .2
  RV2:
    * still a mess - the hole makes a huge mess
  RV3:
    * flip it on it's side, cut in half, glue together

*/

include<MCAD/boxes.scad>

/* [Global] */
//Rounded Box Corder Radi
corner=2;
//Curve Refinement
$fn=36;
//Nut Thickness (M5 Default)
nutThickness=2.35;
//Distance Across Flats
nutFlat=5.5;
//Bolt Diameter
boltDia=3;
//Bolt Head Diameter
boltHeadDia=5.5;
//Bolt Head Thickess
boltHeadTh=3;
//Percentage Slop to Add to Holes and Inset
slop=1.1;


/* [Shoe Dimensions] */
//Width (plane of LCD)
shoeX=18.3; 
//Depth (plane of lens barrel)
shoeY=19.5; 
//Thickness
shoeZ=2.1;


/* [Dowel Sleeve] */
//Dowel Diameter
dowelD=8.5;
//Sleeve X
sleeveX=12;
//Sleeve Y
sleeveY=8.5;

//Sleeve Thickness
sleeveZ=18;


/* [Hidden] */
//overage to add to shapes to be unioned
ovr=.01;
//calculated values

//Nuts and Bolts
nutF=nutFlat*slop; //nut Flat
boltR=.5*boltDia*slop; //bolt radius
nutR=.5*nutF*1/cos(30); //nut radius
nutT=nutThickness*slop; //nut thickness
boltHRad=.5*boltHeadDia*slop;
boltHTh=boltHeadTh*slop;

//Dowel Sleeve
dowelR=dowelD/2;
//sleeveX=dowelR*3;
//sleeveY=dowelR*2+nutT*5;


module Shoe() {
  difference() {
    union() {
      //hot shoe
      roundedBox([shoeX, shoeY, shoeZ], corner, sidesonly=1);
      translate([0, 0, sleeveZ/2+shoeZ/2])
        roundedBox([sleeveX, sleeveY, sleeveZ+ovr], corner, sidesonly=1); 
    } //end union
    // dowel hole
    translate([0, 0, dowelR+shoeZ/2+3.5]) rotate([90, 0, 0]) 
      cylinder(h=sleeveY+ovr, r=dowelR, center=true);
    // nut hole
    translate([0, 0, sleeveZ/5*4+shoeZ])
      cube([nutF, .5*sleeveZ+nutR*1.05, nutT], center=true);
    // bolt hole
    translate([0, 0, -shoeZ+sleeveZ]) cylinder(h=sleeveZ, r=boltR, center=true);
  }
 
} // end Shoe

module CutHalf() {
//Front
  difference() {
    Shoe();
    translate([0, shoeY, shoeZ+sleeveZ/2]) 
      cube([shoeX*2, shoeY*2, (shoeZ+sleeveZ)*2], center=true);
  }
}
//Front Half
rotate([-90, 0, 0]) translate([ shoeX/2*1.2, 0, 0])CutHalf();
rotate([-90, 0, 0]) translate([-shoeX/2*1.2, 0, 0])CutHalf();
