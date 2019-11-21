/*
*Name: Fish scale impact vest
*Author: Andrew Ireland
*Date: 7-Mar-2013
*Description: Prints the parts of a fish scale impact vest in one moving piece.
			   The number of rows, columns and a few other details can be customised.
*/

// preview[view:south, tilt:side]
//Customisable parameters


//Columns to print
g_cols=3;//[1:20]

//Rows to print
g_rows=4;//[1:20]

//Number of faces
g_polygons=20;//[1:50]

//Print Mode - Collapses all scales for printing
g_print_mode=1;  //[0:Yes,1:No] 

//Resizes individual scales (1 = small, 10 = large)
g_scale=2;//[1:10]


//Ignore this variable
g_length=80;//[80:80]
//Ignore this variable
g_thickness=3;//[3:3]
//Ignore this variable
g_fishScale_overlap_x=15;//[15:15]
//Ignore this variable
g_fishScale_overlap_y=-16;//[-16:-16]
//Ignore this variable
g_fishScale_overlap_z=9.5;//[9.5:9.5]
//Ignore this variable
g_male_ball_radius=3.5;//[3.5:3.5]
//Ignore this variable
g_male_neck_width=2.5;//[2.5:2.5]
//Ignore this variable
g_female_track_height=4; //[4:4]
//Ignore this variable
g_female_gap_variance=0.5;//[0.5:0.5]


scale(g_scale * 1/10)
{
	if ( g_print_mode == 0 )
	{
		translate([(g_length*2+g_fishScale_overlap_x)*(g_cols-1)/2, 0,g_length]) rotate([-90,0,180]) fishScaleMultiple();
	} else {
		translate([-(g_length*2+g_fishScale_overlap_x)*(g_cols-1)/2, 0,0])	rotate([90,0,0]) fishScaleMultiple();
	}
}

//############################################################################################################
module fishScaleMultiple()
{

	for(row=[g_rows-1:0])
	{
	
		for(col=[g_cols-1:0])
		{
			if((row+1)%2==0)
			{
				if (col!=g_cols-1){
					translate([(g_length*2+g_fishScale_overlap_x*2)*col+g_length+g_fishScale_overlap_x, (g_length+g_fishScale_overlap_y)*row*g_print_mode, g_fishScale_overlap_z*row]) fishScaleComplete();
				}
			} else {
				translate([(g_length*2+g_fishScale_overlap_x*2)*col, (g_length+g_fishScale_overlap_y)*row*g_print_mode, g_fishScale_overlap_z*row]) fishScaleComplete();
			}

		}

	}	
}


//############################################################################################################
module fishScaleComplete()
{
	female_offset_y=g_fishScale_overlap_y+40;//14;
	female_offset_z=4.5;
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					fishScale7();
					translate([0,g_length-15,-g_male_ball_radius +  2.8 + g_fishScale_overlap_z*2 ]) rotate([0,90,0]) male();

					//Left
					translate([0.4*g_length+g_fishScale_overlap_x+1 ,g_length-(g_male_ball_radius+25),-g_male_ball_radius + 2.5 + g_fishScale_overlap_z]) rotate([0,90,0]) male();
					//Right
					translate([-0.4*g_length-g_fishScale_overlap_x-1 ,g_length-(g_male_ball_radius+25),-g_male_ball_radius + 2.5 + g_fishScale_overlap_z]) rotate([0,90,0]) male();
				} //union 1
		
				translate([0,0,-g_length*2]) cylinder(r=g_length*3, h=g_length*2);
				translate([0,g_length/2+g_fishScale_overlap_y-female_offset_y,g_male_ball_radius-female_offset_z]) rotate([180,0,90]) femaleCutAway();
			} //difference 1

			translate([0,g_length/2+g_fishScale_overlap_y-female_offset_y,g_male_ball_radius-female_offset_z]) rotate([180,0,90])  femaleMid();

			//Left
			translate([0.4*g_length+g_fishScale_overlap_x,g_length/2+g_fishScale_overlap_y-female_offset_y*.2,g_male_ball_radius-female_offset_z]) rotate([180,0,90]) femaleSide();

			//Right
			translate([-0.4*g_length-g_fishScale_overlap_x,g_length/2+g_fishScale_overlap_y-female_offset_y*.2,g_male_ball_radius-female_offset_z]) rotate([180,0,90]) femaleSide();
		}//union 2

		//Left difference
		translate([0.4*g_length+g_fishScale_overlap_x,g_length/2+g_fishScale_overlap_y-female_offset_y*.2,g_male_ball_radius-female_offset_z]) rotate([180,0,90]) femaleCutAwaySide();

		//Right difference
		translate([-0.4*g_length-g_fishScale_overlap_x,g_length/2+g_fishScale_overlap_y-female_offset_y*.2,g_male_ball_radius-female_offset_z]) rotate([180,0,90]) femaleCutAwaySide();

		//Make top edge flat for printing
		translate([15,g_length+14, 0]) rotate([90,0,0]) cube([g_length*3,g_length*3,30], center=true);

	}//difference 2
}


//############################################################################################################
module femaleSide()
{
	track_length=g_length*0.85;
	track_height=g_female_track_height;
	gap_variance=g_female_gap_variance;

