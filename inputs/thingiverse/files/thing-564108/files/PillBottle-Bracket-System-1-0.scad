//*************************************************
// Pill Bottle Bracket System
// 2014 - Tim Deagan (thingiverse:tdeagan)
// http://slamdanz.com
//
// interlocking set of brackets to use standard pill
// 		bottles as a storage solution
//
// - change commenting to print a single bracket, three brackets
//		joined in a triangle or a flat edged stand
//
// - configurable hex_to_bot option to either:
//		a) make the bracket proportional to the pill bottle 
//		b) set the bracket size independently of the bottle size
// 		
//		option b allows mixing different size pill bottles in the same
//		set of brackets
//
//*************************************************

//========================
// configurable variables (units in mm)
//========================

// Select which thing to make; 1= Single Hex, 2= Triple Hex, 3= Stand
	bracket_to_print = 2;	//[1,2,3]
	
// if printing a stand, how many half-hexes to print
	stand_hexes = 2; //[1,2,3]

// radius of pill bottle
	bot_rad = 25; 	//[25,19.5]

// Should the hex size be proportional to bottle size? yes=1, no=0
	hex_to_bot = 1; 		//[1,0]
	
// if hex_to_bot = 0 (no) then enter bottle radius to use for hex size
	hex_bot_rad = 25; //[25,19.5,16.5]

// extra edge around pill bottle
	rim = 4;				

// part thickness
	thick = 4;				

// expansion factor for linkage indents, closer to 1.0 means tighter
// fit between parts.  Flash on first layer or other factors may require 
// a larger expansion, rarely larger than 1.45
	expansion = 1.35;		

// number of circle segments
	$fn = 100;				

//========================
// derived variables
//========================

hex_h = (hex_to_bot == 1) 
	? ((bot_rad + rim) * 2) 
	: ((hex_bot_rad + rim) * 2);	// internal hex height
hex_s = hex_h/sqrt(3);				// length of internal hex side
hex_d = hex_s * 2; 			// internal hex length across vertices
ltri_h = sqrt(3) / 2 * hex_s;	// link triangle height
ltri_c = hex_s * .289;				// link triangle center offset

//###############################################################
//### MAIN CODE SECTION (uncomment desired output) ##############
//###############################################################

if (bracket_to_print == 1)	// single hex bracket 
	bracket(0,0);

if (bracket_to_print == 2)	// joined set of three brackets
	tri_set();

if (bracket_to_print == 3)	
// extensible stand for brackets (based on hex size)
// change argument to set number of joined half hexes 
	stand(stand_hexes);

//###############################################################
module hexagon(){
	color("red")
	difference(){
		cube([hex_d,hex_d,thick], center= true);
		
		for (i=[0:5]){
			rotate(i*360/6,[0,0,1])
			translate([hex_s,0,-(thick*1.1)/2])
				rotate([0,0,30])
				cube([hex_d * .66,hex_d * .66,thick*1.1]);
		}
	} 
}

//---------------------------
module hex_holder(x,y){
// internal hexagon with pill bottle hole cut out

	difference(){
		hexagon();
		cylinder(h=thick*2,r=bot_rad, center=true);
	}
}

//---------------------------
module linkage(rot) {
// constructs a triangle with one extrusion and one indent
// three combine at hex intersection to form a link triangle

	rotate([0,0,rot])
	union(){
		difference() {
			// cut down rectangle to triangle-----
			translate([0,hex_s/2-ltri_c,0]) 
				cube([hex_s, hex_s, thick], true);
				
			translate([hex_s/2,-ltri_c,0])
			rotate([0,0,60]) 
			translate([0,0,-(thick*1.1)/2])
				cube([hex_d, hex_s, thick*1.1]);
				
			translate([-hex_s/2,-ltri_c,0]) 
			rotate([0,0,30]) 
			translate([0,0,-(thick*1.1)/2])
				cube([hex_d, hex_s, thick*1.1]);
			//-------------------------------------
			
			// remove indent
			translate([-hex_s/8,-ltri_c/2,0])
			rotate([0,0,30])
				union(){
					translate([0,(ltri_c/8),0])
					scale([expansion,1,1])		
						cube([ltri_c/4,ltri_c/4,thick*1.1], center = true);
						
					translate([0,-(ltri_c/8),-(thick*1.1)/2])
					scale([expansion,expansion,1])
						cylinder(h=thick*1.1, r=ltri_c/4);
			}		
		}
	  
		// add extrusion
		rotate([0,0,120])	
		translate([-hex_s/8,-ltri_c/2,0])
		rotate([0,0,30])
			union(){
				translate([0,(ltri_c/8),0])		
					cube([ltri_c/4,ltri_c/4,thick], center = true);
					
				translate([0,-(ltri_c/8),-thick/2])
					cylinder(h=thick, r=ltri_c/4);
			}
	}
  
}//----------------------------
module bracket(x,y){
// adds the linkage to each of the sides of the hex
// long side of linkage mates with side of internal hex

	translate([x,y,0])
	union(){

		hex_holder(0,0);
			
		for (i=[0:5]){
			rotate(i*360/6,[0,0,1])
			translate([hex_s,(ltri_h/2)+ltri_c/2,0])
				linkage(300);
		}
	}
}

//-------------------------------
module tri_set(){
// unions three brackets into a triangular set, fills in the gaps

	union(){
		// three brackets in a triangle
		bracket(0,0);
		bracket(hex_d,0);
		bracket(hex_s,hex_h);
		
		// fill in link triangle
		translate([hex_s,ltri_h-ltri_c,0])
			cylinder(h=thick, r=ltri_c+rim, center= true);
			
		// fill in each of three seams between brackets	
		translate([hex_s,ltri_h-ltri_c,-thick/2])
		rotate([0,0,150])
		mirror([0,1,0])
		translate([0,-1,0])
			cube([(ltri_h-ltri_c)*2,hex_s-bot_rad+1,thick]);
			
		translate([hex_s,ltri_h-ltri_c,-thick/2])
		rotate([0,0,270])
		mirror([0,1,0])
		translate([0,-1,0])
			cube([(ltri_h-ltri_c)*2,hex_s-bot_rad+1,thick]);

		translate([hex_s,ltri_h-ltri_c,-thick/2])
		rotate([0,0,390])
		mirror([0,1,0])
		translate([0,-1,0])
			cube([(ltri_h-ltri_c)*2,hex_s-bot_rad+1,thick]);	
	}
}

//----------------------------------
module stand(cnt){
// constructs a radius'd bottom stand of cnt number half hexes

	union(){
		difference(){
			union(){
				for (i = [ 0 : (cnt-1)]){
					bracket(hex_s+(hex_d*i),0);
					
					//restore center
					translate([hex_s+(hex_d * i),0,0])
						cylinder(h=thick,r=bot_rad+rim, center=true);
										
					//if more then one, fill in seam between brackets	
					if (i > 0) {
						translate([hex_d*i,ltri_h-ltri_c,-thick/2])
						rotate([0,0,270])
						translate([0,-1,0])
							cube([(ltri_h-ltri_c),hex_s-bot_rad+1,thick]);
					}
				}
			}
		
			//cut off the bottom half 
			translate([-((hex_d*1.5)/2),-(hex_d*1.5),-thick*5]) 
				cube([((hex_d*1.5)*(cnt))+hex_d,hex_d*1.5,thick*10]);
		}
		 
		// add a nice rounded edge (aka radius) along bottom
		rotate([0,90,0])
			cylinder(h=hex_d*cnt, r=thick/2);
	}
}