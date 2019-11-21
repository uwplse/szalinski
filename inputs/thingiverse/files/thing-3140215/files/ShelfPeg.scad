//
// Parameterized Shelf Peg
//
// This part was designed October 2018 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY-NC license 
// (https://creativecommons.org/licenses/by-nc/3.0/).
// 
//
// History:
// V1.0 6 Oct 2018 First Release

/* [Parameters] */
// Units for measurements, Inches or Millimeters
Units="in"; // ["in", "mm" ]
// Diameter of the Peg
Peg_Diameter=0.1875;
// Length of the Peg
Peg_Length=0.375;
// Length of the top, in contact with shelf
Top_Length=0.5;
// Height of the side, in contact wiht cabinet
Side_Height=0.5;
// Width of the clip
Clip_Width=0.5;
// thickness of the clip's walls
Clip_Thick=0.0625;

/* [Hidden] */
MM_PER_INCH=25.4;

pegD=(Units == "mm")?Peg_Diameter:Peg_Diameter*MM_PER_INCH;
pegL=(Units == "mm")?Peg_Length:Peg_Length*MM_PER_INCH;
topL=(Units == "mm")?Top_Length:Top_Length*MM_PER_INCH;
side=(Units == "mm")?Side_Height:Side_Height*MM_PER_INCH;
width=(Units == "mm")?Clip_Width:Clip_Width*MM_PER_INCH;
thick=(Units == "mm")?Clip_Thick:Clip_Thick*MM_PER_INCH;
  
if (Units == "in"){
  pegD=Peg_Diameter*MM_PER_INCH;
  pegL=Peg_Length*MM_PER_INCH;
  topL=Top_Length*MM_PER_INCH;
  side=Side_Height*MM_PER_INCH;
  width=Clip_Width*MM_PER_INCH;
}


hyp=sqrt(side*side + topL*topL);
angle=90-atan( (side-thick)/(topL-thick) );

difference(){
  union(){
    // peg
    translate([0,0,pegD/2])
      rotate([90,0,0])
        cylinder(d=pegD, h=pegL, $fn=40);
    // +x side
    translate([width/2-thick,0,0])
      cube([thick,topL,side]);
    // -x side
    translate([-width/2,0,0])
      cube([thick,topL,side]);
    // top (although the thing is upside down so maybe bottom)
    translate([-width/2,0,0])
      cube([width,topL,thick]);
    // top (although the thing is upside down so maybe bottom)
    translate([-width/2,0,0])
      cube([width,thick,side]);
  }
  translate([0,(topL+thick)/2,(side+thick)/2])
    rotate([angle,0,0])color("red")
      translate([0,hyp/2,0])
        cube([width+2,hyp, hyp], true);
}


