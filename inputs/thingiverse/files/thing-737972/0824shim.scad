// Created by Heindal at Thingiverse on March 2015

// Values for user to edit

// Thickness of shim, mounting plate, or standoff
thickness = 2.5; // [1:25]

// Length of shim
length = 24; // [8,12,24,40,56]

// Hole Diameter
holeDia = 4.15; // [3.4:3.4mm for Tap, 4.15:4.15mm for Tight Fit, 4.3:4.3mm for Loose Fit] 

/* [Hidden] */
// Calculated values - edit at your own risk
width = 24;

module rounded_box(l,w,h,r_edge){

cube(size=[l-2*r_edge,w-2*r_edge,h ],center=true);

for (x = [l/2-r_edge,-(l/2-r_edge) ]) {
	for (y = [(w/2-r_edge),-(w/2-r_edge)]) {
		translate([x,y,0]) cylinder(r1=r_edge,r2=r_edge,h=h,center=true,$fn=40);
	}
}
translate([0,w/2-r_edge,0]) cube(size=[l-2*r_edge,2*r_edge,h ],center=true);
translate([0,-(w/2-r_edge),0]) cube(size=[l-2*r_edge,2*r_edge,h ],center=true);
translate([(l/2-r_edge),0,0]) cube(size=[2*r_edge,w-2*r_edge,h ],center=true);
translate([-(l/2-r_edge),0,0]) cube(size=[2*r_edge,w-2*r_edge,h ],center=true);

}

difference() {
	rounded_box(length,width,thickness,2);
	// mounting holes to match the rail
	for (x = [-16*floor(length/16)/2 : 16 : 16*floor(length/16)/2]) {
		for (y = [-8,8]) {
			translate([x,y,0]) cylinder(r=holeDia/2, h=thickness+1, center=true, $fn=16);
		}
	}
}
