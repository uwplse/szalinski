//********************************************************************
//********************************************************************
//Simple drawer or shelf bracket
//by Marc Sulfridge
//********************************************************************
//********************************************************************

//********************************************************************
//User defined parameters
//********************************************************************
//Width of bracket.
width = 15; // [2:25]
//Lenght of side reinforcement triangles.
side_len = 27.5; // [5:50]
//Height of side reinforcement triangles.
side_ht = 14.5; // [5:50]
//Length of horizontal base.
length = 30; // [5:50]
//Height of vertical base.
up_ht = 17.75; // [5:50]
//Thickness of base and side.
thick = 2; // [0.25:2.5]
//Thickness of side reinforcement triangles.
side_thk = 1.75; // [0.25:2.5]
//Radius of corner fillets.
fillet_rad = 3.25; // [0.5:5]
//Distance between end of horizontal base and center of horizontal hole.
base_hole_gap = 4.5; // [1:10]
//Distance between top of vertical base and center of vertical hole.
side_hole_gap = 5.25; // [1:10]
//Short axis (diameter) of screw holes.
hole_dia = 6.75; // [1:10]
//Long axis (length) of screw holes.
hole_wid = 9.75; // [2:20]
//Fudge factor to ensure overlaps.
dt = 0.1; // [0.001,0.01,0.1]
//********************************************************************

module hole(){
	hull(){
		for (i=[-1,1]){
			translate([0,i*(hole_wid-hole_dia)/2,-dt/2])
			cylinder(r=hole_dia/2,h=thick+dt,center=false);
		}
	}
}

module side(){
	hull(){
		cube([dt,side_thk,side_ht], center=false);

		translate([side_len-thick,0,0])
		cube([dt,side_thk,thick], center=false);
	}
}

module base(long){
	translate([0,0,thick/2])
	hull(){
		cube([dt,width,thick], center=true);
		
		for (i=[-1,1]){
			translate([long-fillet_rad,i*(width/2-fillet_rad),0])
			cylinder(r=fillet_rad,h=thick,center=true);
		}
	}
}

module upright(long){
	translate([thick,0,0])
	rotate([0,-90,0])
	base(long);
}

difference(){
	union(){
		base(length);
		upright(up_ht);
		
		for (i=[-width/2+dt, width/2-side_thk-dt]){
			translate([thick-3*dt,i,0])
			side();
		}
	}

	translate([length-base_hole_gap-hole_dia/2,0,0])
	hole();

	translate([thick,0,side_hole_gap+hole_wid/2])
	rotate([0,-90,0])
	rotate([0,0,90])
	hole();
}
