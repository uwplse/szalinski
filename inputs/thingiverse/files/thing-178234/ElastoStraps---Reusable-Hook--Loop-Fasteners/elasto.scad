//print 2 shells / 100% infill

/* [Strap Settings] */

//(in mm)
strap_length = 140; 

//(25mm 1st row, 15mm each extra)
width_in_rows = 1; 

//(hooks)
nib_rows = 4;  

//(in mm)
strap_thickness = 1.25; 

/* [Advanced] */

//(nibs every X position)
nib_spacing_multiplier = 1;

nib_angle = 55;
nib_top_length = 4;
nib_thickness = 1.5;
nib_width = 3.75;

//(based on strap thickness)
extra_nib_base_height = .6;

/* [Hidden] */
nib_spacing = 6.38;
length_per_quad = 5.0;
strap_width_per_row = 24.85;


for ( y = [1 : width_in_rows] )
{
	translate([0,(strap_width_per_row / 1.5) * (y - 1),0]) one_row();
}


module one_row()
{
	difference()
	{
		cube([strap_length,strap_width_per_row,strap_thickness]);
		cut_outs();
	}
	nibs();

}

module cut_outs()
{
	scale ([0.9,2.4,1])
	for ( x = [0 : (strap_length / length_per_quad) + 1 ])
	{
		translate([-10.5,0,0])
		rotate( -45, [0, 0, 1])
		for ( y = [0 : (strap_length / length_per_quad) + 1] )
		{
			 if (x - y > -4)
			 if (x - y < 2)	
			{
		    	translate([x * 5, y * 5, strap_thickness * -.1])
			 	cube([3.5,3.5,strap_thickness * 1.2]);}
				}
	}
}

module nibs()
{
	for ( x = [0 : nib_rows - 1])
	{
	translate ([1.3 + x * nib_spacing * nib_spacing_multiplier, 18.5 - (nib_width / 2),0]) nib();
	translate ([4.4 + x * nib_spacing * nib_spacing_multiplier, 9.5 - (nib_width / 2),0]) nib();
	}

}

module nib()
{

	translate ([0,nib_thickness / -1,strap_thickness]) rotate (0,[0,1,0]) cube([nib_thickness,nib_width,strap_thickness + extra_nib_base_height]);
	translate ([0,nib_thickness / -1,strap_thickness + (strap_thickness + extra_nib_base_height)]) rotate (nib_angle,[0,1,0]) cube([nib_thickness,nib_width,nib_top_length]);
}