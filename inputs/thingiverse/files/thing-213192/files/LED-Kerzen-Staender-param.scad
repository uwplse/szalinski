/* [Main Dimensions] */

// Ecken vom Halter - Corners of the holder
halterecken=12; // [3:100]

// Durchmesser des Lochs fuer die Kerze oben - Diameter of the hole for the candle above
durchmesserkerzeoben=18.35;

// Durchmesser des Lochs fuer die Kerze unten - Diameter of the hole for the candle below
durchmesserkerzeunten=18.25;

// Tiefe des Lochs fuer die Kerze - Depth of the hole for the candle
lochkerze=5;

// Durchmesser vom Halter oben - Diameter of the holder above
durchmesserhalteroben=28;

// Durchmesser vom Halter unten - Diameter of the holder below
durchmesserhalterunten=50;

// Hoehe vom Halter - Height from holder
halterhoehe=30;

// Ringe - rings ?
showringe=1; // [1:ja - yes,0:nein - no]

// Wieviele Halter im Ring - How many holder in the ring ?
halterrige=10; // [3:30]

// Abstand zwischen den Kerzenhaltern im Ring - Offset between Candleholders in the ring
offsethalterrige=20; // [-10:30]

// Grossen Ring zum verbinden - Big ring to connect ?
showbigring=1;

// Durchmesser vom grossen Ring - Diameter of of Big ring ?
durchmesserbigring=12;

/*
// customizer single
translate([0,0,0]) staender(durchmesserhalterunten,durchmesserhalteroben,halterhoehe,showringe,halterecken);
*/


// customizer ring
abstandvondermitte=(durchmesserhalterunten+offsethalterrige)*halterrige/2/PI;
for(i=[0:halterrige]) {
rotate([0,0,360/halterrige*i]) translate([0,abstandvondermitte,0]) staender(durchmesserhalterunten,durchmesserhalteroben,halterhoehe,showringe,halterecken);
}
if(showbigring==1) {
difference() {
rotate_extrude() translate([abstandvondermitte,0,0]) circle(r=durchmesserbigring, $fn=halterecken);
rotate_extrude() translate([abstandvondermitte,0,0]) circle(r=durchmesserbigring-2, $fn=halterecken);
translate([0,0,-(durchmesserbigring+2)]) rotate_extrude() translate([abstandvondermitte-(durchmesserbigring+2),0,0]) square ([(durchmesserbigring+2)*2,(durchmesserbigring+2)], $fn=halterecken);

}
}

/* 
// 9er Set
translate([0,0,0]) staender(50,25,50,0,16);

translate([0,28,0]) staender(15,25,30,0,32);
translate([28,0,0]) staender(15,25,30,0,32);
translate([-28,0,0]) staender(15,25,30,0,32);
translate([0,-28,0]) staender(15,25,30,0,32);

translate([0,54,0]) staender(45,40,10,1,16);
translate([54,0,0]) staender(45,40,10,1,16);
translate([-54,0,0]) staender(45,40,10,1,16);
translate([0,-54,0]) staender(45,40,10,1,16);
*/

/*
// my FAVs
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
