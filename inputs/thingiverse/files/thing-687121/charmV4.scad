//Created by Kimberly A Schumann
//Remixed from Customizable dice with custom engraved images, created by: Ari M Diacou
//http://www.thingiverse.com/thing:131071
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

/*To get this to work offline, any image must be converted to a .dat file using the tool at http://customizer.makerbot.com/image_surface. That will output an array of values from 0-1 corresponding to the greyscale values 0-255 of the image. Inverting the colors of the image will ensure that the recessed image gets subracted from other objects properly. Copy the arry to a text file. IMPORTANT: be sure that your file is actually a dat file and not e.g. foo.dat.txt. Some operating systems (like Windows 7 by default) hide the actual extension. Once the dat files are in the same directory as the .scad file, and are named properly the surface() function should work.

The way I prepared my image files was to:
	1	Import the image into gimp.
	2	Crop the image as tightly as possible
	3	Right click on the image: Image>Scale Image
	4	With the aspect ratio locked, change the Higher of the width and height to 100 pixels.
	5	Right click on the image: Image>Canvas Size
	6	With the aspect ratio UNlocked, change the Lower of the width and height to 100 pixels. Click "Center". Click "Resize".
	7	Right click on the image: Colors>Brightness-Contrast
	8	Increase the contrast to remove the effects of the resize, and get sharper edges.
	9	Export the file to jpg/gif/bmp/png (it doesnt really matter as long as the customizer tool can read the file).
	10	Open  http://customizer.makerbot.com/image_surface in a web browser.
	11	Select the file you want to convert. Click "Invert Colors".
	12	Copy the array of numbers to a text file. 
	13	File>Save As. In the drop-down menu "Save as type:" select "All files". This will allow you to actually set the extenstion to ".dat". Name the file <whatever>.dat.
	
Your image should now create a surface() as intended. */

////////////////////Parameters////////////////////
/* [Images] */
// Load a 40x40 pixel image for side 1. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
i1 = "toadstool.dat"; // [image_surface:40x40]
// Load a 40x40 pixel image for side 2. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
i2= "bshield.dat"; // [image_surface:40x40]
// Load a 40x40 pixel image for side 3. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
i3= "toadstool.dat"; // [image_surface:40x40]
// Load a 40x40 pixel image for side 4. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
i4= "toadstool.dat"; // [image_surface:40x40]

/* [Dimensions] */
//Depth of indendations in mm
depth=1;
//One side of the cube in mm
cube_size=10;
//How big should your image be in mm?
image_size=8;
//Diameter of charm hole (Pandora charm bracelets have a diameter of 3mm)
charm_hole=6;

/* [Hidden] */
pixels=40+0;
image=[i1,i2,i3,i4];
//How each die surface is rotated
rot=[[90,90,0],[0,90,0],[270,90,0],[180,90,0]];
ep=0+0.01;

////////////////////Main()////////////////////
difference(){
	intersection_for(i=[1:4]) {side(i);}
	//Each side is a cube minus the image, the die is the intersection of all the cubes
	cylinder(h=cube_size+ep,r=charm_hole/2,$fn=30,center=true);
	}

////////////////////Modules////////////////////
module side(side_num){
//this function takes the surface, scales it to the right size then subtracts the surface from the cube. The resulting cube is then rotated into the correct position.
	rotate(rot[side_num-1])	
		difference(){
			cube(cube_size,true);
			translate([0,0,cube_size/2]) 
				scale([image_size/pixels,image_size/pixels,-depth]) 
					surface(file=image[side_num-1], center=true, convexity=10);
			}
	}