// Which one would you like to see?
part = "both"; // [barHolder,foot,both]

// the outer diameter of the vertical tube
vTubeD = 18;

// thickness of material
dMat = 1.5;

// the height in z
h=20;

// the diameter of the horizontal bar
hBarD = 6;

/* [Hidden] */
ff = 1.5;       // Fummelfaktor um die Unterseite glatt zu bekommen
dStange = hBarD + .15;
dInnen = vTubeD+.5; // soll sich leicht drehen koennen
lStange=dInnen+dMat;    // die Laenge des horizontalen Teiles, kann auch groesser gemacht werden

module Stangenhalter(){
    difference(){
        hull() union(){
            // die Huelse um das Standrohr
            cylinder(d=dInnen+dMat*2, h);
            // der Halter fuer die waagerechte Stange
            translate([-lStange/2,dInnen/2+dStange/2,dStange/2+ff]) rotate([0,90,0])
                cylinder(d=dStange+dMat*2, h=lStange);
        }
        // nach dem Erzeugen der Huelle die Loecher abziehen, einmal das Standrohr
        translate([0,0,-.1]) cylinder(d=dInnen, h+.2, $fn=30);
        // und fuer die waagerechte Stange
        translate([-lStange/2-1,dInnen/2+dStange/2,dStange/2+ff]) rotate([0,90,0])
            cylinder(d=dStange, h=lStange+2, $fn=30);
    }
}

// der FussAdapter fuer eine 20er Bohrung
module FussAdapter(){
    height=25;
    difference(){
        union(){
            cylinder(h=height, d=19.4); // soll in ein 20er Loch
            translate([0,0,height-dMat])cylinder(h=dMat, d=22);   // oben einen Rand
        }
        translate([0,0,dMat])cylinder(h=height+.2, d=18.4, $fn=40); // war 18.3
    }
}

if(part=="both" || part=="barHolder"){
    Stangenhalter();
}
if(part=="both" || part=="foot"){
    translate([40,0,0]) FussAdapter();
}