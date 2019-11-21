//-----------------------------------------------------------
//	Oli's Foot for his Chair
//
//	Copyright © 2011 by Robert H. Morrison
//-----------------------------------------------------------

$fn=100;

foot_H=16;		//  Height of the foot
foot_DB=51;		//  Diameter of the foot BOTTOM
foot_DO=47;		//  Diameter of the foot OUTER
foot_DI=43;		//  Diameter of the foot INNER
foot_T=3;		//  Thickness of the foot BOTTOM

W = foot_DB + foot_T;
SH = (foot_DB-foot_DO)/2;

union() {
	difference() {
		union() {
			rotate_extrude(convexity = 10, $fn = 100)
				translate([foot_DB/2 - foot_T, 0, 0])
					circle(r=foot_T);

			translate([0,0, -foot_T]) 
				cylinder(h=foot_T, r=foot_DB/2 - 3);
		}

		color([1,0,0])
			translate([-W,-W,0])
				cube(W*2, false);
	}

	difference() {
		color([0,0,1])
			cylinder(h=foot_H, r=foot_DO/2);
		color([0,1,0])
			cylinder(h=foot_H+1, r=foot_DI/2);

		translate([0,0,foot_H-SH]) color([1,0,0,0.5])
			difference() {
					cylinder(h=SH, r1=foot_DB/2+ foot_T, r2=foot_DO/2);
					cylinder(h=SH + 1, r1=foot_DO/2, r2=foot_DI/2);
		}
	}
}