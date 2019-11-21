// Set your fan angle as desired
fan_angle = 45; // [0:90]

fan_clip();

translate([0,40,0])
mirror([1,0,0])
fan_clip();

module fan_clip()
{
	rotate([0,0,-fan_angle])
	difference()
	{
		union()
		{
			translate([-4,8.5,0])
			cube([8,8,4]);

			translate([-4,11.5,0])
			cube([8,5,12]);
		}

		translate([0,20,8])
		rotate([90,0,0])
		cylinder(r=3.5/2, h=15);
	}

	difference(){
		translate([0,-4.3,0])
		cylinder(r=14, h=4);

		translate([0,-4.3,-1])
		cylinder(r=10.9, h=6);

		translate([-7,-20,-1])
		cube([14,10,6]);
	}
}