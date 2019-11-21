$fn=150; 

// Diameter of the axis (mm)
axis_d = 10;

// Total height of the axis (mm)
axis_h = 68;

// Total height of the axis container (mm)
container_h = 65.5;

// Outer diameter of the axis container (mm)
container_od = 20;

// Inner diameter of the axis container (mm)
container_id = 10.5;

// Diameter of the clearing for bearings (on both ends) (mm)
bearing_d = 15;

// Depth of the clearing (mm)
bearing_h = 4.5;

// Width of the mount stand (mm)
mount_w = 70.5;

// Length of the mount stand (mm)
mount_l = 160;

// Height of the mount stand (mm)
mount_h = 30;

// Rounding radius of the mount stand (mm)
mount_r = 2;

// Distance of the center of the axis cutout from the bottom of mount stand (mm)
mount_axis_z = 19;

// Height of the mount plate (mm)
mount_plate_h = 2;

// Diameter of the mount plate (mm)
mount_plate_d = 25;

// Height of the mount plate nose (mm)
mount_nose_h = (axis_h - container_h) / 2 - 0.5;

// Outer diameter of the mount plate nose (mm)
mount_nose_od = axis_d + 5;

// Inner diameter of the mount plate nose (mm)
mount_nose_id = axis_d + 0.5;

module outeraxis() {
	difference() {
		cylinder(h = container_h, r = container_od/2);
		translate([0,0,-.02]) cylinder(h = bearing_h, r = bearing_d/2);
		translate([0,0,container_h-bearing_h+.02]) cylinder(h = bearing_h, r = bearing_d/2);
		cylinder(h = container_h, r = container_id/2);
	}
}

module axis() {
	cylinder(h = axis_h, r = axis_d/2);
}

module roundedRect(size, radius) {
	x = size[0]-radius; y = size[1]-radius; z = size[2];
	linear_extrude(height=z)
	hull() {
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);

		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);

		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);

		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}

module mount() {
	clearing_l = mount_l + 0.5;
	clearing_w = container_h + 0.2;
	clearing_h = mount_h;

	midclear_w = container_h;
	midclear_l = mount_l*0.7;
	midclear_r = 20;

	axis_y = (mount_w-axis_h)/2;
	cut_r = container_od/2+0.2;
	cut_h = container_h+1;

	difference() {
		// Basic shape;
		translate([0,mount_w/2,mount_h/2]) rotate([90,0,90])
			roundedRect(size = [mount_w,mount_h,mount_l], radius = mount_r);
		translate([-0.1,clearing_w/2+(mount_w-clearing_w)/2,clearing_h/2+mount_r])
			rotate([90,0,90])
			roundedRect(size = [clearing_w,clearing_h,clearing_l], radius = mount_r);
		translate([mount_l/2,mount_w+0.1,mount_l*1.1+16]) rotate([90,0,0])
			cylinder(h = mount_w+0.5, r = mount_l*1.1);

		// Axis cutouts.
		translate([container_od/2,axis_h+axis_y,mount_axis_z])
			rotate([90,0,0])
			cylinder(h = axis_h+0.2, r = axis_d/2+0.2);
		translate([mount_l-container_od/2,axis_h+axis_y,mount_axis_z])
			rotate([90,0,0])
			cylinder(h = axis_h+0.2, r = axis_d/2+0.2);

		// Outer axis cutouts.
		translate([cut_r,cut_h+(mount_w-cut_h)/2,mount_axis_z])
			rotate([90,0,0])
			difference() {
				cylinder(h = cut_h, r = cut_r);
				cylinder(h = cut_h+0.2, r = bearing_d/2-0.1);
			}
		translate([mount_l-cut_r,cut_h+(mount_w-cut_h)/2,mount_axis_z])
			rotate([90,0,0])
			difference() {
				cylinder(h = cut_h, r = cut_r);
				cylinder(h = cut_h+0.2, r = bearing_d/2-0.1);
			}

		// One large cutout...
		translate([midclear_l/2+(mount_l-midclear_l)/2,midclear_w/2+(mount_w-midclear_w)/2,-0.1])
			roundedRect(size = [midclear_l,midclear_w,mount_h], radius = midclear_r);

		// ...or two smaller ones.
		//translate([midclear_l/4+(mount_l-midclear_l)/2-5,midclear_w/2+(mount_w-midclear_w)/2,-0.1])
		//	roundedRect(size = [midclear_l/2,midclear_w,mount_h], radius = midclear_r);
		//translate([midclear_l/4+mount_l/2+5,midclear_w/2+(mount_w-midclear_w)/2,-0.1])
		//	roundedRect(size = [midclear_l/2,midclear_w,mount_h], radius = midclear_r);
	}
}

module mountplate() {
	union() {
		cylinder(h = mount_plate_h, r = mount_plate_d/2);
		difference() {
			cylinder(h = mount_nose_h + mount_plate_h, r = mount_nose_od/2);
			translate([0,0,mount_plate_h+.005])
				cylinder(h = mount_nose_h, r = mount_nose_id/2);
			translate([3,-mount_nose_od/2,mount_plate_h+.005])
				cube(size = [mount_nose_od/2,mount_nose_od,mount_nose_h]);
		}
	}
}

translate([container_od/2,0,0]) outeraxis();
translate([container_od*1.5+4,0,0]) outeraxis();

translate([mount_l/2 + axis_d/2 + 2,0,0]) axis();
translate([mount_l/2 - axis_d/2 - 2,0,0]) axis();

//translate([mount_l - mount_plate_d/2,0,0]) mountplate();
//translate([mount_l - mount_plate_d - 4 - mount_plate_d/2,0,0]) mountplate();

translate([0,mount_plate_d/2+4,0])
mount();
