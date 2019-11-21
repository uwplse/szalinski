//
//  WoodChistelBladeCover.scad
//
//  Evilteach  6/18/2016
//
//   
bladeWidth   = 15.00;
bladeDepth   = 20.00;
bladeHeight  =  4.84;

offset       =  2.00;
tighteness   =  0.10;

boxWidth  = bladeWidth + offset * 2;
boxDepth  = bladeDepth + offset * 2;
boxHeight = bladeHeight + offset * 2;

cutoutWidth  = boxWidth  - offset * 2;
cutoutDepth  = boxDepth  - offset * 2;
cutoutHeight = boxHeight - offset * 2;

module box()
{
    color("yellow")
        cube([boxWidth, boxDepth, boxHeight]);
}

module cutout()
{
    color("cyan")
        cube([cutoutWidth, cutoutDepth, cutoutHeight - tighteness]);
}


module main()
{
    translate([-boxWidth / 2, 0, boxDepth])
        rotate([270, 0, 0])
            difference()
            {
                box();
                
                translate([offset, 0, offset])
                    cutout();
            }
}


main();