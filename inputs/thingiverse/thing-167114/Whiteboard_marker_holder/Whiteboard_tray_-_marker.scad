wall_thickness = 2;
tray_height = 7;
tray_width = 15;
clip_height = 11;
clip_width = 4;
holder_length = 140;

module marker_holder() {
  translate([-holder_length / 2, -(clip_width + tray_width) / 2, 0]) {
		union() {
      	difference() {
        		cube([holder_length, clip_width + 2 * wall_thickness, clip_height]);
        			translate([0, wall_thickness, wall_thickness]) {
          			cube([holder_length, clip_width, clip_height]);
      			}
    		}
    		translate([0, clip_width + wall_thickness, 0]) {
      		difference() {
        			cube([holder_length, tray_width + 2 * wall_thickness, tray_height]);
        				translate([0, wall_thickness, wall_thickness]) {
          				cube([holder_length, tray_width, tray_height]);
						}
        		}
      	}
    	}
  	}
}

marker_holder();

