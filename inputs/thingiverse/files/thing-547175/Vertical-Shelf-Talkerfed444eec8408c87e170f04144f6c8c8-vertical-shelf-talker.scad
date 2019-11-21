// Vertical Shelf Talker
// 
// R. Lazure, November 2014
//
// Inspirations from the TheNewHobbyist: 
//		customized Shelf-Talker
//  http://www.thingiverse.com/thing:80211
//
// and WilliamAAdams: Yazzonic panel clips
//  http://www.thingiverse.com/thing:5208
// 
// 
//  for 2 colour print on a Replicator 2,
//      use @zpos = 4 mm when printing the plate
//

/////////////////////////
//  Customizer Stuff  //
///////////////////////

/* [Fit_and_Finish] */

// What would you like to label?
label_text = "Vente";

// How big?
font_size = 20; //[10:30]

// Make it pretty
font = "write/Letters.dxf"; // ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]

// Shelf thickness in mm
shelf_thickness = 20;

//  Plate or bracket?
part= "bracket"; // [plate:label plate,bracket:support bracket]


//For display only, not part of final model
build_plate_selector = 0; //[0:Replicator 2/2X,1: Replicator,2:Thingomatic,3:Manual]

// "Manual" build plate X dimension
build_plate_manual_x = 100; //[100:400]

// "Manual" build plate Y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

use <write/Write.scad>
use <utils/build_plate.scad>	

plate_thick = 3;
plate_width = 20;

gap=5; // space to hold plate
clr=8; // last letter above holder
holder_length = 20;
height = (1.2*font_size); // Find height of each character
width = (.6875*font_size); // Find width of each character
plate_length = height * (len(label_text)); // Find total height of text

/////////////////////////
// Build Shelf Talker //
///////////////////////


module plate()  {
// base for letters
	cube([plate_width,plate_length, plate_thick]);
// letters
	for (r = [0:len(label_text)]){ 
		translate([(plate_width-width)/2,plate_length - height*(r+1), plate_thick-0.5])
			 write(label_text[r],h=font_size,t=3,font=font, space=letter_spacing);

}
}

module base()  {
	cube([plate_width,holder_length+clr,plate_thick]);

}

module bracket() {
	union() {	
// holder	
		cube([2, holder_length, 20]);
		translate([gap+1,0,0]) rotate([0,0,4]) cube([2, holder_length, 20]);
// shelf bracket		
		translate([0,shelf_thickness * -1 - 3,0]) cube([2, shelf_thickness + 3, 20]);
		translate([0,shelf_thickness * -1 - 3,0]) rotate([0,0,5]) cube([25, 2, 20]);
		translate([0,-1.5,0]) cube([20, 3, 20]);
		}
}

//
//  choosing the part to print
//	
if (part == "plate") 
		{
			translate([(plate_length+holder_length)/2,-plate_width/2,0])   {
			rotate([0,0,90]) {
			translate([0,holder_length+clr,0]) plate();
			base();
								}}
			
						}	
		 else 		{
				translate([-12,5,0]) bracket();
						}




// translate([30,-2,0]) bracket();
// translate([0,holder_length+clr,0]) plate();
// base();

