// Customizable Picture Frame with Optional Stand
// Patrick Wiseman
// thingiverse.com/thing:60746
use <utils/build_plate.scad>;
// in mm (include size of any mat; 1in=25.4mm)
picture_width=125; // [100:250]
// in mm (include size of any mat)
picture_height=100; // [100:250]
// in mm
frame_width=15; // [15:50]
// in mm
frame_thickness=15; // [15:50]
// will be added to the bottom of the frame
stand="yes"; // [yes,no]
// degrees stand will tilt
stand_tilt=15; // [15,20,25,30,35,40,45]
// in mm (overhang to hold picture)
frame_lip=7; // [5:10]
// in mm (thickness of picture + mat, backing, etc.)
frame_depth=5; // [5:10]
build_plate(3,230,200); // Type A Machines Series 1 build plate
// The Frame
difference() {
	translate([-(picture_width/2+frame_width),-(picture_height/2+frame_width),0]) linear_extrude(height=frame_thickness)
	difference() {
		square([picture_width+2*frame_width,picture_height+2*frame_width]);
		translate ([frame_width+frame_lip,frame_width+frame_lip,0]) square([picture_width-2*frame_lip,picture_height-2*frame_lip]);
	}
	translate([-(picture_width/2),-(picture_height/2),frame_thickness-frame_depth])
	linear_extrude(height=frame_depth) square([picture_width,picture_height]);
}
// To put the stand on the short side, switch the values for picture_height and picture_width
// The Stand
h=(picture_height+2*frame_width)/2+frame_thickness;
if (stand=="yes") {
	translate([-picture_width/2,-(picture_height/2+frame_width/2+h*sin(stand_tilt)),0])
	rotate([0,270,0]) 
	linear_extrude(height=frame_width)
		polygon([[0,0],[0,h*cos(90-stand_tilt)],[h*cos(stand_tilt),h*sin(stand_tilt)]]);
	translate([picture_width/2+frame_width,-(picture_height/2+frame_width/2+h*sin(stand_tilt)),0])
	rotate([0,270,0]) 
	linear_extrude(height=frame_width)
		polygon([[0,0],[h*cos(stand_tilt),h*sin(stand_tilt)],[0,h*cos(90-stand_tilt)]]);
}
