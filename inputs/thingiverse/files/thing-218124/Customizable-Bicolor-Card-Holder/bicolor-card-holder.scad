// preview[view:south, tilt:bottom]

/* [Global] */

// Load a 150x40 pixel image. This is the artwork for the logo. The background should be black and the logo white. If not, make sure to click the Invert Colors checkbox.
logo = "logo.dat"; // [image_surface:150x40]

// What Z height would you like to pause the printer to change the filament for the logo color (mm)?
z_height = 0.6;

/* [Hidden] */

holder_x = 100;
holder_y = 50;
holder_z = 25;
card_x = 91;
card_y = 13;
card_z = 22;
corner_radius = 5;
box_x = holder_x - (corner_radius * 2);
box_y = holder_y - (corner_radius * 2);
face_z = z_height;
offset_x = (holder_x / 2) - corner_radius;
offset_y = (holder_y / 2) - corner_radius;
logo_x = 90;
logo_y = 24;
scale_x = 150;
scale_y = 40;

difference() {
	translate([0, 0, face_z]) {
		translate([0, 0, -(face_z/2)]) {
			cube([box_x, holder_y, face_z], center=true);
			cube([holder_x, box_y, face_z], center=true);
			translate([ offset_x,  offset_y, 0]) cylinder(h=face_z, r=corner_radius, center=true);
			translate([-offset_x,  offset_y, 0]) cylinder(h=face_z, r=corner_radius, center=true);
			translate([ offset_x, -offset_y, 0]) cylinder(h=face_z, r=corner_radius, center=true);
			translate([-offset_x, -offset_y, 0]) cylinder(h=face_z, r=corner_radius, center=true);
		}
		translate([0, -holder_y / 2, -0.01]) scale([1, 0.898, 1]) rotate([-26, 0, 0]) difference() {
			translate([0, holder_y / 2, holder_z/2]) {
				cube([box_x, holder_y, holder_z], center=true);
				cube([holder_x, box_y, holder_z], center=true);
				translate([ offset_x,  offset_y, 0]) cylinder(h=holder_z, r=corner_radius, center=true);
				translate([-offset_x,  offset_y, 0]) cylinder(h=holder_z, r=corner_radius, center=true);
				translate([ offset_x, -offset_y, 0]) cylinder(h=holder_z, r=corner_radius, center=true);
				translate([-offset_x, -offset_y, 0]) cylinder(h=holder_z, r=corner_radius, center=true);
			}
			rotate([26, 0, 0]) translate([0, holder_y / 2, -holder_z/2]) cube([holder_x + 1, holder_y * 4/3, holder_z], center=true);
		}
	}
	translate([0, -holder_y/2+3, 0]) rotate([-30, 0, 0]) translate([0, card_y/2, 0]) cube([card_x, card_y, card_z*2], center=true);
	translate([0, (logo_y/2)-3, -0.01]) mirror([1,0,0]) rotate([0, 0, 180]) {
		scale([(logo_x)/scale_x, (logo_y)/scale_y, z_height]) surface(file=logo, center=true, convexity=5);
	}
}

