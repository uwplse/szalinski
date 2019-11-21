//
//  support for (non-standard) toggle switches FrSky Taranis
//

// switch threaded part diameter, standard is 6.2
switch_dia = 6.0; 

// switch body width, standard is 7.0
switch_width = 8.5;

frame_w = switch_width + 2.5;
frame_l = 1*10.6;

// height of support frame, 3.8 is standard
frame_height = 3.9;

slot = 1*1.4;

frame_t_height = frame_height + 2.1;

d = 1*0.01;

difference () {
	translate([-frame_w/2, -frame_l/2, 0]) cube([frame_w, frame_l, frame_t_height]);
	union () {
		
		translate([0,0,-d]) cylinder(r=switch_dia/2, h=frame_t_height+2*d, $fn=50);
		translate([-switch_width/2, -frame_l/2 - d, frame_height]) cube([switch_width, frame_l+2*d, frame_t_height]);
		translate([-slot/2, -frame_l/2 - d, -d]) cube([slot, frame_l+2*d, slot+d]);
	}
}



 