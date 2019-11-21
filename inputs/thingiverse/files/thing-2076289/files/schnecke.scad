// Hoehe des Schneckenkopfes ueber dem Teilzylinder
modul=1;
// Anzahl der Gaenge (Zaehne) der Schnecke
gangzahl=2;
// Laenge der Schnecke
laenge=15;
// Durchmesser der Mittelbohrung
bohrung=4;
// Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
eingriffswinkel=20;
// Steigungswinkel der Schnecke, entspricht 90 grad minus Schraegungswinkel. Positiver Steigungswinkel = rechtsdrehend.
steigungswinkel=10;
// Komponenten zusammengebaut fuer Konstruktion oder auseinander zum 3D-Druck
zusammen_gebaut=0;

/* Bibliothek fuer Schnecken

Enthaelt die Module
- schnecke(modul, gangzahl, laenge, bohrung, eingriffswinkel=20, steigungswinkel=10, zusammen_gebaut=true)

Autor:		Dr Joerg Janssen
Stand:		6. Januar 2017
Version:	2.0
Lizenz:		Creative Commons - Attribution, Non Commercial, Share Alike

Erlaubte Module nach DIN 780:
0.05 0.06 0.08 0.10 0.12 0.16
0.20 0.25 0.3  0.4  0.5  0.6
0.7  0.8  0.9  1    1.25 1.5
2    2.5  3    4    5    6
8    10   12   16   20   25
32   40   50   60

*/

/* [Hidden] */
pi = 3.14159;
rad = 57.29578;
$fn = 96;

/*	Wandelt 2D-Polarkoordinaten in kartesische um
    Format: radius, phi; phi = Winkel zur x-Achse auf xy-Ebene */
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];

/*	Polarfunktion mit polarwinkel und zwei variablen */
function spirale(a, b, phi) =
	a*phi + b;


/*
Berechnet eine Schnecke
Ein Eingriffswinkel von 30 grad erzeugt metrische Schrauben nach DIN 13
modul = Hoehe des Schneckenkopfes ueber dem Teilzylinder
gangzahl = Anzahl der Gaenge (Zaehne) der Schnecke
laenge = Laenge der Schnecke
bohrung = Durchmesser der Mittelbohrung
eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
steigungswinkel = Steigungswinkel der Schnecke, entspricht 90 grad-Schraegungswinkel. Positiver Steigungswinkel = rechtsdrehend.
zusammen_gebaut = Komponenten zusammengebaut fuer Konstruktion oder auseinander zum 3D-Druck */
module schnecke(modul, gangzahl, laenge, bohrung, eingriffswinkel=20, steigungswinkel, zusammen_gebaut=true){

	// Dimensions-Berechnungen
	c = modul / 6;												// Kopfspiel
	r = modul*gangzahl/(2*sin(steigungswinkel));				// Teilzylinder-Radius
	rf = r - modul - c;											// Fusszylinder-Radius
	a = modul*gangzahl/(90*tan(eingriffswinkel));				// Spiralparameter
	tau_max = 180/gangzahl*tan(eingriffswinkel);				// Winkel von Fuss zu Kopf in der Normalen
	gamma = -rad*laenge/((rf+modul+c)*tan(steigungswinkel));	// Torsionswinkel fuer Extrusion
	
	schritt = tau_max/16;
	
	// Zeichnung
	if (zusammen_gebaut) {
		rotate([0,0,tau_max]){
			linear_extrude(height = laenge, center = false, convexity = 10, twist = gamma){
				difference(){
					union(){
						for(i=[0:1:gangzahl-1]){
							polygon(
								concat(							
									[[0,0]],
									
									// ansteigende Zahnflanke
									[for (tau = [0:schritt:tau_max])
										pol_zu_kart([spirale(a, rf, tau), tau+i*(360/gangzahl)])],
										
									// Zahnkopf
									[for (tau = [tau_max:schritt:180/gangzahl])
										pol_zu_kart([spirale(a, rf, tau_max), tau+i*(360/gangzahl)])],
									
									// absteigende Zahnflanke
									[for (tau = [180/gangzahl:schritt:(180/gangzahl+tau_max)])
										pol_zu_kart([spirale(a, rf, 180/gangzahl+tau_max-tau), tau+i*(360/gangzahl)])]
								)
							);
						}
						circle(rf);
					}
					circle(bohrung/2); // Mittelbohrung
				}
			}
		}
	}
	else {
		intersection(){
			union(){
				translate([1,r*1.5,0]){
					rotate([90,0,90])
						schnecke(modul, gangzahl, laenge, bohrung, eingriffswinkel, steigungswinkel, zusammen_gebaut=true);
				}
				translate([laenge+1,-r*1.5,0]){
					rotate([90,0,-90])
						schnecke(modul, gangzahl, laenge, bohrung, eingriffswinkel, steigungswinkel, zusammen_gebaut=true);
					}
				}
			translate([laenge/2+1,0,(r+modul+1)/2]){
					cube([laenge+2,3*r+2*(r+modul+1),r+modul+1], center = true);
				}
			
		}
	}
}

schnecke(modul, gangzahl, laenge, bohrung, eingriffswinkel, steigungswinkel, zusammen_gebaut);