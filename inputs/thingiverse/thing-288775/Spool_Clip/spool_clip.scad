/* [Global] */

//Size of your spool (mm)
spool_radius = 193.6;

//Thickness of your spool's edge (mm)
spool_thickness = 6.3;

//How deep the clip will go in (mm)
clip_depth = 5;

//Length past the edge of the spool
clip_extend = 10;

//Thickness of the thinnest part of the clip (mm)
clip_thickness = 3;

//Remove sharp corner (causes overhang) 
clip_cut = true; //[true, false];

print_part();

module print_part() {
	
rotate(a=[-90,0,0])
translate([0,-spool_radius,0])
	difference(){
		//olor("yellow")
			translate([0,0,-(spool_thickness+(2*clip_thickness))/2])
				cube([sqrt(2*spool_radius*clip_extend - pow(clip_extend,2)), 
						spool_radius, 
						spool_thickness+(2*clip_thickness)]);

		//color("white")
		cylinder(r=spool_radius, h=spool_thickness, center=true, $fn=50);

		//color("gray")
			cylinder(r=spool_radius-clip_depth, h=spool_thickness+(2*clip_thickness)+1, center=true, $fn=50);

		if( clip_cut == true )
		//color("gray")
			translate([sqrt(2*spool_radius*clip_extend - pow(clip_extend,2)),spool_radius,0])
				rotate(a=[0,0,45])
					cube([clip_extend/4,clip_extend/4,spool_thickness+(2*clip_thickness)+1], center=true);
	}




}