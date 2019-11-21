$fn                     = 90;
//thickness of the sheet metal:
metal_thickness         = 1.2;
//thickness of the clips:
slot_depth              = 1.2;
//length of the clips:
clip_length             = 20;
//width of the clips:
clip_width              = 14;

//offset from one side of the base plate:
side_offset             = 4;
//size of the base plate in x and y:
baseplate__width        = 35;
//height of the base plate:
baseplate_height        = 5;
//diameter of the round edges:
roundness               = 2;
//diameter of the screw holes:
mounting_hole_diameter  = 4;

//private:
baseplate_width         = baseplate__width - side_offset;


//the mounting plate:
rotate([90,0,0])
{
	difference()
	{
		minkowski()
		{
			cube([baseplate_width-roundness,baseplate_height,baseplate_width-roundness],center=true);
			rotate([0,90,90])
				cylinder( d=2, center=true );
		}
		screw_hole();
		translate([baseplate_width/2*0.6,0,baseplate_width/2*0.6])
			screw_hole();
		translate([-baseplate_width/2*0.6,0,-baseplate_width/2*0.6])
			screw_hole();
		translate([-baseplate_width/2*0.6,0,baseplate_width/2*0.6])
			screw_hole();
		translate([baseplate_width/2*0.6,0,-baseplate_width/2*0.6])
			screw_hole();
	}


	//the clips:
	translate([baseplate_width/2-metal_thickness/2,baseplate_height/2+clip_length/2,side_offset/2])
		clip();
	rotate([0,90,0])
		translate([baseplate_width/2-metal_thickness/2,baseplate_height/2+clip_length/2,-side_offset/2])
			clip();
}


module clip()
{
	cube([slot_depth,clip_length,clip_width],center=true);
}


module screw_hole()
{
	rotate([0,90,90])
		cylinder( d=mounting_hole_diameter, h=baseplate_height+1.1, center=true );
}