// Parametric spool holder for MBI R2 by Woale

// preview[view:north west, tilt:top diagonal]

// Unit
unit = 1; // [1:mm,25.4:inch]

// How long should the spool holder be (between ribbons) ?
spool_width = 130;

// What's the size of the spool hole ?
spool_hole_diameter = 30;

//variables
spl_l=spool_width*unit;
spl_d=spool_hole_diameter*unit;

//fix
$fn=48*2;
spl_r=spl_d/2*1;
plt_w=spl_d*1.5*1;

//plate holder
module plt_hld()
{
	//box1
	cube([31,5,spl_d]);
	//box2
	translate([28-9,0,0]) cube([6,16,spl_d]);
	//box3
	translate([28-9,11,0]) cube([plt_w,5,spl_d]);
}

//spool extensions
module spl_ext()
{
	translate([28-9+(plt_w/2)-(spl_r/5),16+5,spl_r]) rotate([270,0,0]) cylinder(5,spl_r,spl_r);
	translate([28-9+(plt_w/2)-(spl_r/5),16+5+spl_l+10,spl_r]) rotate([270,0,0]) cylinder(5,spl_r,spl_r);
}

//spool holder
module spl_hld()
{
	union()
	{
		difference()
		{
			union()
			{
				translate([28-9+(plt_w/2),11,spl_r]) rotate([270,0,0]) cylinder(spl_l+15+10,spl_r,spl_r);
				spl_ext();
			}
			translate([28-9+(plt_w/2),0,0]) cube([spl_d,spl_l+16+25,spl_d]);
		}
	translate([28-9+(plt_w/2),11,spl_r]) rotate([270,0,0]) scale([.5,1,1]) cylinder(spl_l+15+10,spl_r,spl_r);
	}
}

//level
translate([0,0,-spl_r/10]) intersection()
{
	union()
	{
		spl_hld();
		plt_hld();
	}
	translate([0,0,spl_r/10]) cube([28-9+plt_w,spl_l+16+20,spl_d-(spl_r/10*2)]);
}

