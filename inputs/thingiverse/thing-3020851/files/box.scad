// options: assembled, unfolded, optimized, projection
mode = "unfolded"; 	// parts are layed flat
//mode = "assembled"; 	// box representation
//mode = "optimized"; 	// parts are layed flat and positioned to minimize waste material
//mode = "projection"; 	// projection of optimized mode, for exporting dxf

$fn = 40;

// thickness of the material
thickness = 4;

// outter dimensions of the box
width = 280;
length = 230;
height = 115;

// number of teeth along width
teethW = 9;
// number of teeth along length
teethL = 7;
// number of teeth along height
teethH = 5;

// add or remove slit for handling
slitPresent = true;
// slit rounding radius
slitR = 15;
// slit length
slitL = 100;
// handle thickness
slitThickness = 20;

// top corners chamfer radius, 0 to disable
chamferR = 8;

// positive value narrows the teeth, negative - widens them
tolerance = 0.3;

if(mode=="projection")
	projection()
	box();
else
	box();

module box()
{
	angle = mode=="assembled"?90:0;

	if(mode!="optimized" && mode!="projection")
	{
		bottom();
		right(angle);
		left(angle);
		rear(angle);
		front(angle);
	}
	else
	{
		translate([height, 0, 0])
		{
			bottom();
			right(angle);
			left(angle);
		}

		translate([width/2 + width + 1, -height/2 - 1, 0])
		rotate([0, 0, 180])
		translate([-width/2, -height/2 - length, 0])
		rear(angle);
		
		translate([0, -1, 0])
		front(angle);
	}
}

module bottom()
{
	wall(width, length, thickness, [teethW, teethL, teethW, teethL], [0, 0, 0, 0]);
}

module right(angle)
{
	translate([width, 0, 0])
	rotate([0, -1*angle, 0])
	difference()
	{
		wall(height, length, thickness, [teethH, teethL, teethH, 0], [0, 1, 0, 0], [0, 0, chamferR, chamferR]);
		if(slitPresent)
			hull()
			{
				for(i = [-1:2:1])
				translate([height - slitThickness - slitR, length/2 + slitL/2*i, -1])
				cylinder(r = slitR, h = thickness + 2);
			}
	}
}

module left(angle)
{
	rotate([0, angle, 0])
	translate([-height, 0, 0])
	difference()
	{
		wall(height, length, thickness, [teethH, 0, teethH, teethL], [0, 1, 0, 1], [chamferR, chamferR, 0, 0]);
		if(slitPresent)
			hull()
			{
				for(i = [-1:2:1])
				translate([slitThickness + slitR, length/2 + slitL/2*i, -1])
				cylinder(r = slitR, h = thickness + 2);
			}
	}
}

module front(angle)
{
	rotate([-1*angle, 0, 0])
	translate([0, -height, 0])
	wall(width, height, thickness, [0, teethH, teethW, teethH], [0, 1, 1, 1], [chamferR, 0, 0, chamferR]);
}

module rear(angle)
{
	translate([0, length, 0])
	rotate([angle, 0, 0])
	wall(width, height, thickness, [teethW, teethH, 0, teethH], [1, 1, 0, 1], [0, chamferR, chamferR, 0]);
}

// teethConf - 4 values showing number of teeth, 0 - teeth are not cut
// teethOddity - 4 values, 0 for even teeth, 1 - for odd
module wall(x, y, thickness, teethConf, teethOddity, chamferConfig)
{
	difference()
	{
		union()
		{
			difference()
			{
				cube([x, y, thickness]);

				if(chamferConfig[0] > 0)
					translate([-1, -1, -1])
					cube([chamferConfig[0]+1, chamferConfig[0]+1, thickness+2]);
				if(chamferConfig[1] > 0)
					translate([-1, y - chamferConfig[1] + 1, -1])
					cube([chamferConfig[1]+1, chamferConfig[1]+1, thickness+2]);
				if(chamferConfig[2] > 0)
					translate([x - chamferConfig[2] +1, y - chamferConfig[2] + 1, -1])
					cube([chamferConfig[2]+1, chamferConfig[2]+1, thickness+2]);
				if(chamferConfig[3] > 0)
					translate([x - chamferConfig[3] +1, -1, -1])
					cube([chamferConfig[3]+1, chamferConfig[3]+1, thickness+2]);
			}

			if(chamferConfig[0] > 0)
				translate([chamferConfig[0], chamferConfig[0], 0])
				cylinder(r = chamferConfig[0], h = thickness);
			if(chamferConfig[1] > 0)
				translate([chamferConfig[1], y - chamferConfig[1], 0])
				cylinder(r = chamferConfig[1], h = thickness);
			if(chamferConfig[2] > 0)
				translate([x - chamferConfig[2], y - chamferConfig[2], 0])
				cylinder(r = chamferConfig[2], h = thickness);
			if(chamferConfig[3] > 0)
				translate([x - chamferConfig[3], chamferConfig[3], 0])
				cylinder(r = chamferConfig[3], h = thickness);
		}

		if(teethConf[0] > 0)
			cutter(x, teethConf[0], thickness, teethOddity[0]==0);

		if(teethConf[1] > 0)
			translate([0, y, 0])
			rotate([0, 0, -90])
			cutter(y, teethConf[1], thickness, teethOddity[1]==0);

		if(teethConf[2] > 0)
			translate([x, y, 0])
			rotate([0, 0, -180])
			cutter(x, teethConf[2], thickness, teethOddity[2]==0);

		if(teethConf[3] > 0)
			translate([x, 0, 0])
			rotate([0, 0, -270])
			cutter(y, teethConf[3], thickness, teethOddity[3]==0);
	}
}

// tool for cutting teeth
module cutter(length, count, thickness, odd = true)
{
	for(i = [0:count-1])
	{
		if(odd && i%2 == 0)
			translate([i*length/count - tolerance, -1, -1])
			cube([length/count + tolerance*2, thickness+1, thickness+2]);
		if(!odd && i%2 != 0)
			translate([i*length/count - tolerance, -1, -1])
			cube([length/count + tolerance*2, thickness+1, thickness+2]);
	}
}

