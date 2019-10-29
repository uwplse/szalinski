// Batch Keychain Generator v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:101307
//
// I needed something to quickly generate custom models for
// a 3D printing demo I was doing. I was going to just
// make a pile of generic keychains but I thought it would
// be more fun if I could make customized models for each 
// person.
//
// Change Log:
//
// v1.0
// Initial Release
//
// v1.1
// ADDED Round Tag and Blocky style keychains
//

/* [Make It Your Own] */

Keychain_Style = "Tag"; //["Classic":Classic, "Tag":Round Tag, "Block":Blocky]

text1 = "TNH";
text2 = "";
text3 = "";
text4 = "";
text5 = "";
text6 = "";
text7 = "";
text8 = "";
text9 = "";

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

// preview[view:south, tilt:top]

use <write/Write.scad>
use <utils/build_plate.scad>

$fn=24;

function substring(string, start, length) = length > 0 ? str(string[start], substring(string, start + 1, length - 1)) : "";

module classicKeychain(num){
	if (num == ""){}
	else{
		translate([0,0,1.5]) {
			rotate([-90,0,0]){
				union() {
					for ( i = [0 : 2] )	{
						translate([12*i,0,-8]) cube([12, 3, 2], center=true);
						translate([12*i,0,0]) rotate([90,0,0]) write(substring(str(num,"   "), i,1),h=15,t=3,font="write/orbitron.dxf", space=1, center=true);
					}
					difference(){
						translate([-9,0,-8]) rotate([90,0,0]) cylinder(r=4, h=3, $fn=50, center=true);
						translate([-9,0,-8]) rotate([90,0,0]) cylinder(r=2.5, h=4, center=true);
					}
				}
			}
		}
	}	
}

module tagKeychain(num){
	if (num == ""){}
	else{
		translate([0,0,1.5]) {
			rotate([-90,0,0]){
				difference(){
					
					hull() {
						translate([-6,0,0]) rotate([90,0,0]) cylinder(r=11, h=3, center=true);
						translate([26,0,0]) rotate([90,0,0]) cylinder(r=11, h=3, center=true);
					}
					translate([-10,0,0]) rotate([90,0,0]) cylinder(r=3, h=10, center=true);
					for ( i = [0 : 2] )	{
						translate([12*i,-3,0]) rotate([90,0,0]) write(substring(str(num,"   "), i,1),h=15,t=5,font="write/orbitron.dxf", space=1, center=true);
					}
					
						
					
				}
			}
		}
	}	
}

module blockKeychain(num){
	if (num == ""){}
	else{
		translate([0,0,1.5]) {
			rotate([-90,0,0]){
				difference(){
				translate([10,-1,0]) cube([50, 5, 10], center=true);
				translate([-10,0,0]) rotate([90,0,0]) cylinder(r=3, h=10, center=true);
			}
					for ( i = [0 : 2] )	{
						translate([12*i,-2.5,0]) rotate([90,0,0]) write(substring(str(num,"   "), i,1),h=15,t=8,font="write/orbitron.dxf", space=1, center=true);
				}
			}
		}
	}	
}

if (Keychain_Style == "Classic"){
	translate([-45,20,0]) classicKeychain(text1);
	translate([0,20,0]) classicKeychain(text2);
	translate([45,20,0]) classicKeychain(text3);
	translate([-45,0,0]) classicKeychain(text4);
	translate([0,0,0]) classicKeychain(text5);
	translate([45,0,0]) classicKeychain(text6);
	translate([-45,-20,0]) classicKeychain(text7);
	translate([0,-20,0]) classicKeychain(text8);
	translate([45,-20,0]) classicKeychain(text9);
}

if (Keychain_Style == "Tag"){
	translate([-55,25,0]) tagKeychain(text1);
	translate([0,25,0]) tagKeychain(text2);
	translate([55,25,0]) tagKeychain(text3);
	translate([-55,0,0]) tagKeychain(text4);
	translate([0,0,0]) tagKeychain(text5);
	translate([55,0,0]) tagKeychain(text6);
	translate([-55,-25,0]) tagKeychain(text7);
	translate([0,-25,0]) tagKeychain(text8);
	translate([55,-25,0]) tagKeychain(text9);
}

if (Keychain_Style == "Block"){
	translate([-55,25,0]) blockKeychain(text1);
	translate([0,25,0]) blockKeychain(text2);
	translate([55,25,0]) blockKeychain(text3);
	translate([-55,0,0]) blockKeychain(text4);
	translate([0,0,0]) blockKeychain(text5);
	translate([55,0,0]) blockKeychain(text6);
	translate([-55,-25,0]) blockKeychain(text7);
	translate([0,-25,0]) blockKeychain(text8);
	translate([55,-25,0]) blockKeychain(text9);
}