// Wohnwagen Hochbett aus Feldbett
// http://www.thingiverse.com/thing:1393879

Feldbett_Laenge = 191; // [180:220]
Feldbett_Breite = 72; // [50:90]
Feldbett_Hoehe = 42; // [30:50]
Feldbett_Rahmen = 4; // [3:8]
Feldbett_B_Abstand = 3; // [1:10]
Feldbett_L_Abstand = 6; // [1:10]
Rahmen_H_Prozent = 25; // [10:50]
Rahmen_M_Breite = 30; // [50:90]
Rahmen_H_Hoehe = 75; // [50:120]
WoWa_B_Abstand = 10; // [0:50]
WoWa_Hoehe = 150; // [130:190]
WoWa_Laenge = 198; // [180:240]
WoWa_Breite = 100; // [60:140]

bl=10*Feldbett_Laenge;
bb=10*Feldbett_Breite;
bh=10*Feldbett_Hoehe;
br=10*Feldbett_Rahmen;
ba=10*Feldbett_B_Abstand;
bf=10*Feldbett_L_Abstand;
bd = sqrt(bb*bb+bh*bh); // Fuss
bw = asin((bb)/bd); // Winkel

rf=0.01*Rahmen_H_Prozent;
rl=10*Rahmen_M_Breite;
rh=10*Rahmen_H_Hoehe-bh;
wa=10*WoWa_B_Abstand;
wh=10*WoWa_Hoehe;
wl=10*WoWa_Laenge;
wb=10*WoWa_Breite;

translate([0,0,bh+320+rh+150])
rotate([180,0,0])
wowa_hochbett();

module wowa_hochbett() {
color ("green") bett();
color ("red") gestell();
color ("yellow") wowa();
}

module wowa() {
translate([0,-wa,rh+bh])
cube([wl,wb,150]);
translate([0,-wa,rh+bh])
cube([wl,wb-100,320+150]);
translate([0,0,rh+bh-wh])
cube([wl,wb-250,10]);
}

module gestell() {
// Gestell Mitte
translate([0,(bb-rl)/2,0])
translate([(bl-br)/2,-ba-br/2,bh*rf])
cube([br,rl,br]);
translate([0,(bb)/2-ba-br,bh*rf+br])
cube([bl,br,br]);
// Gestell Unten
translate([bf+br,-ba-br/2,bh])
cube([br,br,rh]);
translate([bf+br,bb-ba-br/2,bh])
cube([br,br,rh]);
translate([bl-bf-br,-ba-br/2,bh])
cube([br,br,rh]);
translate([bl-bf-br,bb-ba-br/2,bh])
cube([br,br,rh]);
// Gestell Querstange
translate([bf+br,-ba-br,bh])
cube([br,bb+ba*2,br]);
translate([bl-bf-br,-ba-br,bh])
cube([br,bb+ba*2,br]);
}

module bett() {
// Liegeflaeche
cube ([bl,bb-2*(br+ba),br/2]);
// Bretter
translate([0,-ba*2,0]) 
cube ([br,bb,br]);
translate([bl-br,-ba*2,0]) 
cube ([br,bb,br]);
// Fuesse
translate([bf+br,0,0]) bettfuss();
translate([bl-bf-br,0,0]) bettfuss();
translate([(bl-br)/2,0,0]) bettfuss(0.25);
}

module bettfuss(pl=1) {
// Fuss1
rotate ([-bw,0,0])
translate([0,-ba-br/2,0])
cube([br,br,bd*pl]);
// Fuss2
translate([0,bb-ba*2-br,0])
rotate ([bw,0,0])
cube([br,br,bd*pl]);
}
