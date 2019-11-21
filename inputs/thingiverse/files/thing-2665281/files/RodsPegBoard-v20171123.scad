// Length of the rod
length_rod = 40; // [10:100]
// Extra rod to lower the round hook
extra_rod = 0; // [0:20]
// Degrees of rod
degrees = 107; // [90:120]
// distance between 2 holes
TwoHoles = 25; 
// diameter of hole
GrossRodDiameter = 5; 
// gross thickness of pegboard
GrossThicknessOfPegboard = 3; 

/* [Hidden] */
// number of fragments
$fn = 60;
// relative diameter of square versus circle
SquareFactor = 0.9;

HookBigRod(BigRod = length_rod, Degrees = degrees, ExtraRod = extra_rod, tip = false);

module License()
{
    // Put in module to prevent crashes.
    echo("Created by Bolukan (3dmodel@bolukan.nl), 2017");
    echo("Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.");
    echo("https://creativecommons.org/licenses/by-nc-sa/4.0/");
}

module BaseHook()
{
    ExtraRod = 3;
    union()
    {
        // lower rod into toolboard
        Rod(-GrossThicknessOfPegboard-GrossRodDiameter, 0, 0, 0);
        // vertical rod
        Rod(0, 0, 0, TwoHoles);
        // upper rod into toolboard
        Rod(0, TwoHoles, -GrossThicknessOfPegboard, TwoHoles);
        // lock upper rod into toolboard with 90 degree
        translate([-GrossThicknessOfPegboard,TwoHoles+GrossRodDiameter,0]) 
         rotate([0,0,180]) 
         Donut(90, GrossRodDiameter);
        Rod(-GrossThicknessOfPegboard-GrossRodDiameter, TwoHoles+GrossRodDiameter, 
            -GrossThicknessOfPegboard-GrossRodDiameter, TwoHoles+GrossRodDiameter+ExtraRod);
    }
}

module HookBigRod(BigRod, Degrees, ExtraRod, tip)
{
    translate([0,0,(SquareFactor * GrossRodDiameter ) / 2])
     union()
    {
        BaseHook();
        
        Rod(0, 0, 0, -ExtraRod);
        
        translate([GrossRodDiameter,-ExtraRod,0]) rotate([0,0,180])
         Donut(Degrees,GrossRodDiameter);
        
        // long rod hook
        Rod((1-cos(Degrees))*GrossRodDiameter,
            -ExtraRod-GrossRodDiameter*sin(Degrees),
            (1-cos(Degrees))*GrossRodDiameter+BigRod*sin(Degrees),
            -ExtraRod-GrossRodDiameter*sin(Degrees)-BigRod*cos(Degrees));

        if (tip == true)
        {
            // tip
            translate([(1)*GrossRodDiameter+BigRod*sin(Degrees),-ExtraRod-BigRod*cos(Degrees),0]) 
             rotate([0,0,180+Degrees])
             Donut(180-Degrees,GrossRodDiameter);
        
            // tip point
            Rod(2*GrossRodDiameter+BigRod*sin(Degrees),
                -ExtraRod-BigRod*cos(Degrees),
                2*GrossRodDiameter+BigRod*sin(Degrees),
                -ExtraRod-BigRod*cos(Degrees));
        }
    }
}

module HookRound(RoundDiameter, ExtraRod)
{
    translate([0,0,(SquareFactor * GrossRodDiameter ) / 2])
     union()
    {
        BaseHook();
        
        Rod(0, 0, 0, -ExtraRod);
        
        translate([RoundDiameter/2,-ExtraRod,0]) 
         rotate([0,0,180])
         Donut(180, RoundDiameter/2);
        
        Rod(RoundDiameter, 0, RoundDiameter, -ExtraRod);  
    }
}

module Rod(x1, y1, x2, y2)
{
    rodLength = sqrt(pow((x1-x2),2) + pow((y1-y2),2));
    translate([x1,y1,0])
     rotate([0,0,atan2(y2-y1,x2-x1)])
     hull()
    {
        CubedSphere();
        translate([rodLength,0]) CubedSphere();
    }
}

module CubedSphere()
{
    intersection()
    {
        cube(size=SquareFactor * GrossRodDiameter, center=true);
        sphere(d=GrossRodDiameter);
    }
}

module Donut(degree, radius)
{
    rotate_extrude2(angle=degree, convexity=360)
     translate([radius, 0])
     intersection()
    {
        square(size=SquareFactor * GrossRodDiameter, center=true);
        circle(d=GrossRodDiameter);
    }
}

module rotate_extrude2(angle=360, convexity=2, size=1000) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}