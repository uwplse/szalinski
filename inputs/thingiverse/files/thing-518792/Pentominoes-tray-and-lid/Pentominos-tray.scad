$fn=32;
length=10;
radius = 1;
space = 0.2;
tray_rows=6;
tray_cols=10;

module myCube() {
	dist = length/2-radius-space;
	hull() {
		translate([dist,dist,dist]) sphere(r=radius);
		translate([-dist,dist,dist]) sphere(r=radius);
		translate([dist,-dist,dist]) sphere(r=radius);
		translate([-dist,-dist,dist]) sphere(r=radius);
		translate([dist,dist,-dist]) sphere(r=radius);
		translate([-dist,dist,-dist]) sphere(r=radius);
		translate([dist,-dist,-dist]) sphere(r=radius);
		translate([-dist,-dist,-dist]) sphere(r=radius);
	}
}
module myConnect() {
	translate([space+radius-length/2,space+radius-length/2,space+radius-length/2]) cube([length-2*space-2*radius,length-2*space-2*radius,length-2*space-2*radius]);
}

module tray() {
	union() {
	translate([-0.5 * length - radius, -0.5 * length - radius, -2 * radius]) cube([2 * radius + length * tray_cols, 2 * radius + length * tray_rows, radius]);
	difference() {
	translate([-0.5 * length, -0.5 * length, -1 * radius]) cube([length * tray_cols, length * tray_rows, radius]);
	translate([0, 0, length/2 - radius]) {
		union() {
			for ( i = [0 : tray_cols - 1] ) {
				for ( j = [0 : tray_rows - 1] ) {
					translate([i*length,j*length, 0]) myCube();
				}
			}
		
			for ( i = [0 : tray_cols - 2] ) {
				for ( j = [-0.5 : tray_rows - 1] ) {
					translate([(i+0.5)*length,(j+0.5)*length,0]) myConnect();
				}
			}
			for ( i = [-0.5 : tray_cols - 1] ) {
				for ( j = [0 : tray_rows - 2] ) {
					translate([(i+0.5)*length,(j+0.5)*length,0]) myConnect();
				}
			}
		}
	}
	}
	}
}
module lid() {
	difference() {
		translate([-0.5 * length - radius, -0.5 * length - radius, -1 * radius]) cube([2 * radius + length * tray_cols, 2 * radius + length * tray_rows, 2 * radius + length]);
		translate([-0.5 * length, -0.5 * length, -0 * radius]) cube([length * tray_cols, length * tray_rows, 2 * radius + length]);
	}			
}
tray();