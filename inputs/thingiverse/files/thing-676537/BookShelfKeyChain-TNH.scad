// Book Shelf Keychain Customizer v1.1
// by TheNewHobbyist 2015 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:676537
//
// "Book Shelf Keychain Customizer" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// Description: 
// I built this Bookshelf keychain for a Librarian friend of mine. 
// She was looking for something to use as a demo object for her 
// library's new 3D printer.
//
// The keychain can be customized with any text you'd like, as well as
// having the text embossed or debossed. It's a pretty quick print and 
// is great for creating customized objects for groups of any size.
//
// Here's a video showing the build. From drawing, to SketchUp 
// prototype, to finished customizable OpenSCAD design: 
// https://www.youtube.com/watch?v=D8lfMnmhgjc&feature=youtu.be
//
// Usage: 
// Click "Open in Customizer" or edit the .scad file
// Enter some text for your keychain
// Pick a text style
// Print!
//

/*

Add notes, usage

TNH embed

*/

/* [Make It Your Own] */
text = "TNH";
text_style = 1; // [0:Deboss (Letters Poke In), 1:Emboss (Letters Stick Out)]

keychain_loop = "Yes"; // [Yes, No]

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

// preview[view:south, tilt:top diagonal]

use <write/Write.scad>
use <utils/build_plate.scad>

$fn=24;

function substring(string, start, length) = length > 0 ? str(string[start], substring(string, start + 1, length - 1)) : "";

module bookShape(bookheight) {
	cube([3, 5, bookheight], center=true);
	translate([1.5,-1,0]) cube([4, 3, bookheight], center=true);
	translate([-1.5,-1,0]) cube([4, 3, bookheight], center=true);
	translate([1.5,.5,0]) cylinder(r=2, h=bookheight, center=true);
	translate([-1.5,.5,0]) cylinder(r=2, h=bookheight, center=true);
}

module bookSolid() {
	difference() {
		union() {
			translate([0,.5,5]) bookShape(.5);
			translate([0,.5,4]) bookShape(.5);
			translate([0,.5,-5]) bookShape(.5);
			translate([0,.5,-4]) bookShape(.5);
			bookShape(13);	
		}
		translate([0,-.5,7]) scale(.9) bookShape(2);
	}
}

module BookLetter(letter) {
	rotate([0,0,180]) {
	if (text_style == 0) {
		difference() {
			bookSolid();
			translate([-.25,3.5,0]) rotate([90,0,180]) write(letter,h=5,t=3,font="write/orbitron.dxf", space=1.1, center=true);
		}	
	}
	else{
		union(){
			bookSolid();
			translate([-.25,1.5,0]) rotate([90,0,180]) write(letter,h=5,t=3,font="write/orbitron.dxf", space=1.1, center=true);
			}
		}
	}
}

if (keychain_loop == "Yes") {
	translate([0,0,6.5]) {
		union() {
			difference() {
				translate([-3,.5,0]) rotate([90,0,0]) cylinder(r=7, h=4, center=true, $fn=48);
				translate([-3,.5,0]) rotate([90,0,0]) cylinder(r=4, h=10, center=true, $fn=48);
				translate([0,0,11.5]) cube([100, 10, 10], center=true);
				translate([0,0,-11.5]) cube([100, 10, 10], center=true);
				translate([2,0,0]) cube([10, 10, 20], center=true);
				}
			for ( i = [0 : len(text)-1] )	{
				translate([7*i,0,0]) BookLetter((substring(text, i,1)));
			}
		}
	}
}

if (keychain_loop == "No") {
	translate([0,0,6.5]) {
		union() {
			for ( i = [0 : len(text)-1] )	{
				translate([7*i,0,0]) BookLetter((substring(text, i,1)));
			}
		}
	}
}