/*

	Keyboard-Holder, 2017 fp

*/
use<build_plate.scad>;
$fn=400;
// Parameter

thickness=2;			// Dicke des Materials
mr=0.5;
depth=22+(thickness)+(mr*2);			// Tiefe der Halterung (Dicke der Tastatur)
width=15;			// Breite des Materials
gap=50;				// Wie breit ist die Halterung nach rechts/links
height=140;			// Höhe der Halterung
mh=0.5;

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 1000; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 1000; //[100:400]


module halterung()
{
// rechts
minkowski()
{
translate([gap,0,0])
rotate([0,0,0])
cube([width,thickness,height]);
cylinder(r=mr,h=mh);
}

minkowski()
{
translate([gap,2.0,0.0])
rotate([90,0,0])
cube([width,thickness,depth]);
cylinder(r=mr,h=mh);
}

minkowski()
{
translate([gap,-depth,0])
rotate([0,0,0])
cube([width,thickness,height/2]);
cylinder(r=mr,h=mh);
}

minkowski()
{
translate([0,0,height])
rotate([0,90,0])
cube([width,thickness,gap]);
cylinder(r=mr,h=mh);
}
// links

minkowski()
{
translate([-gap-width,0,0])
rotate([0,0,0])
cube([width,thickness,height]);
cylinder(r=mr,h=mh);
}
minkowski()
{
translate([-gap-width,2.0,0.0])
rotate([90,0,0])
cube([width,thickness,depth]);
cylinder(r=mr,h=mh);
}
minkowski()
{
translate([-gap-width,-depth,0])
rotate([0,0,0])
cube([width,thickness,height/2]);
cylinder(r=mr,h=mh);
}
minkowski()
{
translate([-gap,0,height])
rotate([0,90,0])
cube([width,thickness,gap]);
cylinder(r=mr,h=mh);
}
}

difference()
{
	halterung();
	bohrloch();
}

module bohrloch()
{
	translate([-gap-(width/2),+thickness*2,height-(width/2)])
	rotate([90,90,0])
	cylinder(h=thickness*3,r1=thickness,r2=thickness);	

	translate([+gap+(width/2),+thickness*2,height-(width/2)])
	rotate([90,90,0])
	cylinder(h=thickness*3,r1=thickness,r2=thickness);	

}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
