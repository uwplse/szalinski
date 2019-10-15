/* **********************
// [EN] Parametric Guiding Bezel for Wire Spool Holder
// [DE] Kabelführung für Spulenhalter (parametrierbar)
// 
// www.thingiverse.com/thing:2573424
// CC-BY-SA October 2017 by ohuf@Thingiverse
// Version 2 - 2017-09-07
//
//
// (English text below...)
//
// [DE] Für meinen Spulenhalter (für Elekronikdrähte) 
// Habe ich eine Kabelführung in Form einer Lochblende benöigt.
// Die Blende sitzt vor den Spulen (Siehe Fotos). Sie erleichtert das Abrollen 
// und hindert die Kabel zurück zu rollen.
//
// Das Design in OpenSCAD ist parametrierbar.
//
// 
// -----
//
//
// For my wire spool holder I needed a wire guidance. I designed this "pinhole aperture".
// the bezel sits in front of the wire spools. 
// It facilitates grabbing the wire and keeps the it from slipping back.
//
// The OpenSCAD design is parametric: customize your own!!
//
//
// Enjoy, have fun remixing and let me know when you've made one, and what for!
//
//
// 
// oli@huf.org 2017-Oct-07
// License: CC-BY-SA
// read all about it here: http://creativecommons.org/licenses/by-sa/4.0/
// ********************** */

/* Size */
// Height of the Bezel || Höhe der Blende
bezel_height = 20;
// Number of spools || Anzahl der Spulen
spools=11; // [1:50]
// Width of each of the spools || Breite der einzelnen Spulen
spool_width=15.0; 
// Size of the cable holes. You can widen those later on with a tiny knife, a drill or sharp pliers || Größe der Kabeldurchlässe. Diese können später mit einem Cutter, Bohrer oder einer Pinzette geweitet werden.
wire_hole_diameter = 2;
// a fixed rim on both sides for the screw holes || Rechter und linker Rand für die Befestigungslöcher
rim=9.0;
// width of the screw holes on the rim || Weite der Befestigungslöcher auf dem Rand rechts und links
screw_hole_diameter = 4; 
// An additional gap to allow the spools to run freely or to cater for variances in design || Zusätzlicher Abstand, um den Spulen Bewegungsspielraum zu geben, oder um Toleranzen im Design zu kompensieren.
gap=2; // 

/* [Hidden] */
$fn=50;
totalx=2*rim + spools*spool_width + gap;
thickness=2;
ix=0.005;

difference(){
cube([totalx, bezel_height, thickness]);
union(){
	translate([rim/2, bezel_height/2, 0])
		cylinder(d=screw_hole_diameter, h=thickness+ix);	// linkes Befestigungsloch
	translate([rim+gap/2-spool_width/2, bezel_height/2, 0])
	for(i=[1:spools]){
		translate([i*15, 0, 0])
		cylinder(d=wire_hole_diameter, h=thickness+ix);
	}
	translate([totalx - rim/2, bezel_height/2, 0])
		cylinder(d=screw_hole_diameter, h=thickness+ix);	// rechtes Befestigungsloch
}
}

