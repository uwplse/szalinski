// Hoehe des Zahnkopfes ueber dem Teilkreis
modul=1;
// Anzahl der Radzaehne des Sonnenrads
zahnzahl_sonne=20;
// Anzahl der Radzaehne der Planetenraeder
zahnzahl_planet=10;
// Anzahl Planeten
anzahl_planeten = 5;
// Zahnbreite
breite=5;
// Breite des Randes ab Fusskreis
randbreite=4;
// Durchmesser der Mittelbohrung
bohrung = 4;
// Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867
eingriffswinkel=20;
// Schraegungswinkel zur Rotationsachse; 0 grad = Geradverzahnung
schraegungswinkel=30;
// Zusammen gebaut oder zum Drucken getrennt
zusammen_gebaut = 1; // [0,1]
// Loecher zur Material-/Gewichtsersparnis bzw. Oberflaechenvergoesserung erzeugen, wenn Geometrie erlaubt
optimiert = 1; // [0,1]
// Spiel zwischen Zahnflanken
spiel = 0.1;

/* Bibliothek fuer Planetenraeder fuer Thingiverse Customizer

Enthaelt die Module
stirnrad(modul, zahnzahl, breite, bohrung, eingriffswinkel = 20, schraegungswinkel = 0, optimiert = 1)
pfeilrad(modul, zahnzahl, breite, bohrung, eingriffswinkel = 20, schraegungswinkel = 0, optimiert = 1)
hohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0)
pfeilhohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0)
planetengetriebe(modul, zahnzahl_sonne, zahnzahl_planet, anzahl_planeten, breite, randbreite, bohrung, eingriffswinkel=20, schraegungswinkel=0, zusammen_gebaut=1, optimiert=1)

Autor:		Dr Joerg Janssen
Stand:		25. Mai 2018
Version:	2.1
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

/*	Wandelt Radian in Grad um */
function grad(eingriffswinkel) =  eingriffswinkel*rad;


/*	Wandelt Grad in Radian um */
function radian(eingriffswinkel) = eingriffswinkel/rad;


/*	Wandelt 2D-Polarkoordinaten in kartesische um
    Format: radius, phi; phi = Winkel zur x-Achse auf xy-Ebene */
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];

/*  Wandelt Kugelkoordinaten in kartesische um
    Format: radius, theta, phi; theta = Winkel zu z-Achse, phi = Winkel zur x-Achse auf xy-Ebene */
function kugel_zu_kart(vect) = [
	vect[0]*sin(vect[1])*cos(vect[2]),  
	vect[0]*sin(vect[1])*sin(vect[2]),
	vect[0]*cos(vect[1])
];

/*	Kreisevolventen-Funktion:
    Gibt die Polarkoordinaten einer Kreisevolvente aus
    r = Radius des Grundkreises
    rho = Abrollwinkel in Grad */
function ev(r,rho) = [
	r/cos(rho),
	grad(tan(rho)-radian(rho))
];


/*	prueft, ob eine Zahl gerade ist
	= 1, wenn ja
	= 0, wenn die Zahl nicht gerade ist */
function istgerade(zahl) =
	(zahl == floor(zahl/2)*2) ? 1 : 0;


/*	groesster gemeinsamer Teiler
	nach Euklidischem Algorithmus.
	Sortierung: a muss groesser als b sein */
function ggt(a,b) = 
	a%b == 0 ? b : ggt(b,a%b);

/*  Stirnrad
    modul = Hoehe des Zahnkopfes ueber dem Teilkreis
    zahnzahl = Anzahl der Radzaehne
    breite = Zahnbreite
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
    schraegungswinkel = Schraegungswinkel zur Rotationsachse; 0 grad = Geradverzahnung
	optimiert = Loecher zur Material-/Gewichtsersparnis bzw. Oberflaechenvergoesserung erzeugen, wenn Geometrie erlaubt (= 1, wenn wahr) */
module stirnrad(modul, zahnzahl, breite, bohrung, eingriffswinkel = 20, schraegungswinkel = 0, optimiert = 1) {

