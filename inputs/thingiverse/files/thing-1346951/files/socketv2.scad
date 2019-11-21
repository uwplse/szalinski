// Customizable sockets v2 Improved
// http://www.thingiverse.com/thing:1240520
// Hacked up and improved by
// by infinigrove Squirrel Master 2016 (http://www.thingiverse.com/infinigrove)
//
//
// Remix of Parametric hex socket
// http://www.thingiverse.com/thing:91496
// Originally
// by Dale Price http://www.thingiverse.com/daprice
//

// diameter of hole across-flats
socket_size = 7;
// type of socket
socket_type = 6; // [6:hex-6, 4:square-8, 12:12 point]
// wall thickness of socket
socket_wall_thickness = 3; // [1:0.5:16]
// depth of socket
depth = 10; // [5:80]
// size of drive
drive_size = 6.35; // [6.35:1/4", 9.525:3/8", 12.7:1/2", 19.05:3/4", 25.4:1"]
// wall thickness of drive
drive_wall_thickness = 3; // [1:0.5:16]
// drive and socket size tolerance
tolerance = 0.2;
// socket detail
socket_detail = 100; // [30:180]

/* [Hidden] */

tolSize = socket_size + tolerance;
inscribedSize = tolSize/0.866025;
tolDrive = drive_size + tolerance;

socketRadius = (inscribedSize+socket_wall_thickness)/2;
driveRadius = ((tolDrive*1.5)+drive_wall_thickness)/2;

difference()
{
	union()
	{
		//socket portion
		translate([0,0,(depth+1)/2])
		cylinder(h = depth + 1, r = socketRadius, center = true, $fn = socket_detail);

		//drive portion
		translate([0,0,0-((tolDrive + 1) / 2)])
		cylinder(h = tolDrive + 1, r = driveRadius, center = true, $fn = socket_detail);
	}
	
	//socket hole
    if (socket_type == 12){
        //12 point socket
        translate([0,0,1]) linear_extrude(height = depth, center = false) circle(r = inscribedSize/2, $fn = 6);
        rotate([0,0,30])translate([0,0,1]) linear_extrude(height = depth, center = false) circle(r = inscribedSize/2, $fn = 6);
        
    } else {
        // 6 or 8 point
	translate([0,0,1])
	linear_extrude(height = depth, center = false)
	circle(r = inscribedSize/2, $fn = socket_type);
       // second part for 8 point
    if (socket_type == 4)rotate([0,0,45])translate([0,0,1])
	linear_extrude(height = depth, center = false)
	circle(r = inscribedSize/2, $fn = socket_type);
    }

	//drive hole
	translate([0,0,0-(tolDrive/2)-1])
	cube(size = tolDrive, center = true);
}