// Cattoy by Matthew Fogle (Customizer enabled)
// 12/30/2015
CustomizeSize = 40;             // This is the total size of the sphere end to end in mm.

//You should be able to mostly leave below alone and just edit the size above in mm.
$fn = 50;                      // High resolution
Size = CustomizeSize / 2;       // Get the radius of the sphere we will create
Wall = Size / 8;                // Define the wall thickness 
SlotHeight = (Size * 2) / 1.65; // Define the Slot height (not including semicircles)
Slotwidth = SlotHeight / 5;     // Define the slot width
InsideSize = (Size / 3.5);      // Define the proportion of the inner sphere to the outer one

module slot()
{
    SlotZ = ((Size * 2) - SlotHeight) / 2;
    SlotT = (((Size * 2) - SlotHeight) / 2) + SlotHeight;
    SlotB = ((Size * 2) - SlotHeight) / 2;
    union()
    {
        translate([-(Slotwidth / 2),-100,SlotZ]) cube([Slotwidth,200,SlotHeight]);
        translate([-100,0,SlotT]) rotate([0,90,0]) cylinder(200,(Slotwidth / 2),(Slotwidth / 2));
        translate([-100,0,SlotB]) rotate([0,90,0]) cylinder(200,(Slotwidth / 2),(Slotwidth / 2));
    }
}

union()
{
difference ()
{
    translate([0,0,Size]) sphere(Size);
    translate([0,0,(Size - Wall) + (Wall / 2)]) sphere(Size - Wall);
    rotate([0,0,0]) slot();
    rotate([0,0,45]) slot();
    rotate([0,0,90]) slot();
    rotate([0,0,135]) slot();
}
translate([0,0,InsideSize + (Wall / 2)]) sphere(InsideSize);
}
