include <zahnstange_und_ritzel.scad>

/* Parameter */

// Hoehe des Zahnkopfes ueber dem Teilkreis bzw. der Waelzgeraden
modul=1;
// Laenge der Zahnstange
laenge_stange=50;
// Anzahl der Radzaehne
zahnzahl_ritzel=12;
// Hoehe der Zahnstange bis zur Waelzgeraden
hoehe_stange=6;
// Durchmesser der Mittelbohrung des Stirnrads
bohrung_ritzel=3;
// Breite der Zaehne
breite=4;
// Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867. Sollte nicht groesser als 45 grad sein.
eingriffswinkel=20;
// Schraegungswinkel zur Zahnstangen-Querachse; 0 grad = Geradverzahnung
schraegungswinkel=20;
// Komponenten zusammengebaut fuer Konstruktion oder auseinander zum 3D-Druck 
zusammen_gebaut=false;
// Loecher zur Material-/Gewichtsersparnis bzw. Oberflaechenvergoesserung erzeugen, wenn Geometrie erlaubt
optimiert=true;
// Nenndurchmesser der Bohrloecher; Script erzeugt Loecher mit Kerndurchmesser
nenndurchmesser = 3;


/*  Regelgewinde nach DIN 13, Steigungen von M1 bis M45 */
steigung_regelgewinde=[0.25, 0.4, 0.5, 0.7, 0.8, 1, 1, 1.25, 1.25, 1.5, 1.5, 1.75, 1.75, 2, 2, 2, 2, 2.5, 2.5, 2.5, 2.5, 2.5, 3, 3, 3, 3, 3, 3, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 4, 4, 4, 4, 4, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5];

// Berechnung der Dimensionen der Bohrloecher

steigung = steigung_regelgewinde[nenndurchmesser];

profiltiefe = cos(30)*steigung;									// Profil = gleichschenkeliges Dreieck
echo("profiltiefe = ", profiltiefe);

virtdurchmesser = nenndurchmesser + profiltiefe/4;
echo("virtdurchmesser = ", virtdurchmesser);

virtkerndurchmesser = virtdurchmesser-2*profiltiefe;
echo("virtkerndurchmesser = ", virtkerndurchmesser);

kerndurchmesser = virtkerndurchmesser+profiltiefe/3;
echo("kerndurchmesser = ", kerndurchmesser);

abstand = zusammen_gebaut? modul*zahnzahl_ritzel/2 : modul*zahnzahl_ritzel;

// Berechnung fuer Positionen der Bohrloecher
c = modul / 6;												// Kopfspiel
mx = modul/cos(schraegungswinkel);							// Durch Schraegungswinkel verzerrtes modul in x-Richtung
a = 2*mx*tan(eingriffswinkel)+c*tan(eingriffswinkel);		// Flankenbreite
b = pi*mx/2-2*mx*tan(eingriffswinkel);						// Kopfbreite
x = breite*tan(schraegungswinkel);							// Verschiebung der Oberseite in x-Richtung durch Schraegungswinkel
nz = ceil((laenge_stange+abs(2*x))/(pi*mx));						// Anzahl der Zaehne


difference(){
    zahnstange_und_ritzel (modul, laenge_stange, zahnzahl_ritzel, hoehe_stange, bohrung_ritzel, breite, eingriffswinkel, schraegungswinkel, zusammen_gebaut, optimiert);
    
    union(){
    // erste Bohrung            
        translate([abs(x)-pi*mx*(floor(nz/2)-1)-a-b/2+(hoehe_stange-modul)/2,-(hoehe_stange+modul)/2,-0.5]){
            cylinder(h=breite+1, r=kerndurchmesser/2);
        }     
    // zweite Bohrung
        translate([abs(x)-pi*mx*(floor(nz/2)-1)-a-b/2+laenge_stange-(hoehe_stange-modul)/2,-(hoehe_stange+modul)/2,-0.5]){
            cylinder(h=breite+1, r=kerndurchmesser/2);
        }
    }
}