	// Dimensions-Berechnungen	
	d = modul * zahnzahl;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schraegungswinkel im Stirnschnitt
	db = d * cos(alpha_stirn);										// Grundkreisdurchmesser
	rb = db / 2;													// Grundkreisradius
	da = (modul <1)? d + modul * 2.2 : d + modul * 2;				// Kopfkreisdurchmesser nach DIN 58400 bzw. DIN 867
	ra = da / 2;													// Kopfkreisradius
	c =  (zahnzahl <3)? 0 : modul/6;								// Kopfspiel
	df = d - 2 * (modul + c);										// Fusskreisdurchmesser
	rf = df / 2;													// Fusskreisradius
	rho_ra = acos(rb/ra);											// maximaler Abrollwinkel;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	rho_r = acos(rb/r);												// Abrollwinkel am Teilkreis;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	phi_r = grad(tan(rho_r)-radian(rho_r));							// Winkel zum Punkt der Evolvente auf Teilkreis
	gamma = rad*breite/(r*tan(90-schraegungswinkel));				// Torsionswinkel fuer Extrusion
	schritt = rho_ra/16;											// Evolvente wird in 16 Stuecke geteilt
    tau = 360/zahnzahl;												// Teilungswinkel
	
	r_loch = (2*rf - bohrung)/8;									// Radius der Loecher fuer Material-/Gewichtsersparnis
	rm = bohrung/2+2*r_loch;										// Abstand der Achsen der Loecher von der Hauptachse
	z_loch = floor(2*pi*rm/(3*r_loch));								// Anzahl der Loecher fuer Material-/Gewichtsersparnis
	
	optimiert = (optimiert && r >= breite*1.5 && d > 2*bohrung);	// ist Optimierung sinnvoll?
   
	// Zeichnung
	union(){
		rotate([0,0,-phi_r-90*(1-spiel)/zahnzahl]){						// Zahn auf x-Achse zentrieren;
																		// macht Ausrichtung mit anderen Raedern einfacher

			linear_extrude(height = breite, twist = gamma){
				difference(){
					union(){
						zahnbreite = (180*(1-spiel))/zahnzahl+2*phi_r;
						circle(rf);										// Fusskreis	
						for (rot = [0:tau:360]){
							rotate (rot){								// "Zahnzahl-mal" kopieren und drehen
								polygon(concat(							// Zahn
									[[0,0]],							// Zahnsegment beginnt und endet im Ursprung
									[for (rho = [0:schritt:rho_ra])		// von null Grad (Grundkreis)
																		// bis maximalen Evolventenwinkel (Kopfkreis)
										pol_zu_kart(ev(rb,rho))],		// Erste Evolventen-Flanke

									[pol_zu_kart(ev(rb,rho_ra))],		// Punkt der Evolvente auf Kopfkreis

									[for (rho = [rho_ra:-schritt:0])	// von maximalen Evolventenwinkel (Kopfkreis)
																		// bis null Grad (Grundkreis)
										pol_zu_kart([ev(rb,rho)[0], zahnbreite-ev(rb,rho)[1]])]
																		// Zweite Evolventen-Flanke
																		// (180*(1-spiel)) statt 180 Grad,
																		// um Spiel an den Flanken zu erlauben
									)
								);
							}
						}
					}			
					circle(r = rm+r_loch*1.49);							// "Bohrung"
				}
			}
		}
		// mit Materialersparnis
		if (optimiert == 1) {
			linear_extrude(height = breite){
				difference(){
						circle(r = (bohrung+r_loch)/2);
						circle(r = bohrung/2);							// Bohrung
					}
				}
			linear_extrude(height = (breite-r_loch/2 < breite*2/3) ? breite*2/3 : breite-r_loch/2){
				difference(){
					circle(r=rm+r_loch*1.51);
					union(){
						circle(r=(bohrung+r_loch)/2);
						for (i = [0:1:z_loch]){
							translate(kugel_zu_kart([rm,90,i*360/z_loch]))
								circle(r = r_loch);
						}
					}
				}
			}
		}
		// ohne Materialersparnis
		else {
			linear_extrude(height = breite){
				difference(){
					circle(r = rm+r_loch*1.51);
					circle(r = bohrung/2);
				}
			}
		}
	}
}

