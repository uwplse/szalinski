//
//    GotFilament.scad
//
//    EvilTeach
//
//    12/13/2015
//
//    
//

// This controls the thickness of the base plate, and the hanger.
thickness  =   0.3;

// This controls the width of the base plate.
baseWidth  =  80.0;

// This controls the depth of the base plate.
baseDepth  =  50.0;

// This is the diameter of the hanger ring.
ringDiameter = 5.0;

// This is the top line of text
text1      = "Got";

// This is the bottom line of text
text2      = "Filament?";

// This is how high above the base plate that the text should extend.
textHeight = 1.0;

// This is the font size for the text.
fontSize   = 10;

// I like round
$fn = 360;

module hanger()
{
    ringRadius = ringDiameter / 2;
    
    translate([0, baseDepth + ringRadius - 1, 0])
        difference()
        {
            cylinder(r = ringRadius,     h = thickness);
            cylinder(r = ringRadius - 1, h = thickness);
        }
}



module base_plate()
{
    color("purple")
    {
        hanger();
        translate([-baseWidth / 2,0 , 0])
            cube([baseWidth, baseDepth, thickness]);
    }
}



module witty_saying()
{
    color("white")
        translate([0, baseDepth * 0.60, thickness])
            linear_extrude(textHeight)
                text(text1, size=fontSize, halign = "center");
    
    color("white")
        translate([0, baseDepth * 0.25, thickness])
            linear_extrude(textHeight)
                text(text2, size=fontSize, halign = "center");
}



module main()
{
    // Force the pieces into the middle of the build plate.
    translate([0, -baseDepth / 2, 0])
    {
        base_plate();
        witty_saying();
    }
}

main();