/*CNC3018 Nutenschuh
20180727 P. de Graaff
*/
//M5 - 5, M6 - 6
Mx=5;             
difference(){
    corpus();                                                                   //Nutenschuh
    if (Mx==5){
        translate([0,0,-20])cylinder(d=4.9,h=50,$fn=50);                        //Bohrung fuer M5-Schraube
        translate([0,0,-5.3])rotate([0,0,30])cylinder(d=9.2,h=3.4,$fn=6);       //Sechskant Loch fuer M5-Mutter
        
    }
    else{
        translate([0,0,-20])cylinder(d=5.6,h=50,$fn=50);                       //Bohrung fuer M&-Schraube
        translate([0,0,-5.6])rotate([0,0,30])cylinder(d=11.8,h=5,$fn=6);       //Sechskant Loch fuer M6-Mutter        
    }
        
}
//T-Nutenschuh 16.6mm lang, ohne Bohrung
module corpus(){
    //obere Fuehrung
    translate([0,0,(4-1.7)/2])cube([8,16.6,4],center=true);
    //Klemmflaeche
    translate([0,0,-1.7])cube([16,16.6,2],center=true);
    //Profil unten
    translate([0,0,-2.7])hull(){
        cube([16,16.6,0.01],center=true);
        translate([0,0,-2.5])cube([11,16.6,0.01],center=true);
    }
}