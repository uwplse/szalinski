// The length of the backplate of the mount
backplateHeight = 60;

// The width of the backplate of the mount, exluding the sides
backplateWidth = 60;

// The height of the front plate
frontPlateHeight = 20;

// The thickness of the phone
phoneThickness = 9;

module plate(){
	cube([backplateWidth, backplateHeight, 5]);
	translate([-3, -3, 5 + phoneThickness]) cube([backplateWidth + 6, frontPlateHeight + 3, 3]);
	translate([-3, -3, 0]) cube([backplateWidth + 6, 3, phoneThickness + 5]);
	translate([backplateWidth, 0, 0]) cube([3, backplateHeight, 14]);
	translate([-3, 0, 0]) cube([3, backplateHeight, 14]);
}

difference() {
	plate();
	translate([(backplateWidth/4), 30, -2]) cylinder(r = 2.5, h = 12);
	translate([3*(backplateWidth/4), 30, -2]) cylinder(r = 2.5, h = 12);
	translate([(backplateWidth/4), 30, 4]) cylinder(r = 4, h = 2);
	translate([3*(backplateWidth/4), 30, 4]) cylinder(r = 4, h = 2);
}