/*  Pfeilrad; verwendet das Modul "stirnrad"
    modul = Hoehe des Zahnkopfes ueber dem Teilkreis
    zahnzahl = Anzahl der Radzaehne
    breite = Zahnbreite
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
    schraegungswinkel = Schraegungswinkel zur Rotationsachse, Standardwert = 0 grad (Geradverzahnung)
	optimiert = Loecher zur Material-/Gewichtsersparnis */
module pfeilrad(modul, zahnzahl, breite, bohrung, eingriffswinkel = 20, schraegungswinkel=0, optimiert=1){
    echo("pfeilrad",optimiert);

	breite = breite/2;
	d = modul * zahnzahl;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	c =  (zahnzahl <3)? 0 : modul/6;								// Kopfspiel

	df = d - 2 * (modul + c);										// Fusskreisdurchmesser
	rf = df / 2;													// Fusskreisradius

	r_loch = (2*rf - bohrung)/8;									// Radius der Loecher fuer Material-/Gewichtsersparnis
	rm = bohrung/2+2*r_loch;										// Abstand der Achsen der Loecher von der Hauptachse
	z_loch = floor(2*pi*rm/(3*r_loch));								// Anzahl der Loecher fuer Material-/Gewichtsersparnis
	
	translate([0,0,breite]){
		union(){
			stirnrad(modul, zahnzahl, breite, 2*(rm+r_loch*1.49), eingriffswinkel, schraegungswinkel, false);		// untere Haelfte
			mirror([0,0,1]){
				stirnrad(modul, zahnzahl, breite, 2*(rm+r_loch*1.49), eingriffswinkel, schraegungswinkel, false);	// obere Haelfte
			}
		}
	}
	// mit Materialersparnis
	if (optimiert == 1 && r >= breite*3 && d > 2*bohrung) {
		linear_extrude(height = breite*2){
			difference(){
					circle(r = (bohrung+r_loch)/2);
					circle(r = bohrung/2);							// Bohrung
				}
			}
		linear_extrude(height = (2*breite-r_loch/2 < 1.33*breite) ? 1.33*breite : 2*breite-r_loch/2){ //breite*4/3
			difference(){
				circle(r=rm+r_loch*1.51);
				union(){
					circle(r=(bohrung+r_loch)/2);
					for (i = [0:1:z_loch]){
						translate(kugel_zu_kart([rm,90,i*360/z_loch]))
							circle(r = r_loch);
					}
				}
			}
		}
	}
	// ohne Materialersparnis
	else {
		linear_extrude(height = breite*2){
			difference(){
				circle(r = rm+r_loch*1.51);
				circle(r = bohrung/2);
			}
		}
	}
}

/*	Hohlrad
    modul = Hoehe des Zahnkopfes ueber dem Teilkreis
    zahnzahl = Anzahl der Radzaehne
    breite = Zahnbreite
	randbreite = Breite des Randes ab Fusskreis
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
    schraegungswinkel = Schraegungswinkel zur Rotationsachse, Standardwert = 0 grad (Geradverzahnung) */
module hohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0) {

