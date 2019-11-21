// Small diameter(mm)
diams = 60; // [40:100]

// Wide diameter (mm)
diamw = 70; // [40:100]

/*[Hidden]*/
$fa=5;

difference(){
	resize(newsize=[diams,diamw,100])sphere(r=30);
	translate([-70,-70,25]) cube([140,140,100]);
	translate([-70,-70,-125]) cube([140,140,100]);
	resize(newsize=[diams-3,diamw-3,96])sphere(r=30);

	difference() {
		translate ([5,-10,-50]) rotate([0,0,-45]) cube([40,40,100]);
		hull() {
			translate([5,-10,15]) rotate([0,90,-45])cylinder(r=10,h=40);
			translate([5,-10,-15]) rotate([0,90,-45])cylinder(r=10,h=40);
		}
	}

	difference() {
		translate ([33,40,-50]) rotate([0,0,-135]) cube([40,40,100]);
		hull() {
			translate([33,40,15]) rotate([0,90,-135])cylinder(r=10,h=50);
			translate([33,40,-15]) rotate([0,90,-135])cylinder(r=10,h=50);
		}
	}
}


