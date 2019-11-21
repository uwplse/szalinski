$fn = 200;
cup_height = 20; //[20:30]
plate_bottom = 15;//[5:15]
plate_top = 20;//[5:20]
spoon_handler_length = 15; //[10:50]
//=========================================//
//cup
//cup main part
module main()
{
	difference()
	{
	cylinder(cup_height,10,10);
	translate([0,0,3]) cylinder(cup_height-3,9,9);
	linear_extrude(height=0.5)
	translate([0,0,19])circle(9);
	}
}

//cup handler
module handler()
{
	difference()
	{
		translate([0,30,10]) rotate(a=[0,90,0])circle(8.5);
		translate([0,28,10]) rotate(a=[0,90,0])circle(8);
		translate([0,28.5,15.5]) rotate(a=[0,90,0])circle(4);
		translate([0,28.5,4.5]) rotate(a=[0,90,0])circle(4);

	}
}
module cup()
{
	union()
	{
	main();
	translate([0,-22.5,0]) handler();
	}
}
cup();
//=========================================//

//spoon
module half_spoon()
{
	difference()
	{
	translate([-30,0,10])sphere(10);
	translate([-30,0,20.5])sphere(20);
	}
	}
	scale([0.7,1.1]) half_spoon();
	rotate(a=[-4,0,0])translate([-22,2.8,0.55]) cube([2,spoon_handler_length,0.3]);

//=========================================//
//plate
difference()
{
	translate([30,0,0])cylinder(2,plate_bottom,plate_top);
	translate([30,0,0.8])cylinder(2,plate_bottom,plate_top);
}