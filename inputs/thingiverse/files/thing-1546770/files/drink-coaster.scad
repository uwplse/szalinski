/* [coaster] */
height_of_coaster = .25;
diameter_of_coaster = 3;
diameter_of_cup = 2.75;
resoultion = 42;//[20:100]
/* [Image on coaster]*/
include_image = 1;//[0: yes, 1: no]
image_file = "image-surface.dat"; // [image_surface:100x100]
side_length_of_image = 2;
/* [Unit adjustment] */
//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//END CUSTOMIZER VARIABLES
unit_conversion_factor = units_entered*desired_units_for_output;
module drink_coaster(){
	minkowski(){
		cylinder(h = .0000000001, r = diameter_of_coaster/2-height_of_coaster,$fn = resoultion,center=true);
		sphere(height_of_coaster/2,$fn=resoultion,center=true);
	}
}
module indent_for_drink(){
	translate([0,0,height_of_coaster*.375])
		minkowski(){
			cylinder(h = .0000000001, r = diameter_of_cup/2-height_of_coaster,$fn = resoultion,center=true);
			sphere(height_of_coaster/2,$fn=resoultion,center=true);
		}
}

scale(unit_conversion_factor){
	difference(){
		drink_coaster();
		indent_for_drink();
		if(include_image == 0){
			translate([0, 0, 0]){
				resize([side_length_of_image,side_length_of_image,.1]){
					surface(file=image_file, center=true, convexity=10);
				}
			}
		}
		
	}
}