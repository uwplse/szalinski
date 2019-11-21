/*
This file contains the parameterized code to make a coupling between a cyclone dust filter, which I purchased at Aliexpress,
	and a Dyson DC39 vacuum tube. All parameters can be changed, but these fit the Dyson tube perfect. 
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

// Adapter Vacuum tube Dyson
DiaTubeOuter = 37.4;
DiaTubeInner = 32.3;
TubeLength = 41;

// Cyclone
DiaCycloneInner = 56;
DiaCycloneOuter = DiaCycloneInner + Thickness;

/*********************************************************************************************************************
												Code
*********************************************************************************************************************/
union(){
	// Dyson part
	difference(){
		union(){
			intersection(){
				union(){
					translate([0,0,TubeLength/2])cylinder(d = DiaTubeOuter, h = TubeLength, center = true);
					
					// lock system
					translate([DiaTubeOuter/2,0,18.5*.5])difference(){
						cube([12,19,18.5], center = true);
						translate([0,0,-1.05])cube([13,16,16.5], center = true);
					}
					translate([-DiaTubeOuter/2,0,18.5*.5])difference(){
						cube([12,19,18.5], center = true);
						translate([0,0,-1.05])cube([13,16,16.5], center = true);
					}
				}
				translate([0,0,TubeLength/2])cylinder(d = 49, h = TubeLength+2, center = true);
			}
		}
		translate([0,0,TubeLength/2])cylinder(d = DiaTubeInner, h = TubeLength*2, center = true);
	}
	// Cyclone part
	difference(){
		union(){
			color("green")difference(){
				cylinder(d = DiaCycloneOuter, h = Thickness, center = true);
				cylinder(d = DiaTubeInner, h = Thickness*1.01, center = true);
			}
			color("red")translate([0,0,-(Thickness*4)/2])difference(){
				cylinder(d = DiaCycloneOuter, h = Thickness*4, center = true);
				translate([0,0,-0])cylinder(d1 = DiaCycloneInner, d2=DiaTubeInner-Thickness, h = Thickness*4.1, center = true);
				cylinder(d=DiaTubeInner, h=50, center=true);
			}
			translate([0,0,-Length/2])difference(){
				cylinder(d = DiaCycloneInner+Thickness, h = Length, center=true);
				cylinder(d = DiaCycloneInner, h = Length*2, center=true);
			}
		}
	}
}
