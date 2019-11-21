//Height
h=90; //[10:250]

//Knife compartments?
knife=1; //[yes=1, no=0]

//Number of small (10x10mm) compartments
small=6; //[0:28]

//Number of big (20x20mm) compartments
big=3; //[0:11]


/* [Hidden] */
//Thilness of the box. Do not modifie this now, may be use in future release.
e=28.5; //[26.5]


rotate([90,0,0])union()
{
	difference()
	{
		union()
		{
			translate([0,0,e])cube([170,3,24]);
			cube([170,h+3,e]);
		}
		translate([170/2,-0.1,288.72])rotate([-90,0,0])cylinder(r=245,h=3.2,$fs=0.1,$fa=1);
		translate([10,-0.1,43.5])rotate([-90,0,0])cylinder(r=3,h=3.2);
		translate([160,-0.1,43.5])rotate([-90,0,0])cylinder(r=3,h=3.2);
		translate([10,15,e-9])cylinder(r=11/2, h=10.1);
		translate([10,15,e-7])cylinder(r=11/2, h=7.1);
		translate([160,15,e-7])cylinder(r=11/2, h=7.1);
		if(knife)
		{
			translate([3,-0.2,11.25])cube([30,h+0.1,3]);
		}
	

		if(small!=0)for (i = [0:small/2-1])
		{
			translate([3+knife*31.5+i*11.5, -0.2,3])cube([10,h+0.1,10]);
			translate([3+knife*31.5+i*11.5, -0.2,14.5])cube([10,h+0.1,10]);
		}

		if(big!=0)for(i=[small/2:small/2+big-1])
		{
			translate([3+knife*31.5+(small/2)*11.5+(i-small/2)*23, -0.2,3])cube([21.5,h+0.1,21.5]);
		}
	
		translate([3+knife*31.5+(small/2)*11.5+(small/2+big-small/2)*23, -0.1,3])cube([168-(3+knife*31.5+(small/2)*11.5+(small/2+big-small/2)*23)-2,h+0.1,21.5]);
	}
	translate([0,h+3-20,e])cube([20,20,4]);
	translate([170-20,h+3-20,e])cube([20,20,4]);
}

