include <MCAD/nuts_and_bolts.scad>
include <utils/build_plate.scad>

/* [Main] */

//dimentions of the board
board_x = 77;
//dimentions of the board
board_y = 53;
//dimentions of the board
board_z = 12;

//overall thickness of frame walls
frame_thickness = 2;
//overall height of frame walls
frame_height = 10;
//dimentions of the lip to hold board
frame_lip = 1;

/* [Board Mounts] */

//size of screws to mount the board
board_screw_size = 3;

//distance between center of screw holes
board_screw_dist_x = 70;
//distance between center of screw holes
board_screw_dist_y = 45;


/* [Frame Mounts] */
//size of screws to mount the frame
frame_screw_size = 3;

//distance between frame mount screw holes
frame_screw_dist_x = 50;


/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */


// preview[view:south east, tilt:top]

//size of the mounts for the board
board_screw_mount_size = board_screw_size + frame_thickness;

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module expansionBoardMount()
{
	screwRadius = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[board_screw_size]/2+0.0001;
	height = frame_height-frame_lip;

	difference()
	{
		union()
		{
			translate([0,0,height/2])
				cylinder(r=board_screw_mount_size, h = height ,center=true, $fn=10);
		}
		union()
		{
			translate([0,0,height/2])
				cylinder(r=screwRadius, h=2*height,center=true, $fn=10);
		}
	}
}

module expansionBoardFrameMount()
{
	screwRadius = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[frame_screw_size]/2+0.0001;
	capRadius = METRIC_NUT_AC_WIDTHS[frame_screw_size]/2++0.0001; 

	height = frame_thickness;
	mount_x = 2*capRadius + frame_thickness;
	mount_y = 2*capRadius + frame_thickness;

	difference()
	{
		union()
		{
			translate([0,mount_y/2,height/2])
				cube([mount_x,mount_y,height],center=true);

			hull()
			{
				translate([(mount_x-frame_thickness)/2,mount_y-frame_thickness/2,height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
				translate([(mount_x-frame_thickness)/2,-frame_thickness/2,frame_height - height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
				translate([(mount_x-frame_thickness)/2,-frame_thickness/2,height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
			}

			hull()
			{
				translate([-(mount_x-frame_thickness)/2,mount_y-frame_thickness/2,height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
				translate([-(mount_x-frame_thickness)/2,-frame_thickness/2,frame_height - height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
				translate([-(mount_x-frame_thickness)/2,-frame_thickness/2,height/2])
					cube([frame_thickness,frame_thickness,frame_thickness],center=true);
			}

		}
		union()
		{
			translate([0,mount_y/2,height/2])
				cylinder(r=screwRadius, h=2*height,center=true, $fn=10);
//
//			translate([0,capRadius,(height/2) + frame_thickness])
//				cube([2*capRadius,4*capRadius,height],center=true);
//
//			#translate([0,mount_y/2,frame_thickness + height/2])
//				rotate([45,0,0])
//					cube([mount_x+1,mount_y,height], center=true);
		}
	}
}

module expansionBoardFrame()
{
	frame_x = board_x + 2*frame_thickness;
	frame_y = board_y + 2*frame_thickness;
	frame_z = frame_height;

	hole_x = board_x - (2*frame_lip);
	hole_y = board_y - (2*frame_lip);
	hole_z = 2.5 * frame_z;

	difference()
	{
		union()
		{
			translate([0,0,frame_z/2])
				cube([frame_x,frame_y,frame_z], center=true);
		}
		union()
		{
			//main hole in the frame
			translate([0,0,0])
				cube([hole_x,hole_y,hole_z], center=true);

			//hole to make the lip in the frame
			translate([0,0,(board_z/2) + frame_height - (frame_thickness - frame_lip)])
				cube([board_x,board_y,board_z], center=true);
		}
	}
}


module expansionBoardMounts()
{
	difference()
	{
		union()
		{
			translate([board_screw_dist_x/2,board_screw_dist_y/2,0])
				expansionBoardMount();
			translate([board_screw_dist_x/2,-board_screw_dist_y/2,0])
				expansionBoardMount();
			translate([-board_screw_dist_x/2,board_screw_dist_y/2,0])
				expansionBoardMount();
			translate([-board_screw_dist_x/2,-board_screw_dist_y/2,0])
				expansionBoardMount();
		}
		union()
		{
		}
	}
}



module expansionBoardFrameMounts()
{
	frame_screw_dist_y =  board_y + 2*frame_thickness;

	difference()
	{
		union()
		{
			translate([frame_screw_dist_x/2,frame_screw_dist_y/2,0])
				expansionBoardFrameMount();
			translate([frame_screw_dist_x/2,-frame_screw_dist_y/2,0])
				rotate([0,0,180])
					expansionBoardFrameMount();
			translate([-frame_screw_dist_x/2,frame_screw_dist_y/2,0])
				expansionBoardFrameMount();
			translate([-frame_screw_dist_x/2,-frame_screw_dist_y/2,0])
				rotate([0,0,180])
					expansionBoardFrameMount();
		}
		union()
		{
		}
	}
}

module expansionBoard()
{
	difference()
	{
		union()
		{
			expansionBoardFrame();
			expansionBoardMounts();
			expansionBoardFrameMounts();
		}
		union()
		{
		}
	}
}


expansionBoard();
