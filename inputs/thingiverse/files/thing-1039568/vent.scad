$fn=150; 

// Total length of the adapter (mm)
l = 80;

// Outer diameter of the hose connector (mm)
hc_od = 58.5;

// Length of the hose connector (mm)
hc_l = 30;

// Thickness of the wall (mm)
thickness = 3;

// Length of the vent (mm)
vent_l = 220;

// Height of the vent (mm)
vent_h = 35;

// Width of the vent (mm)
vent_w = 30;

// You probably do not want to change this.
Delta = 0.1;

module connector_hull(extra) {
	union() {
		cube([vent_w+extra,vent_l+extra,vent_h]);
		hull() {
			translate([0,0,vent_h-Delta])   
				cube([vent_w+extra,vent_l+extra,Delta]);
			translate([0,(hc_od+extra)/2,l])
				cylinder(h=Delta, r=hc_od/2+extra/2);
		}
		translate([0,(hc_od+extra)/2,l - Delta])
			cylinder(h=hc_l, r=hc_od/2+extra/2);
	}
}

module connector() {
	difference() {
		minkowski() {
			cylinder(height=l,r=thickness);
			connector_hull(-2*thickness);
		}
		translate([0,0,-Delta]) 
			connector_hull(-2*thickness);
		translate([0,(hc_od-2*thickness)/2,l-2])
			cylinder(h=hc_l+10, r=hc_od/2-thickness);
	}
	translate([vent_w-thickness,-thickness+(vent_l-vent_l*0.8)/2,0]) 
		cube([3.75,vent_l*0.8,vent_h-12]);
	difference() {
		translate([vent_w-thickness,-thickness+(vent_l-vent_l*0.8)/2,vent_h-5])
			cube([20,vent_l*0.8,5]);
		translate([vent_w-thickness+8.5,-thickness/2+52.25,vent_h-5-Delta])
			cylinder(h=5+2*Delta, r=1.5);
		translate([vent_w-thickness+8.5,-thickness/2+168.25,vent_h-5-Delta])
			cylinder(h=5+2*Delta, r=1.5);
	}
}

connector();
