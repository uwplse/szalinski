// Parametric filament spool by Woale

// preview[view:south, tilt:top diagonal]

// Unit
unit = 1; // [1:mm,25.4:inch]

// What's the inner spool width ? Recommended >10mm.
spool_width = 20;

// How much should the spool walls outer diameter be ? Recommended 70<150mm.
spool_walls_diameter = 100;

// How much should the spool walls width be ? Recommended >3mm.
spool_walls_width = 3;

// How much should the spool hole inner diameter be ? Recommended >25mm.
spool_hole_diameter = 30;

// What filament should the spool hold ?
filament_diameter = 2; // [2:1.75mm,3.3:3mm]

//variables
spl_l=spool_width*unit;
spl_w_d=spool_walls_diameter*unit;
spl_w_w=spool_walls_width*unit;
spl_h_d=spool_hole_diameter*unit;

//fix
$fn=48*2;
spl_w_r=spl_w_d/2*1;
spl_h_r=spl_h_d/2*1;
fil_r=filament_diameter/2*1;
//spl_pl=3*1;

translate([-spl_w_d/2-3,0,0]) difference()
{
	union()
	{
		cylinder(spl_w_w,spl_w_r,spl_w_r);
		cylinder(spl_w_w+spl_l,spl_h_r+5,spl_h_r+5);
	}
	
	translate([0,0,-1]) cylinder(spl_l+2,spl_h_r,spl_h_r);
	translate([0,0,spl_w_w]) cylinder(spl_w_w+spl_l+2,spl_h_r+3.1,spl_h_r+3.1);
	translate([0,0,spl_w_w+fil_r]) rotate(90,[1,0,0]) cylinder(spl_h_d+11,fil_r,fil_r,true);
	translate([0,0,spl_w_w+spl_l-fil_r]) rotate(90,[0,1,0]) cylinder(spl_h_d+11,fil_r,fil_r,true);
	difference()
	{
		difference()
		{
			translate([0,0,-1]) cylinder(spl_w_w+2,spl_w_r-spl_w_w*2,spl_w_r-spl_w_w*2);
			for(i=[0:6])
			{
				rotate(i*360/7,[0,0,1]) translate([0,-spl_w_w,-1]) cube([spl_w_r,spl_w_w*2,spl_w_w+2]);
			}
		}
		translate([0,0,-2]) cylinder(spl_w_w+4,spl_h_r+spl_w_w*2+5,spl_h_r+spl_w_w*2+5);	
	}
}

translate([spl_w_d/2+3,0,0]) difference()
{
	union()
	{
		cylinder(spl_w_w,spl_w_r,spl_w_r);
		cylinder(spl_w_w+spl_l,spl_h_r+3,spl_h_r+3);
	}
	
	translate([0,0,-1]) cylinder(spl_l+2,spl_h_r,spl_h_r);
	translate([0,0,spl_w_w]) cylinder(spl_w_w+spl_l+2,spl_h_r+1,spl_h_r+1);
	difference()
	{
		difference()
		{
			translate([0,0,-1]) cylinder(spl_w_w+2,spl_w_r-spl_w_w*2,spl_w_r-spl_w_w*2);
			for(i=[0:6])
			{
				rotate(i*360/7,[0,0,1]) translate([0,-spl_w_w,-1]) cube([spl_w_r,spl_w_w*2,spl_w_w+2]);
			}
		}
		translate([0,0,-2]) cylinder(spl_w_w+4,spl_h_r+spl_w_w*2+5,spl_h_r+spl_w_w*2+5);	
	}
}