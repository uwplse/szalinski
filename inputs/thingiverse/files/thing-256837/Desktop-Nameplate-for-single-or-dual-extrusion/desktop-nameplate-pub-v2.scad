////////////////////////
//  Desk Nameplate
//
//  Oct 5, 2013
//  RLazure
//
//  This desktop nameplate is intended to be
//  printed in 2 colours.
//
//  Use the Pause @ZPos feature in the Replicator's
//  version 7.3 firmware.
//
//  This code is inspired in part
//			by TheNewHobbyist's
//  input parameters and label length calculations
//
//    Version 2 change to allow dualextrusion on the Replicator 2x
//			February 22, 2014
//
//////////////////////////////

// include <write.scad> for home computer
include <write/Write.scad>

///// inputs ////////////////

// What would you like to label?
label_text = "Startrek fan";

// What style of characters?
font = "Letters.dxf"; // ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]

// How big?
font_size = 12; //[8:20]

// Want to space out that text?
letter_spacing = 1; // // [0.9:Tight,1:Default,1.5:Wide]

// How much space on the ends?
end_space = 3; //[0:10]

//  Single or Dual Extrusion ?
part= "single"; // [single:full nameplate,dual1:base of nameplate,dual2: text of nameplate]


///////////////////  calculations  //////////////

width = (.6875*font_size*letter_spacing); // Find width of each character
totalwidth = width * len(label_text); // Find total width of text

length_extrude = totalwidth+(end_space*width);
textz_start_pos = totalwidth/2;
textx_start_pos = (24-font_size)/2 + font_size;


/////// debug ////////

echo("len label text= ",len(label_text));
echo("totalwidth= ",totalwidth);
echo("width = ",width);
echo("length_extrude = ",length_extrude);
echo("textz_start_pos = ",textz_start_pos);

///////////////////////////////////////
/////// modules ///////////////////////
//////////////////////////////////////
//
// --------------------------
module base(){
//
//  base on which text rests
//
   linear_extrude(height=length_extrude, center = true)
	polygon([[8,0],[0,16],[24,16],[16,0]], [[0,1,2,3]]);  // profile shape
				 }
//
//---------------------------
module text_plate()
//
// text on extrusion
//
				 {
	translate([textx_start_pos,15.5,textz_start_pos]) rotate([0,90,90])
	write(label_text,t=3.5,h=font_size,font=font,center=false);
				 }
//
// --------------------------
module print_part()
				{
//
//  assembly depending on single or dual extruder
//	
if (part == "single") 
		{
			union() {
				base();
				text_plate();
						}	
		} else if (part == "dual1")
			{
				base();
		} else if (part == "dual2")
			{
				text_plate();
		}
}

//////////////////////////////////////////////////////

// orient on platform

rotate([90,0,270])
translate([-12,0,0]) print_part();

