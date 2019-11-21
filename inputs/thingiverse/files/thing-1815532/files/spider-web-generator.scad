smallest_radius = 20;
strands = 6;
width = 2.5;
height = 2.5;
wedges = 8;
strand_fn = 24;
scale = 1;
twist = 0;

module star(radius, wedges, strand_fn) {
	angle = 360 / wedges;
	difference() {
		circle(radius, $fn = wedges);
		for(i = [0:wedges - 1]) {
			rotate(angle / 2 + angle * i) translate([radius, 0, 0]) 
			    scale([0.8, 1, 1]) 
				    circle(radius * sin(angle / 2), $fn = strand_fn);
		}
	}
}

module frame(width) {
    difference() {
        children();
        offset(r = -width) children();
    }
}

module spider_web(smallest_radius, strands, width, height, wedges, strand_fn) {
	for(i = [0:strands - 1]) {
		frame(width) star(smallest_radius * i, wedges, strand_fn);
	}

	angle = 360 / wedges;
	
	for(i = [0:wedges - 1]) {
		rotate(angle * i) translate([0, -width / 2, 0]) 
			square([smallest_radius * strands, width]);
	}
}

linear_extrude(height, scale = scale, twist = twist) 
    spider_web(smallest_radius, strands, width, height, wedges, strand_fn);