	// Dimensions-Berechnungen	
	ha = (zahnzahl >= 20) ? 0.02 * atan((zahnzahl/15)/pi) : 0.6;	// Verkuerzungsfaktor Zahnkopfhoehe
	d = modul * zahnzahl;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schraegungswinkel im Stirnschnitt
	db = d * cos(alpha_stirn);										// Grundkreisdurchmesser
	rb = db / 2;													// Grundkreisradius
	c = modul / 6;													// Kopfspiel
	da = (modul <1)? d + (modul+c) * 2.2 : d + (modul+c) * 2;		// Kopfkreisdurchmesser
	ra = da / 2;													// Kopfkreisradius
	df = d - 2 * modul * ha;										// Fusskreisdurchmesser
	rf = df / 2;													// Fusskreisradius
	rho_ra = acos(rb/ra);											// maximaler Evolventenwinkel;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	rho_r = acos(rb/r);												// Evolventenwinkel am Teilkreis;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	phi_r = grad(tan(rho_r)-radian(rho_r));							// Winkel zum Punkt der Evolvente auf Teilkreis
	gamma = rad*breite/(r*tan(90-schraegungswinkel));				// Torsionswinkel fuer Extrusion
	schritt = rho_ra/16;											// Evolvente wird in 16 Stuecke geteilt
	tau = 360/zahnzahl;												// Teilungswinkel

	// Zeichnung
	rotate([0,0,-phi_r-90*(1+spiel)/zahnzahl])						// Zahn auf x-Achse zentrieren;
																	// macht Ausrichtung mit anderen Raedern einfacher
	linear_extrude(height = breite, twist = gamma){
		difference(){
			circle(r = ra + randbreite);							// Aussenkreis
			union(){
				zahnbreite = (180*(1+spiel))/zahnzahl+2*phi_r;
				circle(rf);											// Fusskreis	
				for (rot = [0:tau:360]){
					rotate (rot) {									// "Zahnzahl-mal" kopieren und drehen
						polygon( concat(
							[[0,0]],
							[for (rho = [0:schritt:rho_ra])			// von null Grad (Grundkreis)
																	// bis maximaler Evolventenwinkel (Kopfkreis)
								pol_zu_kart(ev(rb,rho))],
							[pol_zu_kart(ev(rb,rho_ra))],
							[for (rho = [rho_ra:-schritt:0])		// von maximaler Evolventenwinkel (Kopfkreis)
																	// bis null Grad (Grundkreis)
								pol_zu_kart([ev(rb,rho)[0], zahnbreite-ev(rb,rho)[1]])]
																	// (180*(1+spiel)) statt 180,
																	// um Spiel an den Flanken zu erlauben
							)
						);
					}
				}
			}
		}
	}

	echo("Aussendurchmesser Hohlrad = ", 2*(ra + randbreite));
	
}

/*  Pfeil-Hohlrad; verwendet das Modul "hohlrad"
    modul = Hoehe des Zahnkopfes ueber dem Teilkegel
    zahnzahl = Anzahl der Radzaehne
    breite = Zahnbreite
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
    schraegungswinkel = Schraegungswinkel zur Rotationsachse, Standardwert = 0 grad (Geradverzahnung) */
module pfeilhohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0) {

	breite = breite / 2;
	translate([0,0,breite])
		union(){
		hohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel, schraegungswinkel);		// untere Haelfte
		mirror([0,0,1])
			hohlrad(modul, zahnzahl, breite, randbreite, eingriffswinkel, schraegungswinkel);	// obere Haelfte
	}
}

/*	Planetengetriebe; verwendet die Module "pfeilrad" und "pfeilhohlrad"
    modul = Hoehe des Zahnkopfes ueber dem Teilkegel
    zahnzahl_sonne = Anzahl der Zaehne des Sonnenrads
    zahnzahl_planet = Anzahl der Zaehne eines Planetenrads
    anzahl_planeten = Anzahl der Planetenraeder. Wenn null, rechnet die Funktion die Mindestanzahl aus.
    breite = Zahnbreite
	randbreite = Breite des Randes ab Fusskreis
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
    schraegungswinkel = Schraegungswinkel zur Rotationsachse, Standardwert = 0 grad (Geradverzahnung)
	zusammen_gebaut = 
	optimiert = Loecher zur Material-/Gewichtsersparnis bzw. Oberflaechenvergoesserung erzeugen, wenn Geometrie erlaubt
	zusammen_gebaut = Komponenten zusammengebaut fuer Konstruktion oder auseinander zum 3D-Druck	*/
