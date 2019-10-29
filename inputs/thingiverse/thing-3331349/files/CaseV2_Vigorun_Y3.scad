// -----------------------------------------------------
// Case for "Vigorun Y3 Bluetooth Earbuds" V2
//
//  Detlev Ahlgrimm, 31.12.2018
//
//  03.01.2019  V2    konvexe Woelbung zugefuegt, damit der Deckel
//                    leichter aufgesetzt/abgenommen werden kann.
// -----------------------------------------------------

// diameter
dg=27;        // [20:50]

// width
bg=55;        // [20:100]

// length (+dg)
lks=65;       // [20:100]

// wall thickness
ws=1.5;       // [0.5:0.01:2]

// what to render
part=0;       // [0:body+cover, 1:body, 2:cover, 3:debug]

/* [Hidden] */
$fn=50;


// -----------------------------------------------------
//
// -----------------------------------------------------
module MainBody() {
  difference() {
    hull() {                                                            // der aeussere Koerper
      translate([-bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
      translate([ bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
      translate([0, dg/4, dg/2+ws]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      translate([0, dg/4, -dg/2-ws]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      translate([0, -lks, 0]) sphere(d=dg-2*ws);
    }
    hull() {                                                            // innen aushoehlen
      translate([-bg/2+ws, 0, 0]) rotate([0, 90, 0]) cylinder(d=dg, h=bg-2*ws);
      translate([0, dg/4, dg/2]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      translate([0, dg/4, -dg/2]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      translate([0, -lks, 0]) sphere(d=dg-4*ws);
    }
    translate([-bg, dg/4, -dg]) cube([2*bg, dg, 2*dg]);                 // unten aufmachen bzw. Platz fuer Deckel
    translate([0, -lks, 0]) rotate([90, 0, 0]) cylinder(d=dg/3, h=dg);  // oberes Loch

    for(s=[0, 1]) mirror([s, 0, 0]) hull() {                            // Einrasterung fuer den Deckel
      translate([-bg/2-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=4, h=3);
      translate([-bg/2+1, dg/2-3, 0]) rotate([0, 90, 0]) cylinder(d=8, h=1);
    }
    //translate([-100, -100, 0]) cube([200, 200, 20]);    // debug
  }
  for(z=[-1, 1]) for(y=[0, ws, 2*ws, 3*ws]) hull() {                    // Oeffnungs-Markierung
    translate([-bg/5, y, z*(dg/2+ws*1.5)]) sphere(d=ws);
    translate([ bg/5, y, z*(dg/2+ws*1.5)]) sphere(d=ws);
  }
}
//MainBody();


// -----------------------------------------------------
//
// -----------------------------------------------------
module Cover() {
  intersection() {
    difference() {
      hull() {                                                          // der aeussere Koerper
        translate([-bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
        translate([ bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
        translate([0, dg/4, dg/2+ws]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
        translate([0, dg/4, -dg/2-ws]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      }
      hull() {                                                          // innen aushoehlen
        translate([-bg/2+ws, 0, 0]) rotate([0, 90, 0]) cylinder(d=dg, h=bg-2*ws);
        translate([0, dg/4, dg/2]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
        translate([0, dg/4, -dg/2]) scale([(bg-4*ws)/(2*ws), 1, 1]) sphere(d=2*ws);
      }
      translate([-bg/2-2, dg/2+ws/2, -dg/2]) cube([bg+4, 5, dg]);       // plan machen
    }
    translate([-bg, dg/4, -dg/2-3*ws]) cube([2*bg, dg, dg+6*ws]);       // nur den Deckel auswaehlen
  }
  difference() {
    for(s=[0, 1]) mirror([s, 0, 0]) union() {                           // Einrasterung zufuegen
      hull() {
        translate([-bg/2-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=4-0.6, h=5);
        translate([-bg/2+1.3, dg/2-3, 0]) rotate([0, 90, 0]) cylinder(d=8-0.6, h=5);
      }
      hull() {                                                          // Luecke fuellen (bei kleiner "ws")
        translate([-bg/2, dg/2-3, 0]) rotate([0, 90, 0]) cylinder(d=8-0.6, h=5);
        translate([-bg/2+ws, dg/2-3, 0]) rotate([0, 90, 0]) cylinder(d=8, h=0.01);
      }
    }
    translate([-bg, dg/2+ws/2, -dg/2]) cube([2*bg, dg, dg]);            // moegl. Ueberstaende wegschneiden
  }
}
//Cover();


if(part==0) {
  rotate([-90, 0, 0]) translate([0, -dg/4, (dg+2*ws)/2]) MainBody();
  translate([0, -dg-6*ws, 0]) rotate([-90, 0, 0]) translate([0, -dg/2-ws/2, (dg+2*ws)/2]) Cover();
} else if(part==1) {
  rotate([-90, 0, 0]) translate([0, -dg/4, (dg+2*ws)/2]) MainBody();
} else if(part==2) {
  translate([0, -dg-2*ws, 0]) rotate([-90, 0, 0]) translate([0, -dg/2-ws/2, (dg+2*ws)/2]) Cover();
} else if(part==3) {
  difference() {
    union() {
      MainBody();
      translate([0, 0.1, 0]) Cover();
    }
    translate([-bg, -lks-dg/2-ws, 0]) cube([2*bg, lks+dg+2*ws, dg/2+4*ws]);
  }
}

