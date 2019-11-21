// Bottle stand for draining a water bottle (or similar) after washing it.

// Diameter of "plug" for bottle neck. A snug fit is best to prevent the bottle tipping.
Neck_Diameter = 25.5;   // [5:50]

// Height of plug.
Plug_Height = 30;       // [20:50]

// Want some grooves? Grooves are good.
Grooves = "yes";    // [yes,no]

/* [Hidden] */

$fn=120;

Tad = 0.1;
Tad2 = Tad*2;

StandD = 60;
StandT = 2;
FinT = 2;
GrooveD = 3;
GrooveStep = 45;
GrooveOffset = [floor(Neck_Diameter/3)-2, 0, StandT+1.5];
GrooveAngle = [0, 93, 0];

// Base
difference () {
	cylinder (d=StandD, h=StandT);
	// Drain grooves
	if (Grooves=="yes") for (a = [GrooveStep/2: GrooveStep : 359])
		rotate ([0, 0, a])
		translate (GrooveOffset) rotate (GrooveAngle) cylinder (d=GrooveD, h=StandD);
}
// Bit going up into neck
translate ([0, 0, StandT-Tad])
difference () {
	union () {
		cylinder (d=Neck_Diameter/3, h=Plug_Height+Tad);
		for (a = [0: 45 : 179])
			rotate ([0, 0, a])
			translate ([-FinT/2, -Neck_Diameter/2, 0])
			cube ([FinT, Neck_Diameter, Plug_Height+Tad]);
	}
	// Take cone off top
	translate ([0, 0, Plug_Height-Neck_Diameter/2])
	difference () {
		cylinder (d=StandD, h=Neck_Diameter);			// Cylinder
		cylinder (d1=Neck_Diameter*1.1, d2=0, h=Neck_Diameter);		// Minus cone
	}
}
