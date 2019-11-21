module storage(hole, hh)
{
	ch=20;
	//translate([-hole, -hole, 0])
	/*intersection()
	{
		translate([ch, ch, 0]) linear_extrude(height=hh) offset(r=ch, chamfer=true) square([hole*2-ch*2, hole*2-ch*2]);
		translate([hole*2, ch, ch]) rotate([0, -90, 0]) linear_extrude(height=hole*2) offset(r=ch, chamfer=true) square([hole*2-ch*2, hh-ch*2]);
		translate([ch, 0, hole*2-ch]) rotate([-90, 0, 0]) linear_extrude(height=hole*2) offset(r=ch, chamfer=true) square([hh-ch*2, hole*2-ch*2]);
	}*/
/*	union()
	{
		sphere(r=hole);
		cylinder(h=hh, r=hole);
	}*/
	h2c2=hole*2-ch*2;
	h2c=hole*2-ch;
	translate([-hole, -hole, -hole]) union()
	{
		// horizontal chamfers
		translate([ch, ch, ch]) rotate([0, 90, 0]) cylinder(h=h2c2, r=ch);
		translate([ch, ch, ch]) rotate([-90, 0, 0]) cylinder(h=h2c2, r=ch);
		translate([ch, h2c, ch]) rotate([0, 90, 0]) cylinder(h=h2c2, r=ch);
		translate([h2c, ch, ch]) rotate([-90, 0, 0]) cylinder(h=h2c2, r=ch);
		// vertical chamfers
		translate([ch, ch, ch]) cylinder(h=hh-ch, r=ch);
		translate([ch, h2c, ch]) cylinder(h=hh-ch, r=ch);
		translate([h2c, ch, ch]) cylinder(h=hh-ch, r=ch);
		translate([h2c, h2c, ch]) cylinder(h=hh-ch, r=ch);
		// center
		translate([ch, ch, ch]) cube([h2c2, h2c2, hh-ch]);
		// sides
		translate([0, ch, ch]) cube([ch, h2c2, hh-ch]);
		translate([ch, 0, ch]) cube([h2c2, ch, hh-ch]);
		translate([h2c, ch, ch]) cube([ch, h2c2, hh-ch]);
		translate([ch, h2c, ch]) cube([h2c2, ch, hh-ch]);
		// bottom
		translate([ch, ch, 0]) cube([h2c2, h2c2, ch]);
		// corners
		translate([ch, ch, ch]) sphere(r=ch);
		translate([h2c, ch, ch]) sphere(r=ch);
		translate([ch, h2c, ch]) sphere(r=ch);
		translate([h2c, h2c, ch]) sphere(r=ch);
	}
}

side=180;
height=80;
hole=40;
bottom=2;
bighole=45;
corner=10;
$fn=100;

//storage(hole, height);
difference()
{
	union()
	{
		difference()
		{
			cube([side, side, height]);
			cube([corner, corner, height]);
			translate([side-corner, 0, 0]) cube([corner, corner, height]);
			translate([side-corner, side-corner, 0]) cube([corner, corner, height]);
			translate([0, side-corner, 0]) cube([corner, corner, height]);
		}
		translate([corner, corner, 0]) cylinder(r=corner, h=height);
		translate([side-corner, corner, 0]) cylinder(r=corner, h=height);
		translate([side-corner, side-corner, 0]) cylinder(r=corner, h=height);
		translate([corner, side-corner, 0]) cylinder(r=corner, h=height);
	}
	union()
	{
		translate([bighole, bighole, hole+bottom]) storage(hole, height);
		translate([bighole+side/2, bighole, hole+bottom]) storage(hole, height);
		translate([bighole, bighole+side/2, hole+bottom]) storage(hole, height);
		translate([bighole+side/2, bighole+side/2, hole+bottom]) storage(hole, height);

		translate([side/2-5, 0, height-6]) rotate([0, 90, 0]) cylinder(h=10, r=2);
		translate([side/2-5, side, height-6]) rotate([0, 90, 0]) cylinder(h=10, r=2);
		translate([0, side/2-5, height-6]) rotate([-90, 0, 0]) cylinder(h=10, r=2);
		translate([side, side/2-5, height-6]) rotate([-90, 0, 0]) cylinder(h=10, r=2);

//		translate([90, 90, 60]) union()
//		{
//			sphere(r=20);
//			cylinder(h=height, r=20);
//		}
	}
}
