/* [Tank Parameters */
// Diameter of connector thread.  7mm is a tight screw-in fit.
thread_d=7;
// Depth of thread hole.
thread_h=6;
// Depth of tank cutout.  Set to 0 for tank to sit flush on top of holder.
tank_lip = 3;
// Diameter of tank (used for lip).
tank_d = 26;

/* [Holder Parameters] */
length = 110;
width = 35;
height = 16;

// Space between tank slots.  Default is 1/5 of tank diameter.
holeSpace = (tank_d / 5);

/* [Hidden] */
$fn=360;


HolderRow(length, width, height);

module TankSlot(){
	translate([0,0,-thread_h*.75])
	cylinder(d=thread_d, h=thread_h+.001, center=true);
	cylinder(d=tank_d, h=tank_lip, center=true);
}

module HolderRow(l, w, h){	
	// Circle Version
	
	holeCount = ((l - 2*holeSpace) / (tank_d + holeSpace));
	
	leftoverSpace = (l - (holeCount*tank_d + max(0, holeCount -1)*holeSpace));
	endSpace = -(l - leftoverSpace)*.35;
	start =  0;
	end = floor(holeCount -1);
	
	difference(){
		translate([0,0,-h*.5 + tank_lip/2])
		hull(){
			translate([0,l/2 - w/2,0])
			cylinder(d=w,h=h, center=true);
			translate([0,-(l/2 - w/2),0])
			cylinder(d=w,h=h, center=true);
		}
		for(i=[start:end]){
			#translate([0, endSpace + i*(tank_d + holeSpace) ,.001])
			TankSlot();
		}
	}
}