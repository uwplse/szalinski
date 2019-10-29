//
//  Tube Type Table Feet
//
//  EvilTeach
//
//  12/12/2015
//
//  This generates 4 covers to put on the table feet.

// The actual thickness of the bottom and walls
thickness      =  3.0;

// The total height of one foot
height         = 20.0;

// The diameter of the hollow part where the tube goes.
insideDiameter = 26.2;

// how many do we want to print?
numberOfFeet = 4;

insideRadius = insideDiameter / 2.0;
outsideDiameter = insideDiameter + thickness * 2.0;
outsideRadius = outsideDiameter / 2.0;

// Draws one foot
module draw_one()
{
    // Make it nice and round
    $fn = 50;
    
    difference()
    {
        // take the basic cylinder
        cylinder(r = outsideRadius, h = height);
        
        // remove the inner cylinder, up one thickness
        translate([0, 0, thickness])
            cylinder(r = insideRadius, h = height - thickness);
    }
    
}

module main()
{
    // Generally we need four of them.  We try to center them on the build plate
    for (x=[-numberOfFeet / 2 + 1 : numberOfFeet / 2 ])
    {
        translate([x *  outsideDiameter - outsideRadius,
                   x * 5,  // Just a little bit apart
                   0])
            draw_one();
    }
}


main();