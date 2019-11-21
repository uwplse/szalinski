// Wandkonsole - wall console
// wall_console_v2.scad
// Author: djgan - Dr. Jürgen Ganzer, Germany
// last update: 2019-02-25

// Verwendet - used Write.SCAD By Harlan Martin
// https://www.thingiverse.com/thing:16193

use <Writescad/Write.scad>

$fn=100;

// Aussenmaße mm - external dimensions mm
l = 50;  // x-Wert
w = 60; // y-Wert
h = 45; // z-Wert

// font of console text
// [BlackRose,braille,knewave,Letters,orbitron]
font = "Letters"; 
// text to console
text = "DJGan"; // max. 7 Zeichen
color("blue")
rotate([90,0,0])
translate([0,12,-14.3])
write(text, t=3,h=5,center = true, font=str(font, ".dxf"));

 module prism(l, w, h){
       polyhedron(points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]], faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
       }

difference () {
union() {
	color("green")
    translate([-l/2,-w/2,0])
	prism(l, w, h);	
	
}
	//Aussparung_1 - notch_1
	color("lightgreen")
	translate([0,21,22])
	minkowski() {
		cube([14,5,66], true);
		cylinder(r=1,h=40);
		}
	//Bohrungen - holes for screw
	color("lightblue")
	translate([-15,20,-40])
	cylinder(r=2,h=100); //Bohrung_1
	translate([-15,20,10])
	color("lightblue")
	cylinder(r=4,h=100); //Bohrung_1
	color("lightblue")
	translate([15,20,-40])
	cylinder(r=2,h=100); //Bohrung_2
	color("lightblue")
	translate([15,20,10])
	cylinder(r=4,h=100); //Bohrung_2

	color("pink")
	rotate([90,0,0])
	translate([0,22,-40])
	cylinder(r=2,h=100); //Bohrung_3
	color("pink")
	rotate([90,0,0])
	translate([0,22,-20])
	cylinder(r=4,h=100); //Bohrung_3
	//Aussparung_2 - notch_2
	color("yellow")
	translate([0,-18,0])
	minkowski() {
		cube(size = [17,42,70], center = true);
		cylinder(r=11,h=40);
		}
}