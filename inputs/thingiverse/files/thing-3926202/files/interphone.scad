// Une Case Pour l'interphone
// les Variable en milimétre

troue_D= 2.54 ; // diametre de troue
troue_H= 1.6 ; // profondeur de troue

//Case de Battrie 
battrieHeight = 17; // Longeur
battrieWidth = 26; // Largeur
battrieDeep = 45; // Profondeur

// HP Position
HP_X=31.874; // Position de Haut-Parleur en axe X
HP_Y=-18.93; // Position de Haut-Parleur en axe Y
HP_Z=23; // Position de Haut-Parleur en axe Z

// translation selon X,Y,Z de Case
X_Case=10.365;
Y_Case=46.004;
Z_Case=1.27;

// Posision de Battrie selon X,Y,Z 
battrie_X=57.142;
battrie_Y=35.974;
battrie_Z=3.3;

module Case_d_interphone(){
module PCB(){
translate([14.478-0.3,-10.16+14,2.5])
cylinder(d=troue_D-0.05, h=troue_H+0.3, center=true, $fn=150);
translate([66.04-0.3,-10.414+14,2.5])
cylinder(d=troue_D-0.05, h=troue_H+0.3, center=true, $fn=150);
translate([66.04-0.3,-42.545+14,2.5])
cylinder(d=troue_D-0.05, h=troue_H+0.3, center=true, $fn=150);
translate([14.605-0.3,-42.545+14,2.5])
cylinder(d=troue_D-0.05, h=troue_H+0.3, center=true, $fn=150);
// poseur de board
translate([10.37,0.5,3.15])
cube([6.05,6.05,0.25]);

translate([56.37,0.5,3.15])
cube([14.05,6.05,0.25]);

translate([10.37,-31.5,3.15])
cube([6.05,6.05,0.25]);

translate([54.47,-31.5,3.15])
cube([16.05,6.05,0.25]);

}

module inside(){

// HP
translate([HP_X,HP_Y,HP_Z])
cylinder(d1=40.5, d2=26, h=4.5, center=true, $fn=150);

// Push Button
translate([61,-39,23.55])    
cylinder(d1=5, d2=3.5, h=4.5, center=true, $fn=150);

translate([X_Case/0.89,-Y_Case/1.07,-Z_Case/0.95])
cube([69.16,49.16,22.73]);

// Battrie Placement
translate([battrie_X,-battrie_Y-0.9,battrie_Z])
cube([battrieWidth,battrieDeep,battrieHeight], center=false);

translate([battrie_X,-battrie_Y+44.469,battrie_Z-0.2])
cube([battrieWidth+0.4,battrieDeep/90,battrieHeight+0.4], center=false);

// SLIDE
translate([11.55,-43.25,-1.2])
cube([73.82,49.90,0.59], centre=false);

// Placement des Lignes
translate([83,-40,3.5])
rotate([0,90,0])
cylinder(d=2 , h=6, center=true, $fn=150);
}

difference(){
translate([X_Case,-Y_Case,-Z_Case])
cube([75,55,25]);
inside();
}

PCB();

// porte de battrie 
translate([battrie_X,-battrie_Y+45.7,battrie_Z])
cube([battrieWidth,battrieDeep/29,battrieHeight], center=false);

translate([battrie_X,-battrie_Y+47,battrie_Z-0.2])
cube([battrieWidth+0.4,battrieDeep/90,battrieHeight+0.4], center=false);

// SLIDE
translate([89,-43.25,-1.2])
cube([73.82,49.90,0.6], centre=false);

translate([61.8,-35,20.35])
cube([20.3,43,1.2]);

// Push
translate([61,-39,21.55])    
cylinder(d1=8.4, d2=3.2, h=6, center=true, $fn=150);

translate([61,-39,23.65])
rotate([90,90,0])
cylinder(r=0.05, h=6, center=true, $fn=150);

module possoire_B(){
// Button possoire
translate([ 58,-42,10.25])
cube([6.05,6.05,5.05]);
translate([ 61,-39,16.25])
cylinder(r=2.5,h=4.5,center=true, $fn=150);

translate([ 61,-39,19.55])    
cylinder(d=11.7 , h=4.5, center=true, $fn=150);
}

difference(){
translate([58,-46,12.82])
cube([26,10.75,6.5]);
possoire_B();
}

// Separer Batterie de HP
translate([54.609,-26.85,3.15])
cube([2.538,33.077,20.2]);
}

color("PaleTurquoise"){
    Case_d_interphone();
}