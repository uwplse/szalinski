/********************************************************************************************************
COUCH SPUD | Customisable Tray Designed by: Mike Thompson 5/12/2013, http://www.thingiverse.com/mike_linus
V2 Updated 5/10/2014 by Mike Thompson: fully customisable version

Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.  Further information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB

Couch Spud is a simple and effective customisable tray.  

Key features include:
- fully customisable
- drink holder/s to stop cups slipping
- words/letters can be engraved on the base

The tray is particularly useful for couch potatoes when you need a tray for your drink, food and remote but only have an arm rest or some limited space available.

Enjoy! 
********************************************************************************************************/

/**************************************************************************
Enter the values corresponding to your tray requirements in this section
***************************************************************************/

/* [Tray Dimensions] */

//The width of the tray
tray_width     		= 198;
//The length of the tray (note: if creating a long rectangular tray, reduce the width rather than length to preserve the correct placement of writing)
tray_length     		= 198;
//The height of the outer perimeter walls
tray_height     		= 15;	
//The thickness of the outer perimeter walls
tray_wall     		= 2.5;	
//The thickness of the base
tray_base     		= 3;
//The radius of the tray corners
corner_radius   		= 20;

/* [Drink Holders] */

//Number of Drink Holders
drink_number			= 1;	//[0,1,2]
//The radius of the drink holder (use exact measurement of largest drink cup base)
drink_radius			= 45;	
//The thickness of the drink holder wall
drink_wall  			= 2;	
//The height of the drink holder wall
drink_height  		= 2;	
//Allowance margin for cup fit (space between cup base and wall)
margin				= 0.5;

/* [Writing] */

//Generate writing on tray
include_writing		= "include";//[include,exclude]
//Letters or words to write
writing				= "My Tray";	
//Size of font
font_height			= 15;
//Depth of engraving. Use a font depth equal or larger than the thickness of the tray base to punch through 
font_depth			= 1;

include <write/Write.scad> //library to enable text to be added

//Curve resolution
$fn=100;

//module to build the basic tray
module base() {
	difference(){
		hull(){
			cylinder(r=corner_radius,h=tray_height);
			translate([tray_width-(corner_radius * 2),tray_length-(corner_radius * 2),0])cylinder(r=corner_radius,h=tray_height);
			translate([0,tray_length-(corner_radius * 2),0])cylinder(r=corner_radius,h=tray_height);
			translate([tray_width-(corner_radius * 2),0,0])cylinder(r=corner_radius,h=tray_height);
		}
		hull(){
			translate([0,0,tray_base])cylinder(r=corner_radius-tray_wall,h=tray_height);
			translate([tray_width-(corner_radius * 2),tray_length-(corner_radius * 2),tray_base])cylinder(r=corner_radius-tray_wall,h=tray_height);
			translate([0,tray_length-(corner_radius * 2),tray_base])cylinder(r=corner_radius-tray_wall,h=tray_height);
			translate([tray_width-(corner_radius * 2),0,tray_base])cylinder(r=corner_radius-tray_wall,h=tray_height);
		}	
	}
}

//module to build the drink holder/s
module drink() {
	difference() {
		difference() {
			cylinder(r=drink_radius+drink_wall+margin,h=drink_height);
			cylinder(r=drink_radius+margin,h=drink_height+0.1);
		}
		cube([drink_radius+drink_wall,drink_radius+drink_wall,drink_wall+0.1]);
	}
}

//build the final object
difference() {
	union() {
		base();
		if(drink_number>0) {
			translate([drink_radius+drink_wall+margin-corner_radius,drink_radius+drink_wall+margin-corner_radius,tray_base])rotate(180)drink();
		}
		if(drink_number>1) {
			translate([tray_width-corner_radius-drink_radius-drink_wall-margin,drink_radius+drink_wall+margin-corner_radius,tray_base])rotate(270)drink();
		}	
	}
	if(include_writing=="include") {	
		translate([tray_width/2-corner_radius,tray_length*2/3,tray_base])rotate(180)write(writing,h=font_height,t=font_depth*2,center=true);
	}
}