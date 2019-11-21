// ****************************************************
//	Handle for 1/4 bits
// Print at .2 layer height, 25% infill, 2 extra shells
//
// Created by Joe Cabana 11/18/2012
// ****************************************************

MagDia = 8.4;  // Magnet hole diameter

BitDia = 7.6;  // Driver bit hole diameter
BitDth = 12;  // Depth of bit hole

HandDia = 23;  // Handle diameter
HandLen = 80;  // Handle length

VertDia = 14;  // Diameter of vertical grip slots
VertOff = 4.7;  // Offset of vertical slots from outer edge

GripDia = 6; // Diameter of grip depression
GripDth = 2.5; // Depth of finger grip
GripRatioTop = 4; // Height/width ratio of grip oval
GripRatioBot = 1.5; // Height/width ratio of grip oval
GripOff = 6;  // Offset from bottom of grip;

difference()
{
	// Handle
	cylinder(HandLen,HandDia/2,HandDia/2,$fn=6);

	// Round off top
	translate([0,0,HandLen-HandDia+6])
		difference()
		{
			sphere(HandDia, $fn=36);
			sphere(HandDia-6, $fn=36);
			translate([0,0,-HandDia])
				cube([HandDia*2,HandDia*2,HandDia*2],true);
		}


	// Round corners
	translate([0,0,-1])
		difference()
		{
			cylinder(HandLen+2,HandDia,HandDia,$fn=72);
			cylinder(HandLen+2,HandDia/2-.5,HandDia/2-.5,$fn=36);
		}

	// Vertical grips
	for(x = [30 : 60 : 330])
		rotate([0,0,x])
			translate([HandDia/2+VertOff,0,-1])
				cylinder(HandLen+2,VertDia/2,VertDia/2,$fn=36);

	// Rounded finger grip top
	translate([0,0,GripDia+GripOff])
		difference()
		{
			rotate_extrude(convexity=10,$fn=36)
				translate([HandDia/2+GripDia-GripDth, 0, 0])
					scale([1,GripRatioTop,1])
						circle(GripDia);
			translate([0,0,-(GripDia*GripRatioTop+.01)])
				cylinder(GripDia*GripRatioTop,HandDia,HandDia);
		}


	// Rounded finger grip bottom
	translate([0,0,GripDia+GripOff])
		difference()
		{
			rotate_extrude(convexity=10,$fn=36)
				translate([HandDia/2+GripDia-GripDth, 0, 0])
					scale([1,GripRatioBot,1])
						circle(GripDia);
			cylinder(GripDia*GripRatioBot,HandDia,HandDia);
		}

	// Hole for driver bit
	translate([0,0,-1])
		cylinder(BitDth+1,BitDia/2,BitDia/2,$fn=6);

	// Hole for magnet
	translate([0,0,BitDth-.1])
		cylinder(HandLen,MagDia/2,MagDia/2,$fn=36);
}
