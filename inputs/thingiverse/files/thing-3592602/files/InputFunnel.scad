// Handheld Water Pump - InputFunnel.scad

head_d = 40;	// Head diameter
head_h = 40;	// Head height
head_t = 1.5;	// Head thickness

tube_d = 10;	// Tube diameter
tube_h = 30;	// Tube height
tube_t = 1;		// Tube thickness

funn_h = 30;	// Funnel height

filter_e = 45;	// Filter extent
filter_t = 1;	// Filter thickness
filter_s = 3;	// Filter step
filter_h = 2;	// Filter height

intersection () {
	union () {
		for (dy=[-filter_e/2:filter_s:filter_e/2])
			translate ([0,dy,0])
				cube ([filter_e,filter_t,100],center=true);					// Mesh X
		for (dx=[-filter_e/2:filter_s:filter_e/2])
			translate ([dx,0,0])
				cube ([filter_t,filter_e,100],center=true);					// Mesh Y
	}
	translate ([0,0,-5])
		cylinder (d=head_d,h=filter_h,center=true,$fn=100);					// Circle the mesh
}

translate ([0,0,-head_h/2])
	difference () {
		cylinder (d=head_d,h=head_h,center=true,$fn=100);					// Head
		cylinder (d=head_d-head_t*2,h=head_h,center=true,$fn=100);
	}

translate ([0,0,funn_h/2])
	difference () {
		cylinder (d1=head_d,d2=tube_d,h=funn_h,center=true,$fn=100);		// Funnel
		cylinder (d1=head_d-head_t*2,d2=tube_d-tube_t*2,h=funn_h,center=true,$fn=100);
	}

translate ([0,0,funn_h+tube_h/2])
	difference () {
		cylinder (d=tube_d,h=tube_h,center=true,$fn=100);					// Tube
		cylinder (d=tube_d-tube_t*2,h=tube_h,center=true,$fn=100);
	}


