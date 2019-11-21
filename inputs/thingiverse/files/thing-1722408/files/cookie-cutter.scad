/*
use this webiste to get cool icons! 

http://fortawesome.github.io/Font-Awesome/cheatsheet/

and follow this tutorial for how to install fontawesome 

*/
type	=	"text";
text	=	"";
xdf		=	"/Users/benjamin/Desktop/kokapelli cookie cutter.dxf";
resolution = 2; //this is fun to set low if you want to make low poly cookie cutters!
font = "fontawesome";
wall_thickness = 1;
wall_height = 5;
icon_height = 3;
font_size = 20;
top_thickness = 1;






$fn= resolution;
module cutter(){
	linear_extrude(height = wall_thickness) {
		if (type=="text"){
			text(text = text, font = font, size = font_size, valign = "center", halign = "center");
		} else {
			import(xdf);
		}
	}
}

module cutting_walls(){
	minkowski(){
		 cutter();
		 cylinder(r=wall_thickness/2,h=wall_height);
	}
}

difference(){
	cutting_walls();
	translate([0,0,-10]) cutter(wall_thickness = 20);
}

intersection(){
	cube([100,100,top_thickness], center=true);
	hull(){
		cutter();
	}
}