// Copyright 2013 Glen Chung
// This file is licensed Creative Commons Attribution-ShareAlike 3.0.
// http://creativecommons.org/licenses/by-sa/3.0/legalcode

use <MCAD/shapes.scad>
use <MCAD/fonts.scad>

/* [Global] */

//plate thickness
thickness = 15;

//text to be printed (at least one character)
text = "HELLO WORLD";

//horizontal space to plate boundary
text_space = 10;

//extruder x position
extruder_xpos = 68;

//extruder y position
extruder_ypos = 54;  //[25:54]

//nozzle resolution
nozzle_resolution = 6;

//enable hanging hole
enable_hole = 0; //[1:true, 0:false]

//style (hollw or single side)
style = 1; //[0:hollow,1:singleside]

//base style
base_style = 2; //[0:none, 1:solid, 2:foot]

//output
output_style = 2; //[0:text only, 1:plate only, 2:both]

/* [Hidden] */
text_font = 8bit_polyfont();
indicies = search(text,text_font[2],1,1);
width = len(indicies)*32+text_space*2;
height = 67;
round_dia = 30;
rod_height = 5;
rod_thick = 10;
extruder_width = 28;
extruder_height = 18;
extruder_thick = thickness;
nozzle_dia = 7;
nozzle_height = 10;
text_scale = [4,5,3];
build_plate_width = len(indicies)*32;
build_plate_height = 8;
hanging_hole_size = 18;
plate_color = "Grey";
text_color = "Red";
printer_color = "Silver";

scale([0.2666,0.2666,0.3333]) {

if(output_style == 1 || output_style == 2) {
	difference() {
		union() {
			//plate
			translate([0, height/2, 0])
			difference() {
				color(plate_color)
				translate([-(width-round_dia)/2, -(height-round_dia)/2, -thickness/2])
					minkowski()
					{
 						cube([width-round_dia,height-round_dia,thickness/2]);
 						cylinder(r=round_dia,h=thickness/2);
					}

				translate([-(width)/2, -(height)/2, -thickness])
					cube([width,height,thickness*2]);
			}

			//x-rod
			translate([-width/2, extruder_ypos, -rod_thick/2]) color (printer_color)
				cube([width, rod_height, rod_thick]);

			//extruder
			translate([extruder_xpos, 0, 0]) color(printer_color) {
				translate([0,extruder_ypos+rod_height/2, 0])
					translate([-extruder_width/2,-extruder_height/2,-extruder_thick/2])
					cube([extruder_width,extruder_height,extruder_thick]);

				//nozzle
				translate([0,extruder_ypos-extruder_height/2-nozzle_height/4,0])
				rotate([90,0,0]) {
					cylinder(h = nozzle_height/2, r1 = nozzle_dia, r2 = nozzle_dia/4);
					translate([0,0,-nozzle_height/2])
						cylinder(h = nozzle_height/2, r = nozzle_dia);
				}
			}


			//Build Plate
			translate([-build_plate_width/2,-0.2,-thickness/2]) color(printer_color){
				cube([build_plate_width,build_plate_height,thickness*.9]);
			}

			//hanging hole
			if(enable_hole == 1) {
				translate([0,height+round_dia/2-hanging_hole_size/10,-thickness/2])
				color(plate_color) difference() {
					cylinder(h = thickness, r=hanging_hole_size);

					translate([-hanging_hole_size,-hanging_hole_size, -thickness/2])
						cube([hanging_hole_size*2,hanging_hole_size,thickness*2]);

					translate([0,hanging_hole_size/3,-thickness/2])
					cylinder(h = thickness*2, r=hanging_hole_size/4);
				}
			}

			//style
			if(style == 1) { //single side
				translate([-(width)/2, 0, -thickness/2]) color(plate_color)
					cube([width,height,thickness/4]);
			}

			//base
			if(base_style == 1 ) {
				translate([-width/2-round_dia/2,-round_dia,-thickness/2]) color(plate_color) {
					cube([width+round_dia,round_dia,thickness]);
				}
				translate([-width/2-round_dia/2,-round_dia/2,-thickness/2]) color(plate_color) {
					cube([round_dia/2,round_dia,thickness]);
				}
				translate([width/2,-round_dia/2,-thickness/2]) color(plate_color) {
					cube([round_dia/2,round_dia,thickness]);
				}
			}

			if(base_style == 2 ) {
				difference() {
					union() {
						translate([-width/2-round_dia/2,-round_dia,-thickness/2]) color(plate_color) {
							cube([width+round_dia,round_dia,thickness]);
						}
						translate([-width/2-round_dia/2,-round_dia/2,-thickness/2]) color(plate_color) {
							cube([round_dia/2,round_dia,thickness]);
						}
						translate([width/2,-round_dia/2,-thickness/2]) color(plate_color) {
							cube([round_dia/2,round_dia,thickness]);
						}
					}

					translate([-width/2+thickness,-round_dia-round_dia/2-round_dia/4,-thickness])
						cube([width-thickness*2,round_dia,thickness*2]);
				}
			}
		}
		text();
	}
}


//text
if(output_style == 0 || output_style == 2) {
	text();
}

}


module text() {
	difference() {
		union() {
			scale(text_scale)
				translate([-len(indicies)*text_font[0][0]/2,text_font[0][1]/2+.5-.05, -3])
				{
					for(i=[0:(len(indicies)-1)] ) 
						translate([ i*text_font[0][0], -text_font[0][1]/2 ,1]) 
						{
							//color(text_color)
								linear_extrude(height=4) polygon(points=text_font[2][indicies[i]][6][0],paths=text_font[2][indicies[i]][6][1]);
						}
				}
		}

		translate([extruder_xpos+nozzle_resolution/4,extruder_ypos-extruder_height/2-nozzle_height+rod_height/2-nozzle_resolution,-thickness])
			cube([width,height,thickness*2]);
		translate([-width+extruder_xpos+nozzle_resolution/4,extruder_ypos-extruder_height/2-nozzle_height+rod_height/2,-thickness])
			cube([width,height,thickness*2]);
	}
}