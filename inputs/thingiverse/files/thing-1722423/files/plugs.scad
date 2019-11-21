/*
http://fortawesome.github.io/Font-Awesome/cheatsheet/
*/
/* [Basics] */
thickness						= 9; // [5:20]
diamiter						= 25; // [5:100]
hollow							= true; // [true,false]
number						= 2; // How many ears do you have?
resolution						= 50;
/* [Fun shapes] */
inside_size	= 20;
sides			= 8; // [3:100]
wall_thickeness	= .8; // normally the tip size of the printer
/* options for the middle section, not all work on thingiverse
//thin_wall
//solid
//shape
//icon
//stl
*/
//do you want a shape? or do you want to be solid? or thin wall
middle			= "shape"; //[First:solid,second:shape,third:thin_wall]
/* [Flair] */
flair_depth	= 2.5;
flair_offset_z	= 1.4; // you might need to change this if the flair looks weird when changing the thickness



/*things that don't work on thingiverse*/
// ignore variable values
//		icon					= "";
//		inverse			=	false;
//		bottom_layer	= false;
//		stl_location	= "/Users/benjamin/Desktop/projects/university of utah logo/logo.stl";
//		stl_scale			= [1.75,1.75,5];
//		font					= "fontawesome";
//		icon_size						= 11;
//		bottom_layer_height			= 2;
//module
module icon(){
	translate([0,0,-thickness]) linear_extrude(height = thickness*2) {
		text(icon, font = font, size=icon_size, halign="center", valign="center", $fn=resolution);
	}
}	

module sides(){
		cylinder(h=thickness, d=inside_size, $fn=sides, center=true);
}

module base(){
	difference(){
		cylinder(d=diamiter+flair_depth       , h=thickness, center=true, $fn=resolution);
		scale([1,1,flair_offset_z]) rotate_extrude($fn=resolution){
			translate([diamiter/2+thickness/2,0,0]) rotate([0,0,0]) circle(d=thickness);
		}
	}
}

//function

module finished(){
	difference(){
		base();
		if (middle == "shape")
		{
			sides();
		} else if(middle == "thin_wall") {
			scale([wall_thickeness,wall_thickeness,1]) base();
		} else if(middle == "icon") {
			if (inverse == true){
				inverse();
			} else {
				icon();
			}
		} else if(middle == "stl") {
				scale(stl_scale) import(stl_location);
		} else {
			// nothing
			}
	}
		if (bottom_layer == true){
			cylinder(r=inside_size, h=bottom_layer_height, $fn=resolution, center=true);
		}
}

for ( number = [0 : number-1] ) {
	translate([number*(diamiter+flair_depth+3),0,0]) finished();
}

module inverse(){
	if(inverse == true){
		difference(){
			hull(){
				icon();
			}
			icon();
		}
	}
}