/*
*	olfa-l5-al.scad by cgsnz @ Thingiverse
*
*	Replacement thumbgrip for olfa-l5-al box cutter knife
*
* This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*
*/

/*[ Main Settings ]*/
// Fragments
$fn=24;//[24:low,48:med,96:high]
// Inner Body Width
TW = 9;//[6:15]
// End Body Width
TW2 = 12;//[6:18]
// Total Length
TL = 17;//[14:30]
// End Body Depth
TE = 3;//[1:10]
// Thickness
TT = 4;//[3:7]
// Groove Depth
TGD = 0.9;
// Groove Width
TGW = 1;
// Center Catch Width - exagerated because of bottom being printed into thin air, real width = 3.6
CCW = 4.75;

// center insert params

IL = 0+13.5;
IW = 0+2.75;
IH = 0+4.25;
CL = 0+6;
CF = 0+1.8;
CD = 0+2;

IH2 = IH+TT/2;
CO = IL-CL;
CFO = CL-CF;
CBO = CCW-IW;
TWO = (TW2-TW)/2;

translate([(TW-TT-IW)/2,(TL-IL)/2,TT*.75]) insert();
difference() {
	thumbgrip();
	groves();
}

module groves() {
	g = floor((TL+TT/4)/TGW);
	w = (g%2)?0:TGW/2;
	o = (TL-g*TGW)/2;
	to = TW2>TW?TWO:0;
	for (i = [0 : 2 : g-1]) {
	 translate([-to-TT/2-.1,w+o+i*TGW,-.1]) cube([max(TW,TW2)+.2,TGW,TGD+.1]);
	}
}

module thumbgrip() {
	tt = TT/cos(180/$fn);
	hull() {
		translate([-TT/4,-TT/4+TE,TT*.75]) sphere(tt/4);
		translate([-TWO-TT/4,-TT/4,TT*.75]) sphere(tt/4);
		translate([(TW-TT)+TT/4,-TT/4+TE,TT*.75]) sphere(tt/4);
		translate([TWO+(TW-TT)+TT/4,-TT/4,TT*.75]) sphere(tt/4);
		translate([-TT/4,-TT/4+TE,TT/4]) sphere(tt/4);
		translate([-TWO-TT/4,-TT/4,TT/4]) sphere(tt/4);
		translate([(TW-TT)+TT/4,-TT/4+TE,TT/4]) sphere(tt/4);
		translate([TWO+(TW-TT)+TT/4,-TT/4,TT/4]) sphere(tt/4);
	}
	hull() {
		translate([-TT/4,TL+TT/4-TE,TT*.75]) sphere(tt/4);
		translate([-TWO-TT/4,TL+TT/4,TT*.75]) sphere(tt/4);
		translate([(TW-TT)+TT/4,TL+TT/4-TE,TT*.75]) sphere(tt/4);
		translate([TWO+(TW-TT)+TT/4,TL+TT/4,TT*.75]) sphere(tt/4);
		translate([-TT/4,TL+TT/4-TE,TT/4]) sphere(tt/4);
		translate([-TWO-TT/4,TL+TT/4,TT/4]) sphere(tt/4);
		translate([(TW-TT)+TT/4,TL+TT/4-TE,TT/4]) sphere(tt/4);
		translate([TWO+(TW-TT)+TT/4,TL+TT/4,TT/4]) sphere(tt/4);
	}
	hull() {
		translate([-TT/4,TE-TT/4,TT/4]) rotate([-90,0,0]) cylinder(h=TL-TE*2+TT/2,r=TT/4);
		translate([-TT/4,TE-TT/4,TT-TT/4]) rotate([-90,0,0]) cylinder(h=TL-TE*2+TT/2,r=TT/4);
		translate([TW-TT*.75,TE-TT/4,TT/4]) rotate([-90,0,0]) cylinder(h=TL-TE*2+TT/2,r=TT/4);
		translate([TW-TT*.75,TE-TT/4,TT-TT/4]) rotate([-90,0,0]) cylinder(h=TL-TE*2+TT/2,r=TT/4);
	}
}

module insert() {
	difference() {
		cube([IW,IL,IH2]);
		translate([-.5,CO/2,IH2-CD]) cube([IW+1,CL,CD+.1]);
	}
	union() {
		translate([0,0,TT/4]) cfillet(TT/4);
		translate([IW,0,TT/4]) cfillet(TT/4);
		translate([0,IL,TT/4]) cfillet(TT/4);
		translate([IW,IL,TT/4]) cfillet(TT/4);
		translate([0,0,TT/4]) rotate([90,0,180]) fillet(TT/4,IL);
		translate([IW,0,TT/4]) rotate([-90,-90,0]) fillet(TT/4,IL);
		translate([0,0,TT/4]) rotate([0,-90,180]) fillet(TT/4,IW);
		translate([IW,IL,TT/4]) rotate([0,-90,0]) fillet(TT/4,IW);
	}
	polyhedron(
  points = [
		[-CBO/2, CO/2, IH2-CD],[IW+CBO/2, CO/2, IH2-CD],
		[0, CO/2, IH2],[IW, CO/2, IH2],
		[-CBO/2, (CO+CFO)/2, IH2-CD],[IW+CBO/2, (CO+CFO)/2, IH2-CD],
  ],
  faces = [[2,3,1,0],[0,4,2],[1,3,5],[3,2,4,5],[0,1,5,4]]);
	polyhedron(
  points = [
		[-CBO/2, IL-CO/2, IH2-CD],[IW+CBO/2, IL-CO/2, IH2-CD],
		[0, IL-CO/2, IH2],[IW, IL-CO/2, IH2],
		[-CBO/2, IL-(CO+CFO)/2, IH2-CD],[IW+CBO/2, IL-(CO+CFO)/2, IH2-CD],
  ],
  faces = [[0,1,3,2],[2,4,0],[5,3,1],[5,4,2,3],[4,5,1,0]]);

}

module cfillet(t) {
	rotate_extrude() difference() {
		square(t);
		translate([t,t]) circle(t);
	}
}

module fillet(t,h) {
	linear_extrude(height=h) difference() {
		square(t);
		translate([t,t]) circle(t);
	}
}
