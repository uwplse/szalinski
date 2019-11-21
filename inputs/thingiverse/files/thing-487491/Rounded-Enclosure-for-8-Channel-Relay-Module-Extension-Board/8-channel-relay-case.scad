//include <C__fakepath_roundedrect.scad>

/*
 * "8 channel relay case.scad"
 * 
 * Written by mattdurr @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 *
 */


// because this case has rounded corners it has a different internal width and length to the object in it.
// but all we care about is the object in it, the rest is automatic

//all dimentions in mm

/* [Case] */

//Width of the object in the box
object_Width_text_box = 72.5;
//Length of the object in the box
object_Length_text_box = 91;
//Height of the object in the box, the box will match this
object_Height_text_box = 22.5;
//Depth of the floor layer
floor_Depth_text_box = 1.5;
//Width of the boxes shell
shell_Width_text_box = 2;
//The radius of the boxes corners
corner_Radius_text_box = 5;

//Ridge depth down the side of the case
ridge_Height_text_box = 0.5;
//Ridge depth into the shell
ridge_Depth_text_box = 1;

//Length of the screw terminal window
screw_Terminal_Window_Length_text_box = 66;
//Width of the screw terminal window
screw_Terminal_Window_Height_text_box = 9;
//Screw terminal window offset from bottom case wall
screw_Terminal_Window_Wall_Offset_text_box = 5;
//Screw terminal window offset from floor
screw_Terminal_Window_Floor_Offset_text_box = 10;


// I added an IO window for my board because I soldered a female header under the male IO
//Height of the IO window
io_Window_Height_text_box = 4;
//Width of the IO window
io_Window_Width_text_box = 28;
//Floor Offset of the IO window
io_Window_Offset_From_Floor_text_box = 3;

/* [Hidden] */

caseWidth = object_Width_text_box + (2 * shell_Width_text_box);
caseLength = object_Length_text_box + (2 * shell_Width_text_box);
caseHeight = object_Height_text_box + floor_Depth_text_box;


//visualize the object
//color("red") translate([0,0,(object_Height_text_box/2)+floor_Depth_text_box]) cube(size = [object_Width_text_box, object_Length_text_box, object_Height_text_box], center = true);

/* THE FOLLOWING SECTION WAS TAKEN FROM http://www.thingiverse.com/thing:9347 */
/* I AM EMBEDDING THIS HERE SO THAT I CAN USE THE CUSTOMIZER ON THINGIVERSE */

// You could simply do it this way if you have the boxes.scad
// file in your library
//use <boxes.scad>
//roundedBox([20, 30, 40], 5, true); 

// Or, you could do it this way if you want to roll your own
//roundedRect([20, 30, 40], 5, $fn=12);

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}

/* END OF BORROWED SECTION */

difference()
{
  //outer shell
  roundedRect([caseWidth, caseLength, caseHeight], corner_Radius_text_box, true);
  
  //inner volume
  translate([0,0,floor_Depth_text_box]) roundedRect([object_Width_text_box, object_Length_text_box, object_Height_text_box], corner_Radius_text_box, true);
  
  //ridge
  translate([0,0,caseHeight-ridge_Height_text_box]) roundedRect([caseWidth-(2*ridge_Depth_text_box), caseLength-(2*ridge_Depth_text_box), ridge_Height_text_box], corner_Radius_text_box, true);
  
  //ac connectors
  translate([0, ((object_Length_text_box/2)-(screw_Terminal_Window_Length_text_box/2))-screw_Terminal_Window_Wall_Offset_text_box, screw_Terminal_Window_Floor_Offset_text_box + floor_Depth_text_box]) cube(size = [caseWidth+(2*corner_Radius_text_box), screw_Terminal_Window_Length_text_box, screw_Terminal_Window_Height_text_box], center = true);
  
  //io connectors
  translate([0, -(object_Length_text_box/2)-(corner_Radius_text_box/2)-(shell_Width_text_box/2), io_Window_Offset_From_Floor_text_box+floor_Depth_text_box]) cube(size = [io_Window_Width_text_box, shell_Width_text_box, io_Window_Height_text_box], center = true);

}