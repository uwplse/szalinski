//Hex socket (customizable)

// diameter of hole across-flats
size = 7;
// size of drive
drive = 6.35; // [6.35:1/4", 9.525:3/8", 12.7:1/2", 19.05:3/4", 25.4:1"]
// depth of socket
depth = 10;
// drive and socket size tolerance
tolerance = 0.2;

tolSize = size + tolerance;
inscribedSize = tolSize/0.866025;
tolDrive = drive + tolerance;

socketRadius = (inscribedSize+3)/2;
driveRadius = ((tolDrive*1.5)+3)/2;

difference()
{
	union()
	{
		//socket portion
		translate([0,0,(depth+1)/2])
		cylinder(h = depth + 1, r = socketRadius, center = true, $fn = 30);

		//drive portion
		translate([0,0,0-((tolDrive + 1) / 2)])
		cylinder(h = tolDrive + 1, r = driveRadius, center = true, $fn = 30);
	}
	
	//socket hole
	translate([0,0,1])
	linear_extrude(height = depth, center = false)
	circle(r = inscribedSize/2, $fn = 6);

	//drive hole
	translate([0,0,0-(tolDrive/2)-1])
	cube(size = tolDrive, center = true);
}