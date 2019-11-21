markers = 6;

height = 50;
thickness = 3; // General padding between markers

eraser_width = 55;
eraser_depth = 35;

marker_rad = 10; // This radius value works for standard expo dry erase markers
marker_ridge_height = 5; // sure, why not?

fastener_width = 15;

nudge = 0.1; 
precision = 100;

difference(){
	union(){
		//eraser block
		color("blue")
		cube([eraser_width + thickness * 2, eraser_depth + thickness * 2, height + thickness]);

		//markers block
		color("green")
		translate([eraser_width + thickness * 2,0,0])
		cube([(marker_rad * 2 + thickness) * markers, marker_rad * 2 + thickness * 2, height + thickness]);

		color("red")
		fasteners();
	}
	
	//eraser hole
	translate([thickness, thickness, thickness])
	cube([eraser_width, eraser_depth, height]);
	
	//marker holes
	translate([thickness * 2 + eraser_width + marker_rad,thickness + marker_rad,thickness])
	markers();
}

module fastener(){
	cube([fastener_width, thickness, height + thickness]);
}

module fasteners(){
	translate([-fastener_width,0,0])
	fastener();

	translate([eraser_width + thickness * 2 + (marker_rad * 2 + thickness) * markers, 0, 0])
	fastener();
}

module markers(){
	for(i = [0:(markers - 1)]){
		translate([(marker_rad * 2 + thickness) * i, 0, 0])
		union(){
			cylinder(r=marker_rad, h = height, $fn = precision);
			
			
			translate([0,0,height - marker_ridge_height])
			cylinder(r1 = marker_rad, r2 = marker_rad + thickness / 2 - nudge, h = marker_ridge_height, $fn = precision);
		}
	}
}
