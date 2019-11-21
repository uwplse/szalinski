swatter_thickness=1.35;
hole_diameter=4;
hole_spacing=4.75;
width=85;
height=95;
border=6;
corner_radius=6;
dowel_size=5;
dowel_socket_length=20;
dowel_socket_thickness=3;


union() {
	difference() {
		cube([width,height,swatter_thickness]);
        corner_rounding(r=corner_radius,h=swatter_thickness);
        translate([width,0]) rotate([0,0,90]) corner_rounding(r=corner_radius,h=swatter_thickness);
        translate([width,height]) rotate([0,0,180]) corner_rounding(r=corner_radius,h=swatter_thickness);
        translate([0,height]) rotate([0,0,270]) corner_rounding(r=corner_radius,h=swatter_thickness);
        /* Attention: this original code only works with quadratic swatters but not with rectangualar:
		for (corner=[1:4])
			translate([width/2,height/2,0]) rotate([0,0,90*corner]) translate([-width/2,-height/2,0]) corner_rounding(r=corner_radius,h=swatter_thickness);
        */
		translate([border,border,0]) hole_grid(hole_radius=hole_diameter/2, xlength=width-border*2, ylength=height-border*2, xspacing=hole_spacing, yspacing=hole_spacing, h=swatter_thickness);

	}
	translate([width/2,0,dowel_size/2+dowel_socket_thickness]) rotate([-90,0,0]) difference() {
		union() {
			cylinder(r=dowel_size/2+dowel_socket_thickness,h=dowel_socket_length+dowel_socket_thickness, $fn=20);
			translate([-dowel_size/2-dowel_socket_thickness,0,0]) cube([dowel_size+dowel_socket_thickness*2,dowel_size/2+dowel_socket_thickness,dowel_socket_length+dowel_socket_thickness]);
			translate([0,0,dowel_socket_length+dowel_socket_thickness]) sphere(r=dowel_size/2+dowel_socket_thickness, $fn=20);
		}
		cylinder(r=dowel_size/2, h=dowel_socket_length, $fn=20);
	}
}

module hole_grid(hole_radius=1.5, xspacing=5, yspacing=5, h=3, xlength=86, ylength=86) {
	ystart=(ylength%yspacing)/2;
	num_rows=(ylength-ylength%yspacing)/yspacing+1;
	echo("rows:", num_rows);

	for (row_num=[1:num_rows])
		translate([0,ystart+(row_num-1)*yspacing,0]) hole_row(hole_radius,xspacing, h, xlength,row_num%2);

}

module hole_row(hole_radius=1.5, spacing=5, h=3, length=86, odd=0) {
	start=(length%spacing)/2+odd*spacing/2;
	num_holes=(length-length%spacing)/spacing+1-odd;

	for (hole_num=[1:num_holes]) {
		translate([(hole_num-1)*spacing+start,0,0]) rotate([0,0,30]) cylinder(r=hole_radius, h=3, $fn=6);
	}
	
}

module corner_rounding(r=4,h=3) {
	difference() {
		translate([-r, -r,0]) cube([r*2,r*2,h]);
		translate([r,r,0]) cylinder(r=r+0.1,h=h, $fn=20);
	}
}