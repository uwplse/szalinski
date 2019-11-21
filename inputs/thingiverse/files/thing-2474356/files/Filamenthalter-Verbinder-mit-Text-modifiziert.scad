/* [Spacer] */

// fineness($fn)
Feinheit=30; // [30:100]

// width block
Breite_Block = 20.6;

// depth block
Tiefe_Block = 30;

// depth connector
Tiefe_Verbindung = 15;

// height footprint
Hoehe_Grundflaeche = 2;

// distance
Abstand = 63;

// thickness wall
Dicke_Wand = 3;

// height wall
Hoehe_Wand = 15;
Text = "Janbex";

// font
Schriftart="Roboto"; 

// fontsize
Schriftgroesse=5; // [2:25]

// font spacing
Buchstaben_Abstand=1; // [1:0.1:3]

/* [hidden] */
$fn=Feinheit;
    
{
Breite_Verbindung = Abstand-Breite_Block;
}


{
cube([Breite_Block,Tiefe_Block,Hoehe_Grundflaeche]);
translate([Breite_Block+Breite_Verbindung,0,0]) cube([Breite_Block,Tiefe_Block,Hoehe_Grundflaeche]);
translate([Breite_Block,Tiefe_Block/2-Tiefe_Verbindung/2,0]) cube([Breite_Verbindung,Tiefe_Verbindung,Hoehe_Grundflaeche]);
translate([0,0,Hoehe_Grundflaeche]) cube([Dicke_Wand,Tiefe_Block,Hoehe_Wand]);
translate([Breite_Block-Dicke_Wand,0,Hoehe_Grundflaeche]) cube([Dicke_Wand,Tiefe_Block,Hoehe_Wand]);
translate([Breite_Block+Breite_Verbindung,0,Hoehe_Grundflaeche]) cube([Dicke_Wand,Tiefe_Block,Hoehe_Wand]);
translate([Breite_Block+Breite_Verbindung+Breite_Block-Dicke_Wand,0,Hoehe_Grundflaeche]) cube([Dicke_Wand,Tiefe_Block,Hoehe_Wand]);
}
translate([Breite_Block+Breite_Verbindung/2,Tiefe_Block/2,Hoehe_Grundflaeche]) linear_extrude(1) text(Text,size=Schriftgroesse,font=Schriftart,halign="center",valign="center",spacing=Buchstaben_Abstand);