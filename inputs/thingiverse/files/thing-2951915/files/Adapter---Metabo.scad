/*
This file contains the parameterized code to make a coupling between a cyclone dust filter, which I purchased at Aliexpress,
	and a Metabo vacuum tube (ASR 25 L SC). All parameters can be changed, but these fit the Dyson tube perfect. 
	I used the handle on the vacuum cleaner so I could open the mouthpiece and lower the suction of the vacuum cleaner. 
	For small dust particles, the suction is still too hard.
I made the cyclone dust adapter a little bit bigger. This way you can add a little rubber tape of Teflon to ensure the 
	connection between them is airtight.
*/
/*********************************************************************************************************************
												Parameters
*********************************************************************************************************************/
// General
$fn = 100;
Thickness = 3;
Length = 30;

// Cyclone
DiaCycloneInner = 56;
DiaCycloneOuter = DiaCycloneInner + Thickness;

// Metabo
DiaMetaboOuter = 29-0.5;
DiaMetaboInner = DiaMetaboOuter - Thickness;

/*********************************************************************************************************************
												Code
*********************************************************************************************************************/
difference(){
	union(){
		// Cyclone
		translate([0,0,-Length/2])difference(){
			cylinder(d=DiaCycloneInner+Thickness, h=Length, center=true);
			translate([0,0,-Thickness])cylinder(d=DiaCycloneInner, h=Length*1.01, center=true);
		}
		// Metabo
		color("red")translate([0,0,-(4*Thickness)/2-Thickness])difference(){
			cylinder(d=DiaCycloneInner, h=Thickness*4, center=true);
			cylinder(d2=DiaMetaboInner, d1=DiaCycloneInner, h=Thickness*4.01, center=true);
		}
		translate([0,0,Length/2])cylinder(d=DiaMetaboOuter, h=Length, center=true);
	}
	cylinder(d=DiaMetaboInner, h=500, center=true);
}
