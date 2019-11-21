// Kappe für Dauerwellwickler

//Masse fuer den Verschluss
Hoehe=14.4;
Durchmesser_aussen=9.22;
Durchmesser_innen=7.05;
Dicke=Durchmesser_aussen-Durchmesser_innen;
Steg=2.45;
Kuppe=4.5;
$fn=50;

//Masse fuer das Roellchen
Laenge=58;
Durchmesser=5.8;
Oben_Durchmesser=8.7;
Spalt=0.5;

module Kopf () {
cylinder (r=Durchmesser_aussen/2, h=Hoehe-Kuppe);
translate ([0,0,Hoehe-Kuppe]) sphere (r=Durchmesser_aussen/2);
}

module Verschluss () {
difference() {
Kopf();
    cylinder (r=Durchmesser_innen/2, h=Hoehe-Dicke);
    translate ([0,0,Hoehe-Kuppe-Dicke]) sphere (r=Durchmesser_aussen/2-Dicke);
    
    translate ([Dicke/2,-Dicke,Hoehe-Kuppe+Dicke]) cube ([Durchmesser_innen-Dicke-Steg,Durchmesser_innen-Steg,Hoehe+Kuppe]);
    
    translate ([-Dicke-Steg/2,-Dicke,Hoehe-Kuppe+Dicke]) cube ([Durchmesser_innen-Dicke-Steg,Durchmesser_innen-Steg,Hoehe+Kuppe]);

}
}
module Stab() {
cylinder (d=Durchmesser, h=Laenge);
 sphere (d=Durchmesser);
translate ([0,Durchmesser/2,Laenge]) rotate ([90,0.0,0]) cylinder(d=Oben_Durchmesser, h=Durchmesser);
}
module Rolle () {
difference() {
   Stab();
    translate ([-Spalt/2,-Durchmesser-Spalt,-Durchmesser]) cube ([Spalt,Durchmesser*2.5,Laenge+Durchmesser]);
    
    translate ([0,Oben_Durchmesser,Laenge]) rotate ([90,0,0]) cylinder (d=Durchmesser+Spalt, h=Oben_Durchmesser*2);
}
}

module Ring () {
difference() {
cylinder (d=Durchmesser+4, h=Steg);
cylinder (d=Durchmesser+0.5, h=Steg);
}
}
module Haken () {
difference () {
union (){
cube ([Durchmesser/5,Durchmesser/4,Laenge]);
translate ([Durchmesser/4,Durchmesser/4,0]) rotate ([90,0,0]) cylinder (d=Durchmesser/2, h=Durchmesser/4);
}
translate ([Durchmesser/5,0,0]) cube ([Durchmesser/6,Durchmesser/4,7]);
}
}
module Ansicht () {
translate ([0,20,0]) Rolle ();
translate ([0,20,Durchmesser]) rotate ([180,0,0]) Verschluss ();
translate ([0,20,Laenge-Durchmesser]) Ring();
}

//Verschluss();
//translate ([0,20,0]) Rolle ();
//Ring ();
Ansicht();
//Rolle();
//Haken ();