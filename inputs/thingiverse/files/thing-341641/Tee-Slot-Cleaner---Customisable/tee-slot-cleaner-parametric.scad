/*Tee slot cleaner - parametric and customisable
By the DoomMeister

//Released under the terms of the GNU GPL v3.0
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

Uses Write.scad by HarlanDMii
http://www.thingiverse.com/thing:16193
*/
use <write/Write.scad> 

/* [Global] */
//Thickness of the Tee Slot Cleaner tool
thickness = 3;       // [1:20]
/* [TeeSlot] */
//Width of the slot (screw size)
slot_width = 7;      // 
//Slot Length, Include an allowance here to stop the handle binding on the top surface
slot_height = 10;    // 
//Tee Slot Width
tee_width = 12;    // 
//Teeslot Height
tee_height = 5;    // 


/* [Handle] */
//Handle Width
handle_width = 20;   // [10:50]
//Handle Height
handle_height = 100; // [20:300]
//Diameter of hole in handle (Set 0 for None)
hole_dia = 5;	    // [3:20]
//Handle Text (To remind you what its for)
handle_text  = "DoomMeister";

/* [Tweak] */ 
//Clearance on slot and tee section
clearance = 0.4;
//Handle Text Height as a Ratio of Handle Width
handle_text_size = 0.5;

/* [Hidden] */
width_offset = handle_width/2;

/*----Test Section----*/
tee_slot_cleaner();
/*----assembly----*/
module tee_slot_cleaner(){
union(){
	translate([0,slot_height+tee_height,0])handle();
	tee();
	}
}

/*----modules----*/
module tee(){
	union(){
		translate([-(slot_width-clearance)/2,0,0])cube([slot_width-clearance,slot_height+tee_height,thickness]);	
		translate([-(tee_width-clearance)/2,0,0])cube([tee_width-clearance,tee_height-clearance,thickness]);			
	}
}

module handle(){
	difference(){
		union(){
			translate([-handle_width/2,0,0])cube([handle_width,handle_height-handle_width,thickness]);
			translate([0,handle_height-handle_width,0])cylinder(r = handle_width/2, h = thickness);
			}
		translate([0,handle_height-handle_width,-1])cylinder(r = hole_dia/2, h = thickness+2);	
		translate([0,(handle_height-handle_width)/2,thickness-1])rotate([0,0,90])write(handle_text,t=3,h=handle_width*handle_text_size,center=true);
		}

}