/* [Global] */

// Inner diameter (40: SELP1640, 52: Sigma 30mm F1.4 DC DN C, 67: Samyang/Rokinon 12mm f2 NCS CS)
Diameter = 40; // [40:100]

// Cover the pop-up flash (makes sense above 67mm)
CoverFlash = 0; // [1:true, 0:false]

/* [Hidden] */

ShoeThickness = 1.6;

LensCap(Diameter, ShoeThickness, CoverFlash);

module LensCapSling(diameter)
{
    difference()
    {
        union()
        {
            SlingAdapter(diameter);
            translate([0,diameter/15,0]) LensCylinder(diameter, 4);
        }
        SlingCropCubes(diameter);
    }
}

module LensCap(diameter, shoeThickness, coverFlash)
{
    rotate([90, 0, 0])
    {
        difference()
        {
            union()
            {
                HotShoeAdapter(diameter, shoeThickness, coverFlash);
                LensCylinder(diameter, 3);
            }
            CropCubes(diameter);
        }
    }
}

module LensCylinder(innerDiameter, rimHeight)
{
    outerDiameter = innerDiameter + 3.0;
    difference ()
    {
        totalHeight = rimHeight + 1.15;
        translate([0,innerDiameter/3,totalHeight/2]) cylinder(h=totalHeight,d=outerDiameter, center = true);
        union()
        {
            translate([0,innerDiameter/3,rimHeight/4+1.25-0.05]) cylinder(h=rimHeight/2, d1=innerDiameter, d2=innerDiameter+0.8, center = true);
            translate([0,innerDiameter/3,rimHeight/4*3+1.25-0.06]) cylinder(h=rimHeight/2, d1=innerDiameter+0.8, d2=innerDiameter, center = true);
        }
    }
}

module HotShoeAdapter(capDiameter, shoeThickness, coverFlash)
{
    union()
    {
        if (coverFlash == 1)
        {
            x = capDiameter / 2 - (9 + 25.4);
            translate([x,7.5,-1]) cube([12.5,15,2], center = true);
            translate([x,7.75,-2-shoeThickness/2]) cube([18,15.5,shoeThickness], center = true);
        }
        else
        {
            x = capDiameter / 2 - (9 + 2.4);
            translate([x,7.5,-1]) cube([12.5,15,2], center = true);
            translate([x,7.75,-2-shoeThickness/2]) cube([18,15.5,shoeThickness], center = true);
        }
    }
}

module SlingAdapter(capDiameter)
{
    difference()
    {
        x = capDiameter;
        translate([0,x/2,-2]) cube([12.4,x,4], center = true);
        translate([0,x/2+0.1,-1.6]) cube([10,x+0.2,2.4], center = true);
    }
}

module CropCubes(lensDiameter)
{
    // if the cap is bigger than 100mm it may result in strange forms
    cubeSide = 200;
    union()
    {
        translate([0, cubeSide/2 + lensDiameter*0.5, 0]) cube(cubeSide, center = true);
        translate([0, -cubeSide/2, 0]) cube(cubeSide, center = true);
    }
 }
 
module SlingCropCubes(lensDiameter)
{
    cubeSide = 200;
    union()
    {
        translate([0, cubeSide/2 + lensDiameter*0.8, 0]) cube(cubeSide, center = true);
        translate([0, -cubeSide/2, 0]) cube(cubeSide, center = true);
    }
}