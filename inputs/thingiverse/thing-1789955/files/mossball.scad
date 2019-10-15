/* [Global] */

//Number of segments
$fn=32; //[16:8:128]

//Diameter of the cage
cage_d = 50; //[10:100]

//Thikness of the cage
cage_t = 0.5; //[0.5:0.1:3]

//Size of a footer
cage_footer = 2; //[1:10]

difference() 
{
	translate([0,0,1])
	sphere(d=cage_d);
	
	translate([0,0,-(cage_d+1)/2])
	cube(cage_d+1,center=true);

	sphere(d=cage_d-cage_t);

	for(i=[0 : 1 : 8])
	{
			for(j=[0 : 0.5 : 3])
			{
				rotate([0,j*2*15-90,15*i])
				cylinder(d=cage_d/8 - j, h=100, center=true);
			}
	}
	mirror([0,0,1])
	for(i=[0 : 1 : 8])
	{
			for(j=[0 : 0.5 : 3])
			{
				rotate([0,j*2*15-90,15*i])
				cylinder(d=cage_d/8 - j, h=100, center=true);
			}
	}

    translate([0,0,cage_d/8])
    for(i=[0 : 1 : 2])
	{
		rotate([0,i*30-30,-30])
		cube([100, cage_d/8, cage_d/5],center=true);
	}
	
}

difference()
{
    cylinder(d=cage_d+cage_footer, h=cage_d/16);
	cylinder(d=cage_d-cage_footer, h=cage_d/15);
}
