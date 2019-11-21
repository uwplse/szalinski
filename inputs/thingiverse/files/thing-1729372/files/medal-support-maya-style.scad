$fa=0.5;
$fs=0.4;

/* [Global] */

// Medal diameter (mm) as slicer shows (printed diameter may be slightly different than model diameter)
medal_diameter=106.6;
// Medal edge thickness (mm)
medal_edge=5;
// Support base height (mm)
suport_base=4;
//Support base edge incline (mm)
suport_wall=2;

/* [Hidden] */
medal_radius=medal_diameter*0.5;

module model_medal(medal_r,medal_e)
{
	cylinder(r=medal_r,h=medal_e);
}

module support_figure(medal_r,medal_e)
{
	translate([0,-medal_e*0.5,0]) hull()
	{
		translate([-medal_r*0.15*0.5,-medal_e*0.5,0]) cube([medal_r*0.15,medal_e,0.05]);
		translate([-medal_r*0.1*0.5,-medal_e*0.7*0.5,medal_r*0.15-0.05]) cube([medal_r*0.1,medal_e*0.7,0.05]);
	}
	translate([0,medal_e*0.5,0]) hull()
	{
		translate([-medal_r*0.15*0.5,-medal_e*0.5,0]) cube([medal_r*0.15,medal_e,0.05]);
		translate([-medal_r*0.1*0.5,-medal_e*0.7*0.5,medal_r*0.15-0.05]) cube([medal_r*0.1,medal_e*0.7,0.05]);
	}
}

module medal_support_base(medal_r,medal_e,base,wall)
{
	adh_r=min(5,medal_e);
	translate([-medal_r*0.75,-medal_e*1.5,0]) cube([medal_r*1.5,medal_e*3,base*0.25]);
	translate([-medal_r*0.75+wall*0.25,-medal_e*1.5+wall*0.25,base*0.25]) cube([medal_r*1.5-wall*0.5,medal_e*3-wall*0.5,base*0.25]);
	translate([-medal_r*0.75+wall*0.5,-medal_e*1.5+wall*0.5,base*0.5]) cube([medal_r*1.5-wall,medal_e*3-wall,base*0.25]);
	translate([-medal_r*0.75+wall*0.75,-medal_e*1.5+wall*0.75,base*0.75]) cube([medal_r*1.5-wall*1.5,medal_e*3-wall*1.5,base*0.25]);
	// ladders
	hull()
	{
		translate([-medal_r*0.75-wall,-medal_e*0.5,0]) cube([medal_r*1.5+wall*2,medal_e,0.05]);
		translate([-medal_r*0.75+wall*0.65,-medal_e*0.5,base-0.05]) cube([medal_r*1.5-wall*1.3,medal_e,0.05]);
	}
	translate([0,-medal_e*0.5,0]) hull()
	{
		translate([-medal_r*0.75-wall-0.2,0,0]) cube([medal_r*1.5+wall*2+0.4,medal_e*0.125,0.05]);
		translate([-medal_r*0.75+wall*0.65-0.2,0,base-0.05]) cube([medal_r*1.5-wall*1.3+0.4,medal_e*0.125,0.05]);
	}
	translate([0,medal_e*(0.50-0.125)]) hull()
	{
		translate([-medal_r*0.75-wall-0.4,0,0]) cube([medal_r*1.5+wall*2+0.8,medal_e*0.125,0.05]);
		translate([-medal_r*0.75+wall*0.65-0.4,0,base-0.05]) cube([medal_r*1.5-wall*1.3+0.8,medal_e*0.125,0.05]);
	}
	// improve corners adhesion against bending
	translate([-medal_r*0.75,-medal_e*1.5,0]) cylinder(r=adh_r,h=0.4);
	translate([medal_r*0.75,-medal_e*1.5,0]) cylinder(r=adh_r,h=0.4);
	translate([-medal_r*0.75,medal_e*1.5,0]) cylinder(r=adh_r,h=0.4);
	translate([medal_r*0.75,medal_e*1.5,0]) cylinder(r=adh_r,h=0.4);
}

module medal_support()
{
	medal_support_base(medal_radius,medal_edge,suport_base,suport_wall);
	translate([-medal_radius*0.53,0,suport_base]) support_figure(medal_radius,medal_edge);
	translate([medal_radius*0.53,0,suport_base]) support_figure(medal_radius,medal_edge);
}

color([0.7,0,0]) difference()
{
	medal_support();
	translate([0,-medal_edge*0.5,medal_radius+suport_base-1.05]) rotate([-90,0,0]) model_medal(medal_radius,medal_edge);
}

//translate([0,-medal_edge*0.5,medal_radius+suport_base-1]) rotate([-90,0,0]) color([1,1,0]) model_medal(medal_radius,medal_edge);