	difference()
	{

		hull()
		{
			translate([track_length/2-g_male_ball_radius/2,0,0]) cylinder(r1=g_male_ball_radius+gap_variance*30, r2=g_male_ball_radius*.09, h=track_height*2, center=true, $fn=g_polygons);
			translate([-track_length/2+g_male_ball_radius/2,0,0]) cylinder(r1=g_male_ball_radius+gap_variance*30, r2=g_male_ball_radius*.09, h=track_height*2, center=true, $fn=g_polygons);
		}

		cube([track_length+20, g_male_neck_width*2+gap_variance*3,track_height+30], center=true);
		femaleCutAwaySide(track_height, gap_variance);
		translate([0,0,-track_height*2])	cube([g_length*3, g_length*3, track_height*3], center=true);
	}
}


module femaleCutAwaySide()
{
	track_length=g_length*0.87;
	track_height=g_female_track_height;
	gap_variance=g_female_gap_variance;

	rotate([0,90,0]) cylinder(r=g_male_ball_radius+gap_variance/2, h=track_length-g_male_ball_radius, center=true, $fn=g_polygons);
	translate([track_length/2-g_male_ball_radius/2,0,0]) sphere(r=g_male_ball_radius+gap_variance/2, h=g_length-g_male_ball_radius, center=true, $fn=g_polygons);
	translate([-track_length/2+g_male_ball_radius/2,0,0]) sphere(r=g_male_ball_radius+gap_variance/2, h=g_length-g_male_ball_radius, center=true, $fn=g_polygons);
}


//############################################################################################################
module femaleMid()
{
	track_length=2*g_length*0.85;
	track_height=g_female_track_height;
	gap_variance=g_female_gap_variance;

	difference()
	{
		hull()
		{
			translate([track_length/2-g_male_ball_radius/2,0,0]) cylinder(r1=g_male_ball_radius+gap_variance*30, r2=g_male_ball_radius*.09, h=track_height*2, center=true, $fn=g_polygons);
			translate([-track_length/2+g_male_ball_radius/2,0,0]) cylinder(r1=g_male_ball_radius+gap_variance*30, r2=g_male_ball_radius*.09, h=track_height*2, center=true, $fn=g_polygons);
		}

		cube([track_length+20, g_male_neck_width*2+gap_variance*3,track_height+30], center=true);
		femaleCutAway(track_height, gap_variance);
		translate([0,0,-track_height*2])	cube([g_length*3, g_length*3, track_height*3], center=true);
	}
}


module femaleCutAway()
{
	track_length=2*g_length*0.87;
	track_height=g_female_track_height;
	gap_variance=g_female_gap_variance;

	rotate([0,90,0]) cylinder(r=g_male_ball_radius+gap_variance/2, h=track_length-g_male_ball_radius, center=true, $fn=g_polygons);
	translate([track_length/2-g_male_ball_radius/2,0,0]) sphere(r=g_male_ball_radius+gap_variance/2, h=g_length-g_male_ball_radius, center=true, $fn=g_polygons);
	translate([-track_length/2+g_male_ball_radius/2,0,0]) sphere(r=g_male_ball_radius+gap_variance/2, h=g_length-g_male_ball_radius, center=true, $fn=g_polygons);
}

//############################################################################################################
module male()
{
	male_shaft_height=14.9;
	cube_width = male_shaft_height*2.8;
	ball_radius_spacer=0.1;

	difference()
	{
		translate([cube_width*.6,0,0]) rotate([45,90,0]) cube([g_male_neck_width,cube_width,cube_width], center=true);

	 	translate([-g_male_ball_radius-ball_radius_spacer,0,0]) rotate([0,90,0]) cube([g_male_neck_width*2,g_male_ball_radius*3,g_male_ball_radius], center=true);
	}

 	sphere(r=g_male_ball_radius-ball_radius_spacer, $fn=g_polygons, center=true, $fn=g_polygons);

}


//############################################################################################################
module fishScale7()
{
	offset = 5;
	tip_offset = g_fishScale_overlap_x-7;
	thickness_offset = 4;

	difference()
	{	
		hull()
		{
			translate([0,0,-thickness_offset*7.5]) sphere(r=thickness_offset*10, center=true, $fn=g_polygons);
			translate([15,g_length*.2, 0]) cylinder(r=g_length*.8,h=g_thickness, center=true, $fn=g_polygons);	
			translate([-15,g_length*.2, 0]) cylinder(r=g_length*.8,h=g_thickness, center=true, $fn=g_polygons);	
			translate([0,-g_length/2, 0]) cylinder(r=g_length/2,h=g_thickness, center=true, $fn=g_polygons);	
		} //hull
		translate([g_length+tip_offset, -g_length-offset, 0]) cylinder(r1=g_length, r2=g_length*0.8, h=g_thickness+thickness_offset, center=true, $fn=g_polygons);	
		translate([-g_length-tip_offset, -g_length-offset, 0]) cylinder(r1=g_length, r2=g_length*0.8, h=g_thickness+thickness_offset, center=true, $fn=g_polygons);	
	} //difference

}

//############################################################################################################

function s(i) = sin(i);
function c(i) = cos(i);