/*
call out name plate generator

Copyright (C) 2014 Matteo Zandi
Released under the GPL v3
*/

// What you want to be written on the plate
text = "mario";

// (default = 2 = 12mm wide * 14mm tall character)
font_size = 2;

// (in mm, default = 2, 0 for none)
hanger_hole_radius = 2;

// (in mm, default = 3)
height = 3;

// (in mm, default = 1)
text_height = 1;

// ignore variable values
corner = 2*1; // round cube corner size
margin = 2*1;

text_length = (len(text)*6-1)*font_size;
text_width = 7*font_size;

// text
translate([-text_length/2, -text_width/2-hanger_hole_radius, height/2]) color("orange") scale([font_size, font_size, text_height]) drawtext(text);

// plate size
length = text_length + 2*hanger_hole_radius + 2*margin; //60
width = text_width + 2*hanger_hole_radius + 3*margin; //24;

difference() {
  roundCornersCube(length, width, height, corner);
  translate([length/2-2-hanger_hole_radius, width/2-2-hanger_hole_radius, -height]) cylinder(r=hanger_hole_radius, h=height*2, $fn=20);
}

// call out
call_out_size = width/4;
translate([call_out_size-length/2+3, -width/2, -height/2]) intersection() {
  cylinder(r=call_out_size, h=height, $fn=30);
  translate([-call_out_size, -call_out_size, 0]) cube([call_out_size, call_out_size, height]);
}

/* roundCornersCube

http://codeviewer.org/view/code:1b36 
Copyright (C) 2011 Sergio Vilches
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
Contact: s.vilches.e@gmail.com


    ----------------------------------------------------------- 
                 Round Corners Cube (Extruded)                
      roundCornersCube(x,y,z,r) Where:                        
         - x = Xdir width                                     
         - y = Ydir width                                     
         - z = Height of the cube                             
         - r = Rounding radious                               
                                                              
      Example: roundCornerCube(10,10,2,1);                    
     *Some times it's needed to use F6 to see good results!   
 	 ----------------------------------------------------------- 
*/
// Test it!
// roundCornersCube(10,5,2,1);


module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   }

   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
}


module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);

translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
      translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }
}

/* textGenerator
https://www.thingiverse.com/thing:59817

OpenSCAD 3D Text Generator by pgreenland is licensed under the Creative Commons - Attribution - Share Alike license.
*/
module drawtext(text) {
	//Characters
	chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

