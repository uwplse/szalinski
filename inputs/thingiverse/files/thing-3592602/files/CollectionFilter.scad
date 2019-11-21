// Handheld Water Pump - CollectionFilter.scad

head_d = 70;	// Head diameter
head_h = 70;	// Head height
head_t = 1.5;	// Head thickness

tube_d = 10;	// Tube diameter
tube_h = 40;	// Tube height
tube_t = 1;		// Tube thickness

clip_d = 18;	// Clip diameter
clip_h = 15;	// Clip height
clip_t = 3;		// Clip thickness
clip_a = 60;	// Clip angle

/*
filter_e = 70;	// Filter extent
filter_t = 1;	// Filter thickness
filter_s = 5;	// Filter step
filter_h = 3;	// Filter height
intersection () {
	union () {
		for (dy=[-filter_e/2:filter_s:filter_e/2])
			translate ([0,dy,0])
				cube ([filter_e,filter_t,100],center=true);					// Mesh X
		for (dx=[-filter_e/2:filter_s:filter_e/2])
			translate ([dx,0,0])
				cube ([filter_t,filter_e,100],center=true);					// Mesh Y
	}
	translate ([0,0,3])
		cylinder (d=head_d,h=filter_h,center=true,$fn=100);					// Circle the mesh
}
*/

filter_t = 1;	// Filter thickness
filter_n = 4;	// Filter lines
filter_h = 5;	// Filter height
filter_c = 6;	// Filter center diameter

translate ([0,0,0])
{
	grid = (head_d-filter_c-filter_t)/(filter_n*2-1);
	for (i=[1:1:filter_n]) {
		dia = grid*(i*2-1)+filter_c;
		difference () {
			cylinder (d=dia+filter_t,h=filter_h,center=false,$fn=100);	// Concentric circle
			cylinder (d=dia-filter_t,h=filter_h,center=false,$fn=100);
		}
	}
	dia1 = grid+filter_c;
	difference () {
		union () {
			translate ([0,0,filter_h/2])
				cube ([head_d,filter_t,filter_h],center=true);			// Lintel
			translate ([0,0,filter_h/2])
				cube ([filter_t,head_d,filter_h],center=true);			// Lintel
		}
		cylinder (d=dia1,h=filter_h,center=false,$fn=100);
	}
	dia2 = grid*3+filter_c;
	difference () {
		rotate ([0,0,45])
		union () {
			translate ([0,0,filter_h/2])
				cube ([head_d,filter_t,filter_h],center=true);			// Lintel
			translate ([0,0,filter_h/2])
				cube ([filter_t,head_d,filter_h],center=true);			// Lintel
		}
		cylinder (d=dia2,h=filter_h,center=false,$fn=100);
	}
}

translate ([0,0,head_h/2])
	difference () {
		cylinder (d=head_d,h=head_h,center=true,$fn=100);					// Head
		cylinder (d=head_d-head_t*2,h=head_h,center=true,$fn=100);
	}

translate ([0,0,head_h+tube_h/2])
translate ([0,0,-10])
	difference () {
		union () {
			cylinder (d=tube_d,h=tube_h,center=true,$fn=100);				// Tube
			translate ([0,0,-tube_h/2+5])
				cube ([head_d-head_t*2,3,10],center=true);					// Tube holder
		}
		cylinder (d=tube_d-tube_t*2,h=tube_h,center=true,$fn=100);			// Tube hole
	}

translate ([(head_d+clip_d)/2-head_t,0,clip_h/2])
	clip();																	// bottom clip
translate ([(head_d+clip_d)/2-head_t,0,head_h-clip_h/2])
	clip();																	// top clip

module clip() {
	difference () {
		cylinder (d=clip_d,h=clip_h,center=true,$fn=100);							// Clip
		cylinder (d=clip_d-clip_t*2,h=clip_h,center=true,$fn=100);	
		polyhedron (
			points=[ [0,0,-100],[0,0,100],				// vertical center
			         [100,-100*tan(clip_a/2),-100],[100,-100*tan(clip_a/2),100],	// angle
			         [100,+100*tan(clip_a/2),-100],[100,+100*tan(clip_a/2),100] ],	// angle
			faces=[ [0,1,3,2],[1,0,4,5],[2,3,5,4],[1,5,3],[0,2,4] ] );
	}
}



