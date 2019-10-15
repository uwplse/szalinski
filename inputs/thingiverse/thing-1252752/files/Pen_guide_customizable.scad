// Set the outer guide height to zero for no outer guide
Outer_guide_height = 20;
// The total length of the guide. The drawing guide will be centered on this. If it is smaller than possible it will be generated at the length of the pen guide.
Length = 50;
// This is the distance at which the line will be drawn from the edge of the material.
Distance_from_edge = 5;
// The width of the opening for the guide to fit on the metal.
Slot_width = 3;
// The width of the pen tip in the form of it's diameter.
Pen_diameter = 10.75;


function baseheight() = ((Pen_diameter/2)+2.5 > innerWallHeight) ? ((Pen_diameter/2) + 2.5 - innerWallHeight) : 0;

function partLength() = (Length > Pen_diameter + 5) ? Length : Pen_diameter + 5;

function outerWallHeight(innerWallHeight) = (Outer_guide_height > innerWallHeight) ? Outer_guide_height : inerWallHeight;
generatePart();
module generatePart()
{
    outerWallWidth = 5;

    gapHeight = 3;

    innerWallWidth = 4;
    innerWallHeight = gapHeight + Distance_from_edge;

    penHeight = 20;

    baseheight = 0.00;
    if(Outer_guide_height > 0)
    {
        cube([outerWallWidth,partLength(),outerWallHeight(innerWallHeight)+baseheight()]);
    }
    
    translate([outerWallWidth,0,0])
    {
        difference()
        {
            
        cube([Slot_width,partLength(),gapHeight+baseheight()]);
            translate([0,partLength()/2,innerWallHeight+baseheight()])
            {
                rotate([0,90,0])
                {
                    cylinder(r=Pen_diameter/2,h=20);
                    
                }
            }
        }
    }
    translate([outerWallWidth + Slot_width,0,0])
    {
        difference()
        {
            cube([innerWallWidth, partLength(), innerWallHeight+baseheight()]);
            translate([0,partLength()/2,innerWallHeight+baseheight()])
            {
                rotate([0,90,0])
                {
                    cylinder(r=Pen_diameter/2,h=20);
                    
                }
            }
        }
        
        translate([0,partLength()/2,innerWallHeight+baseheight()])
        {
            rotate([0,90,0])
            {
                difference(){
                    cylinder(r=Pen_diameter/2 + 2.5,h=20);
                    cylinder(r=Pen_diameter/2,h=20);
                }
                
            }
        }
    }
}
