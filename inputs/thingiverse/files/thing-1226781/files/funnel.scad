//  Amount of segments in a circle
$fn = 100;

//  Radius of the ring on your KitchenAid
mountRadius = 52.5;

//  Height of the attachment ring
mountHeight = 16;

//  Inner radius of your bowl
funnelBaseRadius = 107;

//  Overhang of the funnel at the top
funnelTopOverhang = 25;

funnelHeight = 25;

//  Wall thickness
thickness = 3;

//  Thickness of the bowl
outerThickness = 6;

rotate([0, 0, -90])
{
    funnelAssembly();
}

module funnelAssembly()
{
    union()
    {
        mountBase();
        funnel();
    }
}

module mountBase()
{
    linear_extrude(height = mountHeight)
    {
        difference()
        {
            union()
            {
                circle(r = mountRadius + thickness);
                square(funnelBaseRadius);
            }
            circle(r = mountRadius);
            difference()
            {
                translate([thickness, thickness, 0])
                {
                    square(funnelBaseRadius);
                }
                circle(r = mountRadius + thickness);
            }
        }
    }
}

module funnel()
{
    funnelAngle = atan(funnelHeight / funnelTopOverhang);
    tx = thickness / sin(funnelAngle);
    
    difference()
    {
        intersection()
        {
            cube([funnelBaseRadius + funnelTopOverhang + tx, funnelBaseRadius + funnelTopOverhang + tx, funnelHeight]);
            rotate_extrude()
            {
                rotate([0, 0, 0])
                {
                    polygon(    points  =   [   [funnelBaseRadius, 0],
                                                [funnelBaseRadius + tx, 0],
                                                [funnelBaseRadius + tx + funnelTopOverhang, funnelHeight],
                                                [funnelBaseRadius + funnelTopOverhang, funnelHeight],
                                                [funnelBaseRadius + mountHeight / tan(funnelAngle), mountHeight],
                                                [funnelBaseRadius, mountHeight],
                                            ]);
                }
            }
        }
        intersection()
        {
            translate([thickness, thickness, 0])
            {
                cube([funnelBaseRadius + funnelTopOverhang + tx, funnelBaseRadius + funnelTopOverhang + tx, funnelHeight]);
            }
            rotate_extrude()
            {
                rotate([0, 0, 0])
                {
                    polygon(    points  =   [   [funnelBaseRadius, 0],
                                                [funnelBaseRadius, funnelHeight],
                                                [funnelBaseRadius + funnelTopOverhang, funnelHeight],
                                            ]);
                }
            }
        }
    }
}