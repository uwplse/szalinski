//parametric soda bottle opener
//John Finch 12/3/13
//Added chamfer to top of cap 12/3/13


cap_dia = 30.5;
cap_height = 15;
interference = .01;  //fraction the spine protruding into cap diameter

outer_dia = 45;
inner_dia = cap_dia * (1-interference);
wall_thickness = 2;
spine_angle = 15;
spine_thickness = 1;
num_spines = 36;

spine_length = (outer_dia/2-wall_thickness-inner_dia/2)/cos(spine_angle);

fa=0.01;
fs=0.5;

module spine(){
//echo(outer_dia/2-wall_thickness-spine_length);
//echo(-spine_thickness/2);
difference(){
	translate ([outer_dia/2-wall_thickness-spine_length*cos(spine_angle),-spine_thickness/2-spine_length*sin(spine_angle),0])
	rotate([0,0,spine_angle])
	cube([spine_length+.5,spine_thickness,cap_height]);
	
	translate([outer_dia/2-wall_thickness-spine_length,spine_length/2,0])
	rotate([90,0,0])
	cylinder(h=spine_length,r1=spine_length, r2=spine_length,$fn=3);
}
}


translate([0,0,2])
difference(){
	cylinder(h = cap_height, r1 = outer_dia/2, r2 = outer_dia/2, $fn=12);
	cylinder(h = cap_height, r1 = outer_dia/2-wall_thickness, r2 = outer_dia/2-wall_thickness, $fa=fa, $fs=fs);

	}
rot_angle = 360/num_spines;
translate([0,0,2])
for ( i = [ 1 : num_spines ] )
	{
	rotate([0,0,i*rot_angle])
	spine();
	}

translate([0,0,0])
cylinder(h = 2, r1 = outer_dia/2-2, r2 = outer_dia/2, $fn=12);

//spine();





