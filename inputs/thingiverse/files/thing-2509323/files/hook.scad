metal_thickness         = 1.2; //thickness of the sheet metal
slot_depth              = 1.2;
clip_length             = 15;
clip_width              = 14;
mountingplate_width     = 25;
mountingplate_thickness = 3;
mountingplate_height    = 25;
hook_width              = 10;
hook_type               = "single"; //"single" = ohne hook, "double" = two hooks in a row
round_edge_radius       = 1;
$fn                     = 50;
hook_data               = [[0,0],[10,3],[9,17],[9,15],[8,5],[0,3]];
custom_support          = false; //true = print a custom support structure for the clip. false = print no support.



//the mounting plate:
linear_extrude( mountingplate_width )
	translate([-metal_thickness-mountingplate_thickness,0,0])
		polygon( points=[[0,0],[0,mountingplate_height],[mountingplate_thickness,mountingplate_height],[mountingplate_thickness,0]] );


//the clip for the slot:
translate([0,0,(mountingplate_width-clip_width)/2])
	linear_extrude( clip_width )
		polygon( points=[[0,0],[0,clip_length],[slot_depth,clip_length],[slot_depth,0],[metal_thickness-mountingplate_thickness,0],[metal_thickness-mountingplate_thickness,2],[0,2]] );


//support structure for the clip (because cura does not handle the clip at all, and slic3r does not handle it to my complete satisfaction):
if ( custom_support )
{
	for(x = [0.5 : 1.0 : clip_length])
		translate([0.5,x,(mountingplate_width-clip_width)/2-2.8])
			rotate([90,0,0])
				linear_extrude( 0.5 )
					square([1.6,(mountingplate_width-clip_width)/2], center=true);
	translate([-0.8,1,(mountingplate_width-clip_width)/2-2.8])
		rotate([90,0,90])
			linear_extrude( 0.5 )
				square([2.5,(mountingplate_width-clip_width)/2], center=true);
}


//the hook:
if ( hook_type == "single" )
{
	translate([-metal_thickness-mountingplate_thickness,mountingplate_height-round_edge_radius,mountingplate_width/2-hook_width/2])
	rotate([180,180,0])
	linear_extrude(hook_width)
		minkowski()
		{
			//polygon( points=[[0,0],[8,3],[8,17],[5,15],[5,7],[0,5]] );
			polygon( points=hook_data );
			circle( r=round_edge_radius );
		}
}
else if ( hook_type == "double" )
{
	translate([-metal_thickness-mountingplate_thickness,mountingplate_height-round_edge_radius,0])
	rotate([180,180,0])
	linear_extrude(hook_width)
		minkowski()
		{
			polygon( points=hook_data );
			circle( r=round_edge_radius );
		}
	translate([-metal_thickness-mountingplate_thickness,mountingplate_height-round_edge_radius,mountingplate_width-hook_width])
	rotate([180,180,0])
	linear_extrude(hook_width)
		minkowski()
		{
			polygon( points=hook_data );
			circle( r=round_edge_radius );
		}
}