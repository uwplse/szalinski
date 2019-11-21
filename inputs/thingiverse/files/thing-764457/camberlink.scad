
shaft = 4.5;
shaft_insert = 23;
base_thickness = 11;
link_outer_dia = 15;
total_height = 40;
ball_dia = 8;
insert_extra_dia = 1;
flat_height = 6;
link_center_z = total_height-(ball_dia);
$fn=100;

module body() {

	//where the shaft gets screwed in
	difference() {
		rotate([0,0,00]){cylinder(h = total_height, r1=base_thickness/2, r2=link_outer_dia/2, $fn=6);}	
		removals();
	}
}

module removals() {
		cylinder(h = shaft_insert, r=shaft/2, $fn=100);
		//main link hole
		translate([0,0,link_center_z]) {sphere(r=ball_dia/2);}

		//inserts
		translate([0,flat_height-1,link_center_z]) {sphere(r=(ball_dia+insert_extra_dia)/2);}

		translate([0,flat_height-1,link_center_z]) {
			rotate([90,0,0]) {
				cylinder(h=80, r=(ball_dia-insert_extra_dia)/2);
			}
		}

//		translate([0,-flat_height+1,link_center_z]) {sphere(r=(ball_dia+insert_extra_dia)/2);}
		translate([0,500/2,link_center_z]) {cube(size=[500-flat_height,500-flat_height,total_height-(ball_dia+insert_extra_dia)],center=true);}
//		translate([0,-500/2,link_center_z]) {cube(size=[500-flat_height,500-flat_height,total_height-(ball_dia+insert_extra_dia)],center=true);}
}

//TODO: trig the angle to rotate onto flat
rotate([87.5,0,0]) {
	body();
}


