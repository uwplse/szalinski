//$fn=6;
//$fn=9;
//$fn=12;
//$fn=24;
//$fn=100;

// Ecken vom Halter - Corners of the holder
halterecken=6; // [3:100]


// Durchmesser des Lochs für die Kerze oben - Diameter of the hole for the candle above
durchmesserkerzeoben=18.35;

// Durchmesser des Lochs für die Kerze unten - Diameter of the hole for the candle below
durchmesserkerzeunten=18.25;

// Tiefe des Lochs für die Kerze - Depth of the hole for the candle
lochkerze=5;

// Durchmesser vom Halter oben - Diameter of the holder above
durchmesserhalteroben=28;

// Durchmesser vom Halter unten - Diameter of the holder below
durchmesserhalterunten=50;

// Höhe vom Halter - Height from holder
halterhoehe=30;

// Ringe - rings ?
halterrige=1; // [1:ja - yes,0:nein - no]


translate([0,0,0]) staender(durchmesserhalterunten,durchmesserhalteroben,halterhoehe,halterrige,halterecken);


/*
translate([0,0,0]) staender(50,25,50,0,16);

translate([0,28,0]) staender(15,25,30,0,32);
translate([28,0,0]) staender(15,25,30,0,32);
translate([-28,0,0]) staender(15,25,30,0,32);
translate([0,-28,0]) staender(15,25,30,0,32);

translate([0,50,0]) staender(45,40,10,1,16);
translate([50,0,0]) staender(45,40,10,1,16);
translate([-50,0,0]) staender(45,40,10,1,16);
translate([0,-50,0]) staender(45,40,10,1,16);
*/
/*
FAV
translate([-50,14,0]) staender(35,25,30,0);
translate([-74,0,0]) staender(35,25,20,0);
translate([-50,-14,0]) staender(35,25,40,0);

translate([0,0,0]) staender(45,30);
*/



/*
translate([-50,14,0]) staender(35,25,30,0);
translate([-74,0,0]) staender(35,25,20,0);
translate([-50,-14,0]) staender(35,25,40,0);


translate([0,0,0]) staender(30);
translate([50,0,0]) staender(35);
translate([50,50,0]) staender(45,30);
translate([0,50,0]) staender(45,35);
translate([50,100,0]) staender(40,30,20,0);
translate([0,100,0]) staender(45,35,20,0);
*/

module staender(unten=30, oben=25, hoehe=20, ringe=1, $fn=6) {
translate([0,0,hoehe/2]) {
color("green") {
difference() {
union() {
cylinder(r1=unten/2,r2=oben/2,h=hoehe,center=true);

if(ringe==1) {
translate([0,0,hoehe*0.3]) cylinder(r1=(((unten-oben)*0.25)+oben)/2-1,r2=(((unten-oben)*0.25)+oben)/2+(unten-oben)/6,h=hoehe/4,center=true);

translate([0,0,0]) cylinder(r1=(((unten-oben)*0.5)+oben)/2-1,r2=(((unten-oben)*0.5)+oben)/2+(unten-oben)/6,h=hoehe/4,center=true);

translate([0,0,-hoehe*0.3]) cylinder(r1=(((unten-oben)*0.75)+oben)/2-1,r2=(((unten-oben)*0.75)+oben)/2+(unten-oben)/6,h=hoehe/4,center=true);
}
}
translate([0,0,hoehe/2]) cylinder(r1=durchmesserkerzeunten/2,r2=durchmesserkerzeoben/2,h=lochkerze*2,center=true,$fn=100);
translate([0,0,-lochkerze-1.5]) cylinder(r1=unten/2-2,r2=oben/2-2,h=hoehe,center=true);
}
}
}
}