module planetengetriebe(modul, zahnzahl_sonne, zahnzahl_planet, anzahl_planeten, breite, randbreite, bohrung, eingriffswinkel=20, schraegungswinkel=0, zusammen_gebaut=1, optimiert=1){
 	// Dimensions-Berechnungen
	d_sonne = modul*zahnzahl_sonne;										// Teilkreisdurchmesser Sonne
	d_planet = modul*zahnzahl_planet;									// Teilkreisdurchmesser Planeten
	achsabstand = modul*(zahnzahl_sonne +  zahnzahl_planet) / 2;		// Abstand von Sonnenrad-/Hohlradachse und Planetenachse
	zahnzahl_hohlrad = zahnzahl_sonne + 2*zahnzahl_planet;				// Anzahl der Zaehne des Hohlrades
    d_hohlrad = modul*zahnzahl_hohlrad;									// Teilkreisdurchmesser Hohlrad

	drehen = istgerade(zahnzahl_planet);								// Muss das Sonnenrad gedreht werden?
		
	n_max = floor(180/asin(modul*(zahnzahl_planet)/(modul*(zahnzahl_sonne +  zahnzahl_planet))));
																		// Anzahl Planetenraeder: hoechstens so viele, wie ohne
																		
	// Zeichnung
        echo("planeteng",optimiert);

	rotate([0,0,180/zahnzahl_sonne*drehen])
		pfeilrad (modul, zahnzahl_sonne, breite, bohrung, eingriffswinkel, -schraegungswinkel, optimiert);		// Sonnenrad
	echo("planeteng",optimiert);

	if (zusammen_gebaut==1){
        if(anzahl_planeten==0){
            list = [ for (n=[2 : 1 : n_max]) if ((((zahnzahl_hohlrad+zahnzahl_sonne)/n)==floor((zahnzahl_hohlrad+zahnzahl_sonne)/n))) n];
            anzahl_planeten = list[0];												// Ermittele Anzahl Planetenraeder
            echo("anzahl_planeten", list[0], list[1], list[2]);
            achsabstand = modul*(zahnzahl_sonne + zahnzahl_planet)/2;		// Abstand von Sonnenrad-/Hohlradachse
            for(n=[0:1:anzahl_planeten-1]){
                translate(kugel_zu_kart([achsabstand,90,360/anzahl_planeten*n]))
					rotate([0,0,n*360*d_sonne/d_planet])
						pfeilrad (modul, zahnzahl_planet, breite, bohrung, eingriffswinkel, schraegungswinkel, optimiert);	// Planetenraeder
            }
       }
       else{
        echo("anzahl planeten=", anzahl_planeten);
            achsabstand = modul*(zahnzahl_sonne + zahnzahl_planet)/2;		// Abstand von Sonnenrad-/Hohlradachse
            for(n=[0:1:anzahl_planeten-1]){
                translate(kugel_zu_kart([achsabstand,90,360/anzahl_planeten*n]))
                rotate([0,0,n*360*d_sonne/(d_planet)])
                    pfeilrad (modul, zahnzahl_planet, breite, bohrung, eingriffswinkel, schraegungswinkel ,optimiert);	// Planetenraeder
            }
		}
	}
	else{
		planetenabstand = zahnzahl_hohlrad*modul/2+randbreite+d_planet;	// Abstand Planeten untereinander
		for(i=[-(anzahl_planeten-1):2:(anzahl_planeten-1)]){
			translate([planetenabstand, d_planet*i,0])
				pfeilrad (modul, zahnzahl_planet, breite, bohrung, eingriffswinkel, schraegungswinkel, optimiert);	// Planetenraeder
		}
	}

	pfeilhohlrad (modul, zahnzahl_hohlrad, breite, randbreite, eingriffswinkel, schraegungswinkel); // Hohlrad

}

planetengetriebe(modul, zahnzahl_sonne, zahnzahl_planet, anzahl_planeten, breite, randbreite, bohrung, eingriffswinkel, schraegungswinkel, zusammen_gebaut, optimiert);