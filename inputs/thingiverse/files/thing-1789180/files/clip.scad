// durchmesser gewindestange. Absichtlich Knapp bemessen.
bohrung = 8;				// [2:0.1:16]

// Länge der gabelzinken
gabel = 20;				// [8:64]

// Stärke der Schenkel, die die Gabel formen.
wand = 5;				// [1:24]

// Materialstärke Rahmen, worauf Gabel geschoben wird
rahmen = 5.6;				// [2:0.1:16]

// Abmessung in Y-Richtung wenn montiert 
breite = 11;				// [4:32]

// Bohrung über Gabel
boden = 0.5;				// [0:0.1:20]

// diameter of holes for screws. Set to 0 for no holes
schraube = 3.4;				// [0:0.1:8]

// soweit werden Löcher für Schrauben eingerückt.
schraube_zum_rand = 4;			// [0:10]



schraube_radius = schraube/2;
bohrung_radius = bohrung/2;
dach = (breite-bohrung)/2;		
tiefe = wand+rahmen+wand;		// X-Richtung wenn montiert
hoehe = gabel+boden+bohrung+dach;	// Z-Richtung wenn montiert
// zur Verbesserung vom OpenSCAD Preview
little=0.01;				
$fn = 90;

module Wellenbock()  {
	difference()  {
		cube([hoehe, tiefe, breite]);					// Basis Block

		translate([dach+bohrung+boden, wand, -little/2])
		cube([gabel+little/2, rahmen, breite+little]);			// Gabel

		translate([dach+bohrung/2, -little/2, breite/2])
		rotate([-90, 0, 0])
		cylinder(tiefe+little, bohrung_radius, bohrung_radius);		// Bohrung für Welle

		if(schraube) {							// Bohrungen für Befestigungsschrauben
			for (x=[dach+bohrung+boden+schraube_radius+schraube_zum_rand,
			        hoehe-schraube_radius-schraube_zum_rand])  {  
				translate([x, -little/2, breite/2])
				rotate([-90, 0, 0])
				cylinder(tiefe+little, schraube_radius, schraube_radius);
			}
		}
	}
}			

Wellenbock();
