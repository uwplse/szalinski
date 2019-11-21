/* [MAIN] */

// outside diameter of the pipe
od=38.26;

// This is the diameter of the fins.  Make this sligtly larger than the inside diameter of the pipe
fin_dia=36.27;

// How thick the fin layers are.
layer_thickness=0.8;

// The number of fin layers
num_layers=3;

// The height of the entire foot INCLUDING the part that goes inside the pipe.
total_h=17.33;

// The height of the bottom pad of the foot
pad_h=3.93;

// Diameter of the x-shaped center support
x_dia=25.89;

// Thickness of the x-shaped center support
x_thick=1.04;

// Diameter of the circular cutouts
circ_dia=9.06;

// How many circular cutouts
num_circ=4;

// How far from the center to the edge of the circular cutouts
center_to_circ_edge=15.66;

// How big a bevel to add to the bottom of the foot
bevel_h=0.5;

// if true, will cut in half and flip sideways for printing
printable=0; // [0:false,1:true]

module foot(){
	// calc
	layers_h=total_h-pad_h;
	layer_spacing=layers_h/(num_layers+0);

	// pad
	cylinder(r2=od/2,r1=od/2-bevel_h,h=bevel_h,$fn=64);
	translate([0,0,bevel_h]) cylinder(r=od/2,h=pad_h-bevel_h,$fn=64);
	// layers
	difference(){
		union(){
			// layers
			for(z=[pad_h+layer_spacing-layer_thickness:layer_spacing:total_h]){
				translate([0,0,z]) cylinder(r=fin_dia/2,h=layer_thickness);
			}
		}
		for(a=[0:360/num_circ:359.99]){
			rotate([0,0,a+45]) translate([center_to_circ_edge+circ_dia/2,0,pad_h]) cylinder(r=circ_dia/2,h=total_h);
		}
	}
	// x
	translate([-x_dia/2,-x_thick/2,0]) cube([x_dia,x_thick,total_h]);
	translate([-x_thick/2,-x_dia/2,0]) cube([x_thick,x_dia,total_h]);
}
	
if(printable==1){
	difference(){
		union(){
			translate([1,0,0]) rotate([0,90,0]) foot();
			translate([-1,0,0]) rotate([0,-90,0]) foot();
		}
		translate([-total_h*1.5,-od,-od]) cube([total_h*3,od*2,od]);
	}
}else{
	foot();
}