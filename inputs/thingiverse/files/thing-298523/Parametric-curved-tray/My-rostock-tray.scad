//Height of the tray lip
tray_height = 25;
//The outside diameter of the circle this needs to fit.
outer_diameter = 435;
//The inside diameter of the circle this is supposed to fit.
inner_diameter = 310;
//How long should the outside edge of the tray slice be?
length_of_outside_edge = 225;

outer_circ = outer_diameter*3.14;
slice_percentage = (length_of_outside_edge/outer_circ);

slice_final_block_rotation = 360 - (90 + (360*slice_percentage));
slice_block_size = [outer_diameter*.6,outer_diameter*.6,tray_height*1.2];

translate([inner_diameter*-.4,inner_diameter*.4,0])
difference()
{	
	//Draw a donut of the apropriate dimensions
	linear_extrude(height = tray_height) 
		difference()
		{
			circle((outer_diameter/2),$fn=outer_diameter/2);
			circle((inner_diameter/2),$fn=outer_diameter/2);
		}
	
	//Subtract a group of blocks from it.
	translate([0,0,tray_height*-.2])// Drop the cut blocks slightly below Z=0
		union()
		{
			cube(slice_block_size);
			for(i=[45:45:slice_final_block_rotation])
			{
				rotate([0,0,i])cube(slice_block_size);
			}
			rotate([0,0,slice_final_block_rotation])cube(slice_block_size);
		}
}	
