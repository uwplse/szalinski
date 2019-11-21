$fn = 300;


//RENDERS
//Oberteil_Kuppe ();
//Oberteil_Ausschnitt ()
Oberteil ();
Unterteil ();
Stege ();


OberteilD = 40;
Stopfentiefe = 20;

Stegabstand = 3;
Stegbreite = 0.5;
Steganfang = 3;

BohrungD = 31;
Stegtiefe = 1;
Wandung = 2;

// Beim Rohrinnendurchmesser muss BohrungD+Wandung+Stegtiefe zusammengerechnet werden



module Oberteil_Kuppe () {
    
    difference() {
        translate ([0,0,Stopfentiefe])
        sphere(d=OberteilD);
        cylinder(d=OberteilD, h=Stopfentiefe);
        translate([0,0,-200])
        cylinder(d=200,h=200); // Restekiller für OberteilD
    }
}


module Oberteil_Ausschnitt () {
    difference() {
        translate([0,0,Stopfentiefe])
        sphere(d=BohrungD);
        cylinder(d=BohrungD,h=Stopfentiefe+0,5);
    }
}


module Oberteil () {
    difference() {
        Oberteil_Kuppe();
        Oberteil_Ausschnitt();
    }
}

module Unterteil () {
    difference() {
        cylinder(d=BohrungD+Wandung,h=Stopfentiefe);
        translate ([0,0,-0.5])
        cylinder(d=BohrungD,h=Stopfentiefe+1);
    }
}


module Stege () {
    for(i=[Steganfang:Stegabstand:Stopfentiefe]) {
        translate([0,0,i])
        difference() {
            cylinder(d=BohrungD+Wandung+Stegtiefe,h=Stegbreite);
            translate([0,0,-0.5])
            cylinder(d=BohrungD+Wandung,h=Stegbreite+1);
        }
    }
}

