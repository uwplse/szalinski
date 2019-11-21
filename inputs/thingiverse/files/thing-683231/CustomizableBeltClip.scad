//Customizable Belt Clip
//Author: Kimberly Schumann
//2/13/2015
//Licensed under
////////////////////Parameters////////////////////
//The width across your waist y
width=15.0;
//The thickness of your belt strap z
thickness=4.0;
//The height of your belt x
height=30.05;
//The thickness of the belt clip
shell_thickness=2.0;
//The number of x pixels in your image
pixels_in_x=100;
//The number of y pixels in your image
pixels_in_y=100;
//Height of the image relief in millimeters
scale=3;
//Choose your image
design="design3.dat"; //[image_surface:100x100]
/*[Hidden]*/
ep=0+0.01;
tolerance=0.15;
inner_height=(1+tolerance)*height;
outer_height=inner_height+2*shell_thickness;

////////////////////Main()////////////////////
rotate([90,0,0])
	difference(){
		union(){		
			outside();
			image(design);
			}
		inside();
		}
	
////////////////////Functions////////////////////
module outside(){
	cube([outer_height,width,2*(1+tolerance)*thickness+2*shell_thickness,], center=true);	
	}
module inside(){
	#cube([inner_height,width+2*ep,2*(1+tolerance)*thickness], center=true);
	}
module image(name){
	translate([0,0,thickness+shell_thickness+0.5])
		scale([(outer_height)/(pixels_in_x-1),width/(pixels_in_y-1),scale])
			surface(file=name,center=true);
	}