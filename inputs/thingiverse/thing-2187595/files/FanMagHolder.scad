// Mount to put spinning magnets onto a PC fan for magnetic stirrer

/* [Magnets] */

// Allow clearance
Magnet_Diameter = 15.5;
// Allow clearance
Magnet_Height = 2;  

// Wall thickness of magnet retainer
Magnet_Wall = 0.81;
//This is two walls with line width of 0.4mm and extra 0.01 is to prevent rounding errors.

/* [Washer] */

Washer_Diameter = 32; //  Generous is OK.
Washer_Height = 1.6; 

/* [Fan] */

// Inner diameter of part that engages with fan
Fan_Diameter = 38; 
// Height of part that engages with fan
Fan_Height = 8.5; 
// Wall thickness of part that engages with fan
Fan_Wall = 1.21; 
// Number of fan blades
Fan_Blades = 7; 
// Width of slot for each blade.
Fan_Slot = 8; 
// Tune to avoid short segments when changing number of blades!
Fan_Fiddle_Factor = 0.75; 	// The 0.75 is a fiddle factor to avoid short segments. If you change number of blades, you may need to fiddle with this.

/* [Hidden] */

$fn = 50;
Tad = 0.1;
Tad2 = Tad*2;

difference () {
	union () {
		// Main body
		cylinder (d=Fan_Diameter+Fan_Wall*2, h=Fan_Height);
		// Mag bodies
		for (x=[-1,1]) translate ([Washer_Diameter/2*x, 0, 0]) cylinder (d=Magnet_Diameter+Magnet_Wall*2, h=Magnet_Height);
	}
	// Remove cylinder for fan
	translate ([0, 0, Magnet_Height+Washer_Height]) cylinder (d=Fan_Diameter, h=Fan_Height);
	// Remove cylinder for washer
	translate ([0, 0, Magnet_Height]) cylinder (d=Washer_Diameter, h=Washer_Height+Tad);
	// Remove mag holes
	for (x=[-1,1]) translate ([Washer_Diameter/2*x, 0, -Tad]) cylinder (d=Magnet_Diameter, h=Fan_Height*2); // Fan_Height*2 just means "go mad, go high".
	// Blade cutouts.

	for (b = [1 : Fan_Blades]) rotate ([0, 0, (b + Fan_Fiddle_Factor) * (360 / Fan_Blades)]) translate ([- Fan_Slot/2, 0, Magnet_Height + Washer_Height]) cube ([Fan_Slot, Fan_Diameter*2, Fan_Height*2]);
}
