// Copyright 2019 Geoff Sobering - All Rights Reserved
//
// This design is licensed under the Creative Commons
//   Attribution-NonCommercial-ShareAlike 3.0 Unported License
//  (CC BY-NC-SA 3.0)
//  https://creativecommons.org/licenses/by-nc-sa/3.0/
//  https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// For commerical use, please contact us (geoff@geoffs.net).

// The outside diameter of the tube
Tube_Diameter = 26.7;
// The thickness of the base under the tube
Base_Thickness = 6;
// The length of the base in the direction of the tube
Base_Length = 60;
// The diameter of the screw hole (0=no hole)
Screw_Hole_Dia = 5;
// The depth of the countersink under the tube (0=no countersink)
Top_Countersink_Depth = 0;
// The depth of the countersink in the bottom of the mount (0=no countersink)
Bottom_Countersink_Depth = 2;
// The radius for the base at the surface
Base_Corner_Radius = 6;
// The radius of the base where is comes to the tube
Top_Corner_Radius = 6;
// The minimum angle for a fragment(degrees) - OpenSCAD $fa variable
FA = 5;
// The minimum size of a fragment (mm) - OpenSCAD $fs variable
FS = 0.5;

adapter(
  Tube_Diameter,
  Base_Thickness,
  Base_Length,
  Screw_Hole_Dia,
  Top_Countersink_Depth,
  Bottom_Countersink_Depth,
  Base_Corner_Radius,
  Top_Corner_Radius,
  FA, FS);

/* difference()
{
  adapter(tubeOD, baseThickness, baseLength, screwDia, topCountersinkDepth, bottomCountersinkDepth);
  translate([-100, -200, -100]) cube(200);
} */

module adapter(tubeOD, baseZ, baseY, screwHoleDia, topCountersinkDepth, bottomCountersinkDepth, baseCornerRadius, topCornerRadius, FA, FS)
{
  $fa = FA;
  $fs = FS;
  baseX = tubeOD * 1.3 + 2*baseCornerRadius; // + 20;

  topX = tubeOD + 2*topCornerRadius;
  topY = baseY;

  pvcTubeCenterlineZ = tubeOD/2+baseZ;

  baseCentering = [-baseX/2, -baseY/2,0]; //[-baseX/2+baseCornerRadius, -baseY/2+baseCornerRadius, 0];

  baseP1 = [baseCornerRadius, baseCornerRadius, 0] + baseCentering;
  baseP2 = [baseCornerRadius, baseY-baseCornerRadius, 0] + baseCentering;
  baseP3 = [baseX-baseCornerRadius, baseCornerRadius, 0] + baseCentering;
  baseP4 = [baseX-baseCornerRadius, baseY-baseCornerRadius, 0] + baseCentering;
  echo(str("baseP1 = ", baseP1));
  echo(str("baseP4 = ", baseP4));

  topCentering = [-topX/2, -topY/2, 0]; //[-topX/2+topCornerRadius, -topY/2+topCornerRadius, 0];
  tz = pvcTubeCenterlineZ-topCornerRadius;
  topP1 = [topCornerRadius, topCornerRadius, tz] + topCentering;
  topP2 = [topCornerRadius, topY-topCornerRadius, tz] + topCentering;
  topP3 = [topX-topCornerRadius, topCornerRadius, tz] + topCentering;
  topP4 = [topX-topCornerRadius, topY-topCornerRadius, tz] + topCentering;
  echo(str("topP1 = ", topP1));
  echo(str("topP4 = ", topP4));

  difference()
  {
    union()
    {
      hull()
      {
        translate(baseP1) sphere(r=baseCornerRadius);
        translate(baseP2) sphere(r=baseCornerRadius);
        translate(baseP3) sphere(r=baseCornerRadius);
        translate(baseP4) sphere(r=baseCornerRadius);

        translate(topP1) sphere(r=topCornerRadius);
        translate(topP2) sphere(r=topCornerRadius);
        translate(topP3) sphere(r=topCornerRadius);
        translate(topP4) sphere(r=topCornerRadius);
      }
    }

    // Put in the screw-hole if needed:
    if(screwHoleDia > 0)
    {
      translate([0,0,-1]) cylinder(d=screwHoleDia, h=100);
      if(topCountersinkDepth > 0)
      {
        d1 = 2*topCountersinkDepth+screwHoleDia+3;
        hb= d1/2;
        dz = baseZ - screwHoleDia/2 - topCountersinkDepth; //  + bottomCountersinkDia/2 - 0.5; //-screwHoleDia/2; //-screwHoleDia/2+baseZ/2;
        translate([0,0,dz]) cylinder(d1=0, d2=d1, h=hb);
      }
      if(bottomCountersinkDepth > 0)
      {
        d1 = 100;
        hb= d1/2;
        dz = -hb + screwHoleDia/2 + bottomCountersinkDepth; //  + bottomCountersinkDia/2 - 0.5; //-screwHoleDia/2; //-screwHoleDia/2+baseZ/2;
        translate([0,0,dz]) cylinder(d1=d1, d2=0, h=hb);
      }
    }

    // Cut out the tube:
    translate([0, 100, pvcTubeCenterlineZ]) rotate(90,[1,0,0]) cylinder(d=tubeOD, h=200);

    // Cut off anything below Z=0:
    translate([-100, -100, -200]) cube(200);
  }
}
