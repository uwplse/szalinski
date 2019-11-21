//
//  LightBulb Shade
//
//  EvilTeach
//
//  1/30/2016
//
// fill 0%
// layer .2
// no shells
// feed 50
// travel 80
//
// 6.33 meters of filament
// about 2 hours to print

// Build with 90 line segments for the circle
$fn = 90;

// Diameter of the small end of the shade
shadeDiameter  =  75.0;
shadeRadius    = shadeDiameter / 2;

// The height of the shade
shadeHeight    = 110.0;

// My smallest extruder size
shadeThickness =  0.4;

// diameter of the part that grips the bulb
holderDiameter = 33;
holderRadius = holderDiameter / 2;

// Height of the support
holderHeight = 3;


main();



module main()
{
    shade();
    holder();
}



module shade()
{
    difference()
    {
        cylinder(r1 = shadeRadius,
                 r2 = shadeRadius + 15, 
                 shadeHeight);
        cylinder(r1 = shadeRadius - shadeThickness, 
                 r2 = shadeRadius - shadeThickness + 15,
                 shadeHeight);
    }
}



module holder()
{
    difference()
    {
        union()
        {
            translate([-shadeRadius, 0, 0])
                cube([shadeDiameter, holderHeight, holderHeight]);

            translate([0, -shadeRadius, 0])
                rotate([0, 0, 90])
                    cube([shadeDiameter, holderHeight, holderHeight]);
        }

        cylinder(r = holderRadius, holderHeight);
    }

    difference()
    {
        cylinder(r = holderRadius, holderHeight);
        cylinder(r = holderRadius - shadeThickness, holderHeight);
    }
}
