//Created by Ari M. Diacou, June 2014
//Shared under Creative Commons License: Attribution-ShareAlike 4.0 Unported (CC BY-SA 4.0) 
//see http://creativecommons.org/licenses/by-sa/4.0/

/*To get this to work offline, any image must be converted to a .dat file using the tool at http://customizer.makerbot.com/image_surface. That will output an array of values from 0-1 corresponding to the greyscale values 0-255 of the image. Inverting the colors of the image will ensure that the recessed image gets subracted from other objects properly. Copy the array to a text file. IMPORTANT: be sure that your file is actually a dat file and not e.g. foo.dat.txt. Some operating systems (like Windows 7 by default) hide the actual extension. Once the dat files are in the same directory as the .scad file, and are named properly the surface() function should work.

The way I prepared my image files was to:
	1	Import the image into gimp.
	2	Crop the image as tightly as possible
	3	Right click on the image: Image>Scale Image
	4	With the aspect ratio locked, change the Higher of the width and height to 100 pixils.
	5	Right click on the image: Image>Canvas Size
	6	With the aspect ratio UNlocked, change the Lower of the width and height to 100 pixils. Click "Center". Click "Resize".
	7	Right click on the image: Colors>Brightness-Contrast
	8	Increase the contrast to remove the effects of the resize, and get sharper edges.
	9	Export the file to jpg/gif/bmp/png (it doesnt really matter as long as the customizer tool can read the file).
	10	Open  http://customizer.makerbot.com/image_surface in a web browser.
	11	Select the file you want to convert. White will make holes, so dont "Invert Colors" for this thing.
	12	Copy the array of numbers to a text file. 
	13	File>Save As. In the drop-down menu "Save as type:" select "All files". This will allow you to actually set the extenstion to ".dat". Name the file <whatever>.dat.
	
Your image should now ceate a surface() as intended. */


// Load a 100x100 pixel image for the top. (images will be automatically stretched to fit) Simple, high contrast images like logos work best. White will become holes, black will remain structural, so DONT "Invert Colors" for this thing.
grill_img = "grill.dat"; // [image_surface:100x100]
//The largest width of your plate
x=40;
//The largest height of your plate
y=50;
//The depth of your plate
z=6;
//How far does the plate overhang the hole in the box?
lip=5;
//The thickness of the lip
thickness=2;
//What was the largest number of pixils in the image?
pixils=100;
image_size=min(x,y)-2*thickness;

grill_2();

module grill_1(){
	difference(){
		union(){
			cube([x,y,z],center=true);
			translate([0,0,(z-thickness)/2])
				cube([x+2*lip,y+2*lip,thickness],center=true);
			}
		scale([image_size/pixils,image_size/pixils,z]) 
			surface(file=grill_img, center=true, convexity=10);
		translate([0,0,-(z-thickness)/2])
			cube([x-2*thickness,y-2*thickness,z-thickness],center=true);
		}
	}

module grill_2(){
	difference(){
		cube([x,y,z],center=true);
		#cube([x-2*thickness,y-2*thickness,z],center=true);
		}
	
	difference(){
		translate([0,0,(z-thickness)/2])
			cube([x+2*lip,y+2*lip,thickness],center=true);
		scale([image_size/pixils,image_size/pixils,z]) 
			surface(file=grill_img, center=true, convexity=10);
		}
	}