//Golf Ball Marker
//March 7, 2013 (happy birthday to me!)
//by Sawdusty
//http://www.thingiverse.com/thing:58641
include <write/Write.scad>

//CUSTOMIZER VARIABLES
//	Large diameter of the ball marker
marker_diameter = 15;	//	[10:20]
//	Height of the spike
spike_height = 5;	//	[5:8]
// Your initials
initials = "ABC";
//	Letter Height
letter_height = 12; // [9, 10, 11, 12, 13]
//	Letter type
letter_type = "fancy";	//	[fancy,plain]
// View / Print
flip_model_to = 180;	//	[180:View and Customize, 0:Export and Print]
//CUSTOMIZER VARIABLES END



rotate(a=[0,flip_model_to,flip_model_to])
difference() {
	union() {
		cylinder(h = 1, r1 = (marker_diameter - 1), r2 = marker_diameter, center = false, $fs = 0.01);
		cylinder(h = spike_height, r1 = 2, r2 = .25, center = false, $fs = 0.01);
	}
	mirror([ 0, 1, 0 ])
	if (letter_type == "fancy") {
		translate([0, 0.35, 0])
		write(initials,t=.25,h=letter_height,font="write/BlackRose.dxf",center=true,space=0.9);
	}
	else
	{
		write(initials,t=.25,h=letter_height,font="write/Letters.dxf",center=true,space=0.9);
	}
}