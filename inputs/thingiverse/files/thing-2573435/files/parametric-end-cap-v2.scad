/* ********************
//
// End Cap for Axle - Endkappe für Rundholz
// CC-BY-SA October 2017 by ohuf@Thingiverse
//
// www.thingiverse.com/thing:2573435

(English text below...)

Für meinen Spulenhalter (für Elekronikdrähte) 
benutzte ich einen Buche-Rundstab aus dem Baumarkt als Achse.
Um die Achse vor dem Herausfallen zu sichern, habe ich diese Endkappen gedruckt und aufgeschoben.

-----

These are simple end caps for wood axles.
I made them in order to secure the axle of my spool holder.

Enjoy, have fun remixing and let me know when you've made one, and what for!

// Version 2 - 2017-09-07
//
// 
// License: CC-BY-SA
// read all about it here: http://creativecommons.org/licenses/by-sa/4.0/
// ********************** */

/* [cap size] */
// Length of the cap || Länge der Kappe
height = 8;	 

// The inner diameter of the cap corresponds to the outer diameter of your axle || Der innere Durchmesser der Kappe entspricht dem Durchmesser deines Rundholzes
innerDia = 8.3; 

// The thickness of the cap's wall || Die Wandstärke der Kappe
wall = 1.5; 

/* [Hidden] */
$fn=100;
outerDia = innerDia + 2*wall;
ix=0.005;	// This is just some static value to beautify the cutout

difference(){
cylinder(d=outerDia, h=height);
	translate([0, 0, wall])
cylinder(d=innerDia,h=height-wall+ix);
}