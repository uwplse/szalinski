//FONT AWESOME FRIDGE MAGNETS
// get your icons here: http://fortawesome.github.io/Font-Awesome/cheatsheet/
//tutorial on how to install fontawesome here: https://www.youtube.com/watch?v=napby3wUZnw
resolution					=	100;
icon								=	"";
inverse						=	"false";

size								= 20;
thickness					=	5;
magnet_size				= 10.8;
magnet_thickness		= 1.5;

//magnet grid settings
spacing						= 15;
rows							= 1;
columes						= 1;

magnet_shape			= "circle"; //circle or square
flat_plate_behind		= "true"; //this might be needed for some icons that have loose parts 
flat_plate_thickness	= 2;

//if magnet shape is square
magnet_width			= 4;
magnet_height			= 4;







//code stuff that you dont need to worry about unless you know what you are doing

$fn= resolution;
module inverse(){
	if(inverse == "true"){
		difference(){
			hull(){
				icon();
			}
			icon();
		}
	}
}

module icon(){
	linear_extrude(height = thickness) {
		   text(text = icon, font = "fontawesome", size = size, halign = "center", valign = "center");
	}
}

module magnet(){
	if (inverse == "true"){
		inverse();
	} else {
		icon();
	}
	
	if(flat_plate_behind == "true"){
		color("black") {
			hull(){
				linear_extrude(height = flat_plate_thickness) {
					   text( text = icon, font = "fontawesome", size = size, halign = "center", valign = "center");
				}
			}
		}
	}
}
module real_individual_magnet(){
	if (magnet_shape == "square"){
		translate([0,0,magnet_thickness/2]) cube([magnet_width,magnet_height,magnet_thickness],center=true);
	} else {
		cylinder(d=magnet_size, h=magnet_thickness, $fn=20);
	}
}

module real_magnets(){
	rows =  rows -1;
	for ( i = [-rows/2 : rows/2] ){
		columes = columes -1;
		translate([0,i*spacing,0]) for ( i = [-columes/2 : columes/2] ){
			translate([i*spacing,0,0]) real_individual_magnet();
		}
	}
}

difference(){
	magnet();
	real_magnets();
}