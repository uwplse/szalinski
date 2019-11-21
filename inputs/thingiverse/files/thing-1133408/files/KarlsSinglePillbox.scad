//
//  KarlsSinglePillbox.scad
//
//  EvilTeach 11/2015
//
//  This model prints a square box that can be pushed/pulled apart easily.
//  This particular one was designed to fit into a wallet change purse
//

offset         = 2.0;           // Gap between pieces

thickness      = 1.0;           // Roughly the thickness of the wall when joined together
interiorWidth  = 9.0;           // Width on the X and Y axis
interiorDepth  = interiorWidth;
interiorHeight = 5.0;           // Height on the Z axis

exteriorWidth  = interiorWidth + thickness * 2.0;   // x
exteriorDepth  = exteriorWidth;                     // y
exteriorHeight = interiorHeight + thickness;        // z

name     = "Karls";     // Name of person using the pill
message1 = "Drug";      // A small
message2 = "Stash";     // message that could be just blank

module bottom()
{
    color("yellow")
    
    difference()
    {
        union()
        {
            translate([offset, -exteriorWidth - offset, 0])
                cube([exteriorWidth, exteriorDepth, exteriorHeight]);

            translate([offset - thickness, -exteriorWidth - offset - thickness, 0])
                cube([exteriorWidth + thickness * 2, exteriorDepth + thickness * 2, thickness]);
        }
            
        translate([offset + thickness / 2.0, -exteriorWidth - offset + thickness / 2.0, thickness])
            cube([exteriorWidth  - thickness, 
                  exteriorDepth  - thickness, 
                  exteriorHeight - thickness]);
        
    
        rotate([0, 180, 0])
            translate([-exteriorWidth - 1, -exteriorDepth + 6, -.5])
                linear_extrude(height = 2)
                    text(name, size = 2);        

        rotate([0, 180, 0])
            translate([-exteriorWidth - 1, -exteriorDepth + 3, -.5])
                linear_extrude(height = 2) 
                    text(message1, size = 2);        

        rotate([0, 180, 0])
            translate([-exteriorWidth - 1, -exteriorDepth + 0, -.5])
                linear_extrude(height = 2)
                    text(message2, size = 2);        

    }
}

topWidth  = exteriorWidth + thickness;
topDepth  = topWidth;
topHeight = exteriorHeight;

module top()
{
    color("cyan")
    translate([0, offset, 0])
    difference()
    {
        union()
        {
            translate([offset, 0, 0])
                cube([topWidth, topDepth, topHeight]);
            translate([offset - thickness, -thickness, 0])
                cube([topWidth + thickness * 2, topDepth + thickness * 2, thickness]);
        }
        translate([offset + thickness / 2.0, thickness / 2.0, thickness])
            cube([topWidth - thickness, topDepth - thickness, topHeight]);
    }
         
}

module main()
{
    top();
    bottom();
}


main();