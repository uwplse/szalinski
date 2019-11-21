//
//  parametric wing nut
//  


major = 4.0; // [ 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0 ]
minor = major*0.75; // 2.25 for M3, 3.0 for M4, 3.9 for M5, 4.6 for M6, 6.25 for 

have_wings = true; // [ true, false ]

d = 1*0.01;

nutheight = 2*major;
wingmaxr = major*1.3;
wingwall = major*0.5;

module wing() {
	if (have_wings) hull () {
		translate([nutheight/2,0,major]) rotate([90,0,0]) 
			translate([0,0,-wingwall/2]) cylinder(r = nutheight/2, h = wingwall, $fn=30);
		translate([wingmaxr*2.0,0,wingmaxr*1.4]) rotate([90,0,0]) 
			translate([0,0,-wingwall/2]) cylinder(r = wingmaxr, h = wingwall, $fn=30);
	}
}

difference () {
	union () {
		cylinder(r = major, h = nutheight, $fn=6);
		wing();
		rotate([0, 0, 180]) wing();
	}
	translate([0, 0, -d]) cylinder(r = minor/2, h = nutheight+2*d, $fn=30);
}

