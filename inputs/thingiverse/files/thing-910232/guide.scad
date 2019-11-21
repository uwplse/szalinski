bolt_hole = 4.2;

cable_hole = 9;
rise = 2.5;
thickness = 1;
gap = 2.5;

$fn = 60;

module tabs() {
	//base
	cylinder(h = rise , r = 6 );
	translate([-6,0,0])
		hull() {
			cube([12,8,rise]);
			translate([0,12-1,rise - thickness])cube([12,1,thickness]);
		}


	//top
	translate ([0,0,rise + gap])
	{
		translate([-6,0,0])cube([12,12 - cable_hole/2,thickness]);
		cylinder(h = thickness , r = 6 );
	}

}

module loop() {
	translate([6,0,0])
	rotate([0,-90, 0])
	difference() {
		cylinder(h = 12, r = cable_hole/2 + thickness);
		cylinder(h = 12, r = cable_hole/2);
		translate([-cable_hole/2 ,-cable_hole , 0])
		cube([gap,cable_hole,12]);
	}
	

}

module main() {
	tabs();
	translate([0, 12,cable_hole/2 + rise])

	//loop();
	loop();

}

difference() {
	main();
	cylinder(h = 20, r = bolt_hole/2);
}

//tabs();
