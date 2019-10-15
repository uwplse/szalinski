o_s=32;
i_s=20;

outer_cube();
inner_cube();

module inner_cube()
{
	cube([i_s, i_s, i_s], center=true);
}
	
module outer_cube()
{
	difference()
	{
		cube([o_s, o_s, o_s], center=true);
		union()
		{
			discs();
			holes();
		}
	}
}

module discs()
{
	rad=(o_s+(i_s/5))/2;
	ht=(o_s-i_s)/2/2;
	sh=(i_s/2)+ht/2;

	translate([0,0,sh])
	cylinder(r=rad, h=ht, center=true);
	translate([0,0,-sh])
	cylinder(r=rad, h=ht, center=true);

	translate([0,sh,0])
	rotate([90,0,0])
 	cylinder(r=rad, h=ht, center=true);
	translate([0,-sh,0])
	rotate([90,0,0])
	cylinder(r=rad, h=ht, center=true);

	translate([sh,0,0])
	rotate([0,90,0])
 	cylinder(r=rad, h=ht, center=true);
	translate([-sh,0,0])
	rotate([0,90,0])
	cylinder(r=rad, h=ht, center=true);
}

module holes()
{
	rad=(o_s-(i_s*5/6))/2;
//	rad=(i_s*1.45/2);

	cylinder(r=rad, h=o_s, center=true);
	rotate([90,0,0])
	cylinder(r=rad, h=o_s, center=true);
	rotate([0,90,0])
	cylinder(r=rad, h=o_s, center=true);
}

