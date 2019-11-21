


pen_dia=18.5; //[15:25]
wall=3;
pens=4; //[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
width=pen_dia*pens+(pens-1)*wall+2*wall;

difference()
{
union()
{
difference()
{

	minkowski() {
		translate([2.5, 0, 2.5])
		cube([width-5, 27, 60-5]);
		sphere(d=5, $fn=50);
	}

	for (i=[0:1:pens-1])
	{
		translate([wall+i*wall+i*pen_dia+pen_dia/2, pen_dia/2+wall, wall])
		cylinder(d=pen_dia, h=60);
	}

	translate([wall, -wall, 7*wall])
	cube([width-2*wall, 40, 60-8*wall]);

	translate([wall, -wall, wall])
	cube([width-2*wall, 40, 5*wall]);

	translate([0, 27, 0])
	cube([width+10, 10, 65]);

}

translate([6.5, 27, 54.5])
rotate([90, 0, 0])
cylinder(d=10, h=5);


translate([width-6.5, 27, 54.5])
rotate([90, 0, 0])
cylinder(d=10, h=5);

}

translate([6.5, 28, 54.5])
rotate([90, 0, 0])
cylinder(d=8, h=5);


translate([width-6.5, 28, 54.5])
rotate([90, 0, 0])
cylinder(d=8, h=5);


}