	//Chracter table defining 5x7 characters
	//Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
	char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                  [ 4, 0, 4, 4, 4, 4, 4],
                  [ 0, 0, 0, 0,10,10,10],
                  [10,10,31,10,31,10,10],
                  [ 4,30, 5,14,20,15, 4],
                  [ 3,19, 8, 4, 2,25,24],
                  [13,18,21, 8,20,18,12],
                  [ 0, 0, 0, 0, 8, 4,12],
                  [ 2, 4, 8, 8, 8, 4, 2],
                  [ 8, 4, 2, 2, 2, 4, 8],
                  [ 0, 4,21,14,21, 4, 0],
                  [ 0, 4, 4,31, 4, 4, 0],
                  [ 8, 4,12, 0, 0, 0, 0],
                  [ 0, 0, 0,31, 0, 0, 0],
                  [12,12, 0, 0, 0, 0, 0],
                  [ 0,16, 8, 4, 2, 1, 0],
                  [14,17,25,21,19,17,14],
                  [14, 4, 4, 4, 4,12, 4],
                  [31, 8, 4, 2, 1,17,14],
                  [14,17, 1, 2, 4, 2,31],
                  [ 2, 2,31,18,10, 6, 2],
                  [14,17, 1, 1,30,16,31],
                  [14,17,17,30,16, 8, 6],
                  [ 8, 8, 8, 4, 2, 1,31],
                  [14,17,17,14,17,17,14],
                  [12, 2, 1,15,17,17,14],
                  [ 0,12,12, 0,12,12, 0],
                  [ 8, 4,12, 0,12,12, 0],
                  [ 2, 4, 8,16, 8, 4, 2],
                  [ 0, 0,31, 0,31, 0, 0],
                  [16, 8, 4, 2, 4, 8,16],
                  [ 4, 0, 4, 2, 1,17,14],
                  [14,21,21,13, 1,17,14],
                  [17,17,31,17,17,17,14],
                  [30,17,17,30,17,17,30],
                  [14,17,16,16,16,17,14],
                  [30,17,17,17,17,17,30],
                  [31,16,16,30,16,16,31],
                  [16,16,16,30,16,16,31],
                  [15,17,17,23,16,17,14],
                  [17,17,17,31,17,17,17],
                  [14, 4, 4, 4, 4, 4,14],
                  [12,18, 2, 2, 2, 2, 7],
                  [17,18,20,24,20,18,17],
                  [31,16,16,16,16,16,16],
                  [17,17,17,21,21,27,17],
                  [17,17,19,21,25,17,17],
                  [14,17,17,17,17,17,14],
                  [16,16,16,30,17,17,30],
                  [13,18,21,17,17,17,14],
                  [17,18,20,30,17,17,30],
                  [30, 1, 1,14,16,16,15],
                  [ 4, 4, 4, 4, 4, 4,31],
                  [14,17,17,17,17,17,17],
                  [ 4,10,17,17,17,17,17],
                  [10,21,21,21,17,17,17],
                  [17,17,10, 4,10,17,17],
                  [ 4, 4, 4,10,17,17,17],
                  [31,16, 8, 4, 2, 1,31],
                  [14, 8, 8, 8, 8, 8,14],
                  [ 0, 1, 2, 4, 8,16, 0],
                  [14, 2, 2, 2, 2, 2,14],
                  [ 0, 0, 0, 0,17,10, 4],
                  [31, 0, 0, 0, 0, 0, 0],
                  [ 0, 0, 0, 0, 2, 4, 8],
                  [15,17,15, 1,14, 0, 0],
                  [30,17,17,25,22,16,16],
                  [14,17,16,16,14, 0, 0],
                  [15,17,17,19,13, 1, 1],
                  [14,16,31,17,14, 0, 0],
                  [ 8, 8, 8,28, 8, 9, 6],
                  [14, 1,15,17,15, 0, 0],
                  [17,17,17,25,22,16,16],
                  [14, 4, 4, 4,12, 0, 4],
                  [12,18, 2, 2, 2, 6, 2],
                  [18,20,24,20,18,16,16],
                  [14, 4, 4, 4, 4, 4,12],
                  [17,17,21,21,26, 0, 0],
                  [17,17,17,25,22, 0, 0],
                  [14,17,17,17,14, 0, 0],
                  [16,16,30,17,30, 0, 0],
                  [ 1, 1,15,19,13, 0, 0],
                  [16,16,16,25,22, 0, 0],
                  [30, 1,14,16,15, 0, 0],
                  [ 6, 9, 8, 8,28, 8, 8],
                  [13,19,17,17,17, 0, 0],
                  [ 4,10,17,17,17, 0, 0],
                  [10,21,21,17,17, 0, 0],
                  [17,10, 4,10,17, 0, 0],
                  [14, 1,15,17,17, 0, 0],
                  [31, 8, 4, 2,31, 0, 0],
                  [ 2, 4, 4, 8, 4, 4, 2],
                  [ 4, 4, 4, 4, 4, 4, 4],
                  [ 8, 4, 4, 2, 4, 4, 8] ];

	//Binary decode table
	dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
  	            "00110", "00111", "01000", "01001", "01010", "01011",
  	            "01100", "01101", "01110", "01111", "10000", "10001",
  	            "10010", "10011", "10100", "10101", "10110", "10111",
	            "11000", "11001", "11010", "11011", "11100", "11101",
	            "11110", "11111" ];

	//Process string one character at a time
	for(itext = [0:len(text)-1]) {
		//Convert character to index
		assign(ichar = search(text[itext],chars,1)[0]) {
			//Decode character - rows
			for(irow = [0:6]) {
				assign(val = dec_table[char_table[ichar][irow]]) {
					//Decode character - cols
					for(icol = [0:4]) {
						assign(bit = search(val[icol],"01",1)[0]) {
							if(bit) {
								//Output cube
								translate([icol + (6*itext), irow, 0])
									cube([1.0001,1.0001,1]);
							}
						}
					}
				}
			}
		}
	}
}




