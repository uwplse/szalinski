// -----------------------------------------------------
// Tubenquetsche (primaer fuer Zahnpasta-Plastik-Tuben)
//
//  Detlev Ahlgrimm, 24.11.2018
// -----------------------------------------------------

// what to render
part=0;       // [0:assembled, 1:all for printing, 2:body, 3:axis, 4:lock]

// inner length of body
laenge=72;    // [30:1:150]

// inner radius of body
radius=11;    // [5:30]

// wall thickness
ws=1.5;       // [1:0.05:4]

// width of opening
bs=2;         // [1:0.05:4]

// radius axis
ra=5;         // [2:10]

// opening
of=1;         // [0:rectangular / full, 1:rounded]

// rounding
rc=4;         // [0:5]

/* [Hidden] */
$fn=100;
zh=ra*0.866025; // 0.866025=sqrt(3)/2

// -----------------------------------------------------
//  d : Aussendurchmesser
//  h : Hoehe
// -----------------------------------------------------
module Ring(d, h) {
  rotate_extrude() translate([d/2-h/2, 0, 0]) circle(d=h);
}

// -----------------------------------------------------
//  der Wickel-Koerper
// -----------------------------------------------------
module Body() {
  difference() {
    hull() {                                    // der massive Koerper
      //cylinder(r=radius+ws, h=laenge+4*ws);
      //translate([-radius/2, -radius-ws, 0]) cube([radius, 1, laenge+4*ws]);
      translate([0, 0, rc]) Ring((radius+ws)*2, rc*2);      // abgerundet ist es huebscher
      translate([0, 0, laenge+4*ws-rc]) Ring((radius+ws)*2, rc*2);
      translate([-radius/2, -radius-ws+rc, rc]) rotate([0, 90, 0]) cylinder(r=rc, h=radius);
      translate([-radius/2, -radius-ws+rc, laenge+4*ws-rc]) rotate([0, 90, 0]) cylinder(r=rc, h=radius);
    }
    //translate([0, 0, 2*ws]) cylinder(r=radius, h=laenge);               // rund aushoehlen
    hull() {
      translate([0, 0, 2*ws       +rc]) Ring(radius*2, rc*2);      // abgerundet ist es huebscher
      translate([0, 0, 2*ws+laenge-rc]) Ring(radius*2, rc*2);
    }
    if(of==0) {
      translate([-radius/2, 0, 2*ws]) cube([2*radius, 2*radius, laenge]); // seitlich oeffnen
    } else {
      hull() {                                            // auch hier ist rund eigentlich huebscher
        translate([0, 0, 2*ws+radius+2*ws])        rotate([-90, 90, 0]) cylinder(r=radius-ws, h=2*radius);
        translate([0, 0, 2*ws+laenge-radius-2*ws]) rotate([-90, 90, 0]) cylinder(r=radius-ws, h=2*radius);
      }
    }
    translate([-bs/2, -radius-ws-0.1, 2*ws+rc]) cube([bs, 3*ws, laenge-2*rc]);  // Tuben-Quetsch-Schlitz
    translate([0, 0, -0.1]) rotate([0, 0, 0]) cylinder(r=ra+0.3, h=laenge+4*ws+0.2, $fn=6);  // Achsoeffnung
    // Und ja ! .... hier ist bewusst KEINE Drehung um 30 Grad [mehr] (damit die Spitze des Sechsecks oben waere).
    // Das wuerde nur die Chance erhoehen, dass sich das Filament am Ueberhang hochbiegt. Und dann
    // crashed irgendwann die Noozle aus der falschen Richtung dagegen und reisst das Teil vom Bett.
  }
}


// -----------------------------------------------------
//  die blosse Achse
// -----------------------------------------------------
module Axis() {
  cylinder(r=ra, h=2*ws, $fn=6);                                  // vordere Rastung
  translate([0, 0, 2*ws]) cylinder(r=zh, h=3*ws);                 // vorderer frei-dreh-Bereich
  translate([0, 0, 5*ws]) cylinder(r=ra, h=laenge-ws, $fn=6);     // Wickel-Bereich
  translate([0, 0, 4*ws+laenge]) cylinder(r=zh, h=3*ws);          // hinterer frei-dreh-Bereich
  translate([0, 0, 7*ws+laenge]) cylinder(r=ra, h=2*ws, $fn=6);   // Konterstueck-Halterung
}


// -----------------------------------------------------
//  die Achse mit Griff
// -----------------------------------------------------
module Handle() {
  difference() {
    union() {
      rotate([-90, 0, 0]) Axis();
      hull() {                                      // Griff: linker Arm
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(r=ra, h=1, $fn=6);
        translate([-15, -15, 0]) sphere(r=zh);
        //translate([ 15, -15, 0]) sphere(r=zh);
      }
      hull() {                                      // Griff: rechter Arm
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(r=ra, h=1, $fn=6);
        //translate([-15, -15, 0]) sphere(r=zh);
        translate([ 15, -15, 0]) sphere(r=zh);
      }
      hull() {                                      // Griff: links/rechts-Verbinder
        //translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(r=ra, h=1, $fn=6);
        translate([-15, -15, 0]) sphere(r=zh);
        translate([ 15, -15, 0]) sphere(r=zh);
      }
    }
    translate([-bs/2, 6*ws, -zh-0.1]) cube([bs, laenge-5*ws, 2*radius]);  // Wickel-Oeffnung
  }
}


// -----------------------------------------------------
//  Konterstueck
// -----------------------------------------------------
module Lock() {
  difference() {
    //cylinder(r=ra+ws, h=3*ws);
    hull() {
      translate([0, 0,      1]) Ring((ra+ws)*2, 2);
      translate([0, 0, 3*ws-1]) Ring((ra+2*ws)*2, 2);
    }
    translate([0, 0, ws]) cylinder(r1=ra+0.2, r2=ra+0.4, h=2*ws+0.1, $fn=6);
  }
}



if(part==0) {           // Montage-Ansicht
  rotate([0, 0, -90]) translate([0, 0, radius+ws-zh]) {
    translate([0, laenge+4*ws, zh]) rotate([90, 0, 0]) Body();
    translate([0, 0, zh]) rotate([0, 0, 0]) Handle();
    translate([0, laenge+10*ws, zh]) rotate([90, 0, 0]) Lock();
  }
  translate([0, -radius, 0]) linear_extrude(1) text(str("Length of slit@axis: ", laenge-5*ws, "mm"), size=5, valign="top");
} else if(part==1) {    // Druck - alles zusammen
  rotate([0, 0, -90]) {
    translate([0, laenge+4*ws, radius+ws]) rotate([90, 0, 0]) Body();
    translate([2*radius, 0, zh]) Handle();
    translate([4*radius, ra+ws, 0]) Lock();
  }
} else if(part==2) {    // Body
  rotate([0, 0, -90]) translate([0, laenge+4*ws, radius+ws]) rotate([90, 0, 0]) Body();
} else if(part==3) {    // Axis
  rotate([0, 0, -90]) translate([0, 0, zh]) Handle();
} else if(part==4) {    // Lock
  Lock();
}
