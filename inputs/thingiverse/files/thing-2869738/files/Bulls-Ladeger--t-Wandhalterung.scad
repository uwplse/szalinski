// -----------------------------------------------------
//    Bulls-Ladegeraet-Wandhalterung
//
//  Detlev Ahlgrimm, 04.2018
// -----------------------------------------------------

$fn=100;

// width of the charger
lgb=96;       // [50:200]
// [maximal] depth of the charger
lgt=60;       // [20:200]
// [desired] hight of the charger
lgh=100;      // [50:200]

// wall thickness
ws=2;         // [1:0.1:5]

//#translate([ws, 20, lgh+ws/2]) cube([lgb, 1, 1]);    // Tests
//#translate([ws+5, ws, lgh+ws/2]) cube([1, lgt, 1]);

difference() {    // Bodenplatte
  translate([ws/2, ws/2, 0]) minkowski() {
    cube([lgb+ws, lgt+ws, ws/2]);
    cylinder(d=ws, h=ws/2);
  }
  translate([2*ws+10, -0.1, -0.1]) minkowski() {
    cube([lgb-20-2*ws, lgt-10, ws/2]);
    cylinder(d=ws, h=ws/2+0.2);
  }
}

hull() {    // vorne links
  translate([ws/2, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([ws/2, ws/2, lgh]) sphere(d=ws);
  translate([1.5*ws+10, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([1.5*ws+10, ws/2, lgh]) sphere(d=ws);
}
hull() {    // vorne rechts
  translate([lgb+ws/2-10, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([lgb+ws/2-10, ws/2, lgh]) sphere(d=ws);
  translate([lgb+1.5*ws, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([lgb+1.5*ws, ws/2, lgh]) sphere(d=ws);
}
hull() {    // links
  translate([ws/2, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([ws/2, ws/2, lgh]) sphere(d=ws);
  translate([ws/2, lgt+1.5*ws,   0]) cylinder(d=ws, h=lgh);
  translate([ws/2, lgt+1.5*ws, lgh]) sphere(d=ws);
}
hull() {    // rechts
  translate([lgb+1.5*ws, ws/2,   0]) cylinder(d=ws, h=lgh);
  translate([lgb+1.5*ws, ws/2, lgh]) sphere(d=ws);
  translate([lgb+1.5*ws, lgt+1.5*ws,   0]) cylinder(d=ws, h=lgh);
  translate([lgb+1.5*ws, lgt+1.5*ws, lgh]) sphere(d=ws);
}

difference() {
  hull() {    // hinten
    translate([ws/2, lgt+1.5*ws,   0]) cylinder(d=ws, h=lgh);
    translate([ws/2, lgt+1.5*ws, lgh]) sphere(d=ws);
    translate([lgb+1.5*ws, lgt+1.5*ws,   0]) cylinder(d=ws, h=lgh);
    translate([lgb+1.5*ws, lgt+1.5*ws, lgh]) sphere(d=ws);
  }
  translate([lgb/2+ws, lgt+ws-0.1, lgh-10]) rotate([-90, 0, 0]) cylinder(d=3.5, h=ws+0.2);  // Loch oben
  translate([lgb/2+ws, lgt+ws-0.1, lgh-10]) rotate([-90, 0, 0]) cylinder(d1=6.5, d2=3.5, h=1.1);

  translate([lgb/2+ws, lgt+ws-0.1, ws+10]) rotate([-90, 0, 0]) cylinder(d=3.5, h=ws+0.2);  // Loch unten
  translate([lgb/2+ws, lgt+ws-0.1, ws+10]) rotate([-90, 0, 0]) cylinder(d1=6.5, d2=3.5, h=1.1);
}

for(y=[lgh-10:-20:20]) {
  translate([ 0,  0, y]) rotate([-90, 0, 0]) cylinder(d=ws, h=12);   // Verstaerkung links
  translate([ 0,  0, y]) rotate([0, 90, 0]) cylinder(d=ws, h=12);
  translate([ 0,  0, y]) sphere(d=ws);
  //translate([12,  0, y]) sphere(d=ws);
  translate([ 0, 12, y]) sphere(d=ws);

  translate([lgb+2*ws,     0, y]) rotate([-90, 0, 0]) cylinder(d=ws, h=12);   // Verstaerkung rechts
  translate([lgb+2*ws,     0, y]) rotate([0, -90, 0]) cylinder(d=ws, h=12);
  translate([lgb+2*ws,     0, y]) sphere(d=ws);
  //translate([lgb+2*ws-12,  0, y]) sphere(d=ws);
  translate([lgb+2*ws,    12, y]) sphere(d=ws);
}

translate([1.5*ws+10,   0,   0]) cylinder(d=2*ws, h=lgh);     // noch mehr Verstaerkung
translate([1.5*ws+10,   0, lgh]) sphere(d=2*ws);
translate([lgb+ws/2-10, 0,   0]) cylinder(d=2*ws, h=lgh);
translate([lgb+ws/2-10, 0, lgh]) sphere(d=2*ws);
