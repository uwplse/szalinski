//	Ray Design 
// Q Tip Cloud - Version 0.9
//	http://www.thingiverse.com/thing:937454

//CUSTOMIZER VARIABLES

//CONSTANTS

//Make a lid for the box
with_cover = 1; //[1:Yes, 0:No]

//This should be standard (mm)
qtip_length = 80; 

//(mm)
total_height = 65;//[30:100]

//Thickness of the floor (mm)
floor_height = 1.5;//[0.1:0.01:5]

//(mm)
wall_thickness = 1;//[0.1:0.01:5]

//Size multiplier for length and width. Height stays the same
xy_size_factor = 0.75;//[0.1:0.05:3.0]

//height of the part that is shared by the lid and the base(mm)
cover_lip_height = 6;//[1:0.5:30]

//Buffer between base and lid
cover_fit_buffer = 0.3;//[0.1:0.01:3]

$fn = 1*200;
cover_lip_thickness = wall_thickness; //Can be 0
cover_height = qtip_length - total_height + floor_height;


//Cloud Design
cylinders = 
[//R , X , Y , 
	20, 50, 0 ,
	25, 35, 30,
	28, 0 , 40,
	18,-32, 26,
	24,-50,  4];

cube = 
[//X,Y,move_x,move_y
	100,40,-50,-20
];

//RENDERS
QTipsCloud();

//MODULES
module QTipsCloud()
{
	translate([0,with_cover*(xy_size_factor * cube[1]/2 + 2),0])		
	difference() {
		cloud(0,total_height);
		translate([0,0,floor_height])
			cloud(-wall_thickness,total_height);
	}

	if (with_cover)
	{
		translate([0,-xy_size_factor * cube[1]/2 - 5,0])		
		rotate([0,0,180])
		mirror([1,0,0])
		difference()
		{
				cloud(
					wall_thickness + cover_fit_buffer,
					cover_height + cover_lip_height
				);
				translate([0,0,cover_height])
					cloud(0,cover_height+cover_lip_height);

				translate([0,0,floor_height])
					cloud(
						-cover_lip_thickness,
						cover_height+cover_lip_height);
		}
	}
}

module cloud(delta, height)
{
    union() 
    {

		for (i=[0:(len(cylinders)/3-1)])
		{
			translate([cylinders[3*i+1]*xy_size_factor,cylinders[3*i+2]*xy_size_factor,0])
				cylinder(r=xy_size_factor*cylinders[3*i]+delta, h = height);
		}

		translate([cube[2]*xy_size_factor,cube[3]*xy_size_factor-delta,0])
			cube([cube[0]*xy_size_factor,cube[1]*xy_size_factor,height]);
	}
}
