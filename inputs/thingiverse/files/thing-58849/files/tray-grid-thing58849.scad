// overall height
height=25; // [1:200]

// inside width of each tray
width=40; // [1:200]
// inside depth of each tray
depth=30; // [1:200]

// wall thickness
wall=1.5; // [0:100]

// corner radius. capped to min(x,y) * min(width,height) / 2
radius=10; // [0:1000]

// number of trays in x direction
x=3; // [1:20]
// number of trays in y direction
y=4; // [1:20]

// resolution of curves
$fn=200;

// nothing below this line needs to be changed.
total_width = x*width + (x+1)*wall;
total_depth = y*depth + (y+1)*wall;

cr = min(radius, min(x*width, y*depth) / 2);

echo ("Total width of object:", total_width);
echo ("Total depth of object:", total_depth);

// 2d footprint with rounded corners
module rounded_corners() {
	translate([wall+cr, wall])
		square([total_width-2*wall-2*cr, total_depth-2*wall]);
	translate([wall, wall+cr])
		square([total_width-2*wall, total_depth-2*wall-2*cr]);
	for(xx = [wall+cr, total_width-wall-cr],
			yy = [wall+cr, total_depth-wall-cr])
		translate([xx, yy])
			circle(r=cr);
}

difference() {
	// footprint with rounded corners
	intersection() {
		cube([total_width, total_depth, height]);
		translate([0,0,-1]) linear_extrude(height=height+2)
			rounded_corners();
	}
	// subtract inside pockets
	for(xx = [0 : x-1], yy = [0 : y-1]) {
		translate([xx*width + (xx+1)*wall, yy*depth + (yy+1)*wall, wall])
			cube([width, depth, height]);
	}
}
// add outer wall with rounded corners
linear_extrude(height=height) difference() {
	offset(wall)
		rounded_corners();
	rounded_corners();
}