// -----------------------------------------------------
// Case for "Vigorun Y3 Bluetooth Earbuds"
//
//  Detlev Ahlgrimm, 31.12.2018
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
$fn=100;

// -----------------------------------------------------
//
// -----------------------------------------------------
module MainBody() {
  difference() {
    hull() {                                                            // der aeussere Koerper
      translate([-bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
      translate([ bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
      translate([0, -lks, 0]) sphere(d=dg+2*ws);
    }
    hull() {                                                            // innen aushoehlen
      translate([-bg/2+ws, 0, 0]) rotate([0, 90, 0]) cylinder(d=dg, h=bg-2*ws);
      translate([0, -lks, 0]) sphere(d=dg);
    }
    translate([-bg, dg/4, -dg]) cube([2*bg, dg, 2*dg]);                 // unten aufmachen bzw. Platz fuer Deckel
    translate([0, -lks, 0]) rotate([90, 0, 0]) cylinder(d=dg/3, h=dg);  // oberes Loch

    for(s=[0, 1]) mirror([s, 0, 0]) hull() {                            // Einrasterung fuer den Deckel
      translate([-bg/2-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=4, h=3);
      translate([-bg/2+1, dg/3+ws/2, 0]) rotate([0, 90, 0]) cylinder(d=8, h=1);
    }
    //translate([-100, -100, 0]) cube([200, 200, 20]);    // debug
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Cover() {
  intersection() {
    difference() {
      hull() {                                                          // der aeussere Koerper
        translate([-bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
        translate([ bg/2, 0, 0]) scale([0.2, 1, 1]) sphere(d=dg+2*ws);
      }
      translate([-bg/2+ws, 0, 0]) rotate([0, 90, 0]) cylinder(d=dg, h=bg-2*ws); // innen aushoehlen
      translate([-bg/2-2, dg/2+ws/2, -dg/2]) cube([bg+4, 5, dg]);
    }
    translate([-bg, dg/4, -dg/2]) cube([2*bg, dg, dg]);                 // nur den Deckel auswaehlen
  }
  difference() {
    for(s=[0, 1]) mirror([s, 0, 0]) hull() {                            // Einrasterung zufuegen
      translate([-bg/2-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=4-0.6, h=5);
      translate([-bg/2+1.3, dg/3+ws/2, 0]) rotate([0, 90, 0]) cylinder(d=8-0.6, h=5);
    }
    translate([-bg, dg/2, -dg/2]) cube([2*bg, dg, dg]);                 // moegl. Ueberstaende wegschneiden
  }
}


if(part==0) {
  rotate([-90, 0, 0]) translate([0, -dg/4, (dg+2*ws)/2]) MainBody();
  translate([0, -dg-2*ws, 0]) rotate([-90, 0, 0]) translate([0, -dg/2-ws/2, (dg+2*ws)/2]) Cover();
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
    translate([-bg, -lks-dg/2-ws, 0]) cube([2*bg, lks+dg+2*ws, dg/2+ws]);
  }
}
