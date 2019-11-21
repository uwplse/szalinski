rack_width = 5;
rack_length = 10;
thickness = 1;

base_height = 20;
base_gap = 20;
rod_height = 30 + base_height;
rod_width = 5;
row_space = base_gap + rod_width;


for (w = [0:rack_width]) {
	translate([0, w * row_space, 0]) {
		for(i = [0:rack_length-1]) {
			translate([i * row_space, 0,0]) rod();
			translate([i * row_space, 0,0]) gap();
		}
		translate([rack_length * (rod_width + base_gap), 0,0]) rod();
	}
}

translate([base_gap*2, -row_space/2, 0]) support();
translate([rack_length * row_space - base_gap*2 + rod_width, -row_space/2, 0]) support();




module rod() {
	rotate([90,0,0]) linear_extrude(thickness) square([rod_width, rod_height]);
}


module gap() {
	rotate([90,0,0]) translate([rod_width,0,0]) linear_extrude(thickness) square([base_gap, base_height]);	
}

module support() {
	rotate([90,0,90])
	linear_extrude(thickness)
	square([(rack_width+1)*row_space, base_height]);
}
	