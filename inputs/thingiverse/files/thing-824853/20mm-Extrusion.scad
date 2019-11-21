// Generates T-Slot extrusion profiles

// Length - Maximum is your Z-Axis height
ExtrusionLength = 50;
// Profile Width/Height
Outer = 20;
// Outer Wall Thickness
Wall = 1.5;
// Center Hole Diameter
CenterHoleDiam = 5;
// Number of Slots
NumSlots = 2; // [0,1,2,3,4]
// For 2 slots only: Corner or Opposite Sides?
Corner = 1; // [0:No,1:Yes]

// Slot Opening Width
SlotW = 5.0;
// Slot Inside Width
InsideW = 12.2;
// Depth of Wide Part of Slot
Flat = 1.2;
// Total depth of slot (inner part only)
Depth = 4;

// Max segment width for holes
$fs=0.5;

// Derived Parameters
Inner = Outer/2 - Wall;
BottomW = InsideW - 2*tan(45)*(Depth - Flat);

Slot0 = [Inner + Wall + 1, -SlotW/2];
Slot1 = [Inner + Wall + 1, SlotW/2];
Slot2 = [Inner, SlotW/2];
Slot3 = [Inner, InsideW/2];
Slot4 = [Inner - Flat, InsideW/2];
Slot5 = [Inner - Depth, BottomW/2];
Slot6 = [Inner - Depth, -BottomW/2];
Slot7 = [Inner - Flat,-InsideW/2];
Slot8 = [Inner, -InsideW/2];
Slot9 = [Inner, -SlotW/2];

module OpenSlot(){
	polygon([Slot0,Slot1,Slot2,Slot3,Slot4,Slot5,Slot6,Slot7,Slot8,Slot9]);
}

module ClosedSlot(){
	polygon([Slot2,Slot3,Slot4,Slot5,Slot6,Slot7,Slot8,Slot9]);
}

module SquareProfile(){
	linear_extrude(height = ExtrusionLength)
	difference(){
		square([Outer,Outer],center=true);
		// Remove Inner Hole
		circle(d = CenterHoleDiam);
		// Remove Slots
		// First Position - Zero Degrees
		if(NumSlots > 0) OpenSlot();
		else ClosedSlot();
		// Second Position - 90 Degrees
		rotate([0,0,90])
		if((NumSlots > 2)||
			((NumSlots == 2)&&(Corner == 1)))
			OpenSlot();
		else ClosedSlot();
		// Third Position - 180 Degrees
		rotate([0,0,180])
			if((NumSlots > 2)||
				((NumSlots == 2)&&(Corner == 0)))
				OpenSlot();
		else ClosedSlot();
		// Fourth Position - 270 Degrees
		rotate([0,0,270])
		if(NumSlots > 3) OpenSlot();
		else ClosedSlot();
	}
}

SquareProfile();