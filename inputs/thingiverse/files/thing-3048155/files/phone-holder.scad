// Created by Viet Nguyen 2018
//=============================

//=============================
//Global Constants: 
//  Don't change these. It will break the code.
//=============================


//=============================
//Compiler Options: 
//These will change your viewing options in OpenSCAD
//=============================
$fn = 50;          

//=============================
//Global Print Variables:
//  These will adjust how the part is printed but not affect the overall part shape
//=============================


//=============================
//Global Mechanical Variables: 
//  Change these to adjust physical properties of the part
//=============================
overallThickness = 2;
phoneWidth = 172;
phoneThickness = 12;
suctionNippleDiameter = 14.5;
suctionNippleThickness = 5;
suctionNippleShaftThickness = 4;
holderSideChins = 7;
holderBottomChin = 5;
holderHeight = 28;


//==============================
//Calculated Variables: 
//Do not Change these directly
//==============================
suctionHolesWidth = suctionNippleDiameter+(overallThickness*2);
backThickness = suctionNippleThickness+suctionNippleShaftThickness;
module main()
{
    //add global logic and call part modules here

    mirror([1, 0, 0]) {
      half();
    }
    
    half();
    
}

module half()
{
  // Bottom
  cube([phoneWidth/2,phoneThickness,overallThickness]);
  
  // Back
  translate([0,phoneThickness,0])
  cube([(phoneWidth/2)+overallThickness,backThickness,holderHeight]);

  // Side
  translate([phoneWidth/2,overallThickness,0])
    cube([overallThickness, phoneThickness ,holderHeight]);

  // Bottom Chin
  cube([(phoneWidth/2)+overallThickness, overallThickness, holderBottomChin+overallThickness]);

  // Side Chin
  translate([(phoneWidth/2)-holderSideChins+overallThickness,0,0])
  sideChin();

  // suction holes
  translate([phoneWidth/4,phoneThickness+backThickness,holderHeight+suctionHolesWidth/2])
    rotate([90,0,0])
      suctionHoles();
  
}

module suctionHoles()
{
  
  translate([suctionHolesWidth/2,-suctionHolesWidth/2,0]) rotate([90,0,90]) filet(borderRadius=6, thickness=backThickness);
  translate([-suctionHolesWidth/2,-suctionHolesWidth/2,backThickness]) rotate([270,0,90]) filet(borderRadius=6, thickness=backThickness);
  difference()
  {
    union()
    {
      translate([-suctionHolesWidth/2,-suctionHolesWidth/2,0]) 
        cube([suctionHolesWidth, suctionHolesWidth/2,backThickness]);

      cylinder(d=suctionHolesWidth, h=backThickness, center=false);
    }
    
    // Nipple Part
    union()
    {
      translate([0,0,suctionNippleShaftThickness])
        cylinder(d=suctionNippleDiameter, h=suctionNippleThickness, center=false);
      cylinder(d=(suctionNippleDiameter-3), h=suctionNippleShaftThickness, center=false);
    }
  }
  
 


}

module filet (borderRadius=5, thickness=3, extra=false) {
    borderWidth = borderRadius * 2;
    translate([0,thickness])
        rotate([90,0,0])
            difference()
            {
                cube([borderRadius, borderRadius, thickness]);
                translate([borderRadius, borderRadius, -1]) cylinder(r=borderRadius, h=thickness+2);
            }
    
}

module sideChin ()
{
    cube([holderSideChins,overallThickness, holderHeight]);
}

//execute program and draw the part(s)
main();