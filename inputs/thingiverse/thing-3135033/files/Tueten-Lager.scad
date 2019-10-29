// -----------------------------------------------------
// Tueten-Lager
//
//  Detlev Ahlgrimm, 10.2018
// -----------------------------------------------------

// inner width
xi=135;     // [20:200]

// inner length
yi=150;     // [20:200]

// inner height
zi=100;     // [20:150]

// rod x/y
rt=3;       // [1:5]

// backlash
spiel=0.25; // [0.1:0.05:1]

// what to render
part=0;     // [0:all together, 1:front/rear, 2:side, 3:bottom, 4:separator, 5:foot, 6:clip]


/* [Hidden] */
$fn=50;

// -----------------------------------------------------
//  Seite/Wand (vorne/hinten)
// -----------------------------------------------------
module Seite_vh(v, mq=true) {
  translate([0, -v.y/2, 0]) 
  union() {
    cube([v.x, v.y, v.y]);                              // unten
    cube([v.y, v.y, v.z]);                              // links
    translate([v.x-v.y, 0, 0]) cube([v.y, v.y, v.z]);   // rechts
    translate([0, 0, v.z-v.y]) cube([v.x, v.y, v.y]);   // oben

    if(mq) {
      translate([0, 0, v.z/2-v.y/2]) cube([v.x, v.y, v.y]);   // mitte z
      k=sqrt((v.z-v.y)/2*(v.z-2*v.y)/2 + (v.x/8*3)*(v.x/8*3));
      a=atan((v.x/8*3) / ((v.z-v.y)/2) );
      translate([v.x/8*2, 0,     v.y/2]) rotate([0,     a, 0]) translate([-v.y/2, 0, 0]) cube([v.y, v.y, k]);
      translate([v.x/8*2, 0, v.z-v.y/2]) rotate([0, 180-a, 0]) translate([-v.y/2, 0, 0]) cube([v.y, v.y, k]);
      translate([v.x/8*6, 0,     v.y/2]) rotate([0,    -a, 0]) translate([-v.y/2, 0, 0]) cube([v.y, v.y, k]);
      translate([v.x/8*6, 0, v.z-v.y/2]) rotate([0, 180+a, 0]) translate([-v.y/2, 0, 0]) cube([v.y, v.y, k]);
    }
  }
}

// -----------------------------------------------------
//  Seite/Wand (links/rechts)
// -----------------------------------------------------
module Seite_lr(v, mq=true) {
  rotate([0, 0, 90]) union() {
    Seite_vh([v.y, v.x, v.z], mq);
    for(y=[v.y/3, v.y/3*2]) {
      for(z=[v.z/2+v.x/2, v.z]) {
        translate([y-v.x*1.5-spiel, -v.x/2, z]) cube([v.x, v.x, v.x]);
        translate([y+v.x*0.5+spiel, -v.x/2, z]) cube([v.x, v.x, v.x]);
      }
    }
  }
}

// -----------------------------------------------------
//  Boden
// -----------------------------------------------------
module Boden(v) {
  rotate([-90, 0, 0]) Seite_vh([v.x, v.z, v.y], mq=false);
  for(l=[1:3]) {
    translate([v.x/4*l-v.z/2, 0, -v.z/2]) cube([v.z, v.y, v.z]);
  }
}

// -----------------------------------------------------
//  Trenn-Element
// -----------------------------------------------------
module Trenner(v) {
  Seite_vh([v.x, v.y, v.z]);
  translate([-2*v.y-2*spiel, -v.y/2+2*spiel,       0]) cube([4*v.y+v.x+4*spiel, v.y-2*spiel, v.y]);
  translate([-2*v.y-2*spiel, -v.y/2+2*spiel, v.z-v.y]) cube([4*v.y+v.x+4*spiel, v.y-2*spiel, v.y]);
  for(z=[-v.y, v.z-2*v.y]) {
    translate([ -2*v.y-2*spiel, -v.y/2+2*spiel, z]) cube([v.y, v.y-2*spiel, 2*v.y]);
    translate([v.x+v.y+2*spiel, -v.y/2+2*spiel, z]) cube([v.y, v.y-2*spiel, 2*v.y]);
  }
}

// -----------------------------------------------------
//  Fuss (bzw. Dreier-Klemme)
// -----------------------------------------------------
module Fuss(wt) {
  difference() {
    cylinder(r=3*wt+2*spiel, h=wt+2+spiel);
    translate([0, 0, 1]) cylinder(r=2, h=2*wt);
    translate([-2*wt-spiel, -2*wt-spiel, 1]) cube([6*wt, 2*wt+3*spiel, 2*wt]);
    translate([-2*wt-spiel, -2*wt-spiel, 1]) cube([2*wt+3*spiel, 6*wt, 2*wt]);
  }
  translate([  wt, -2*wt-spiel, wt+1.5+spiel]) rotate([0, 90, 0]) cylinder(d=1, h=wt/2);
  translate([2*wt,     2*spiel, wt+1.5+spiel]) rotate([0, 90, 0]) cylinder(d=1, h=wt/2);

  translate([    2*spiel, 2*wt, wt+1.5+spiel]) rotate([90, 0, 0]) cylinder(d=1, h=wt/2);
  translate([-2*wt-spiel,   wt, wt+1.5+spiel]) rotate([90, 0, 0]) cylinder(d=1, h=wt/2);
}

// -----------------------------------------------------
//  Klemme
// -----------------------------------------------------
module Klemme(wt) {
  difference() {
    translate([wt/2, wt/2, 0]) cylinder(r=2*wt, h=2*wt+1);
    translate([wt/2, wt/2, 1]) cylinder(r=wt,   h=2*wt+1);
    translate([-wt/2-spiel, -wt/2-spiel, 1]) cube([      4*wt, wt+2*spiel, 2*wt+1]);
    translate([-wt/2-spiel, -wt/2-spiel, 1]) cube([wt+2*spiel,       4*wt, 2*wt+1]);
  }
  translate([    wt*1.7, wt/2+spiel, wt+1.5+spiel]) rotate([  0, 90, 0]) cylinder(d=1, h=wt/2);
  translate([wt/2+spiel,     wt*1.7, wt+1.5+spiel]) rotate([-90,  0, 0]) cylinder(d=1, h=wt/2);
}


if(part==0) {
  translate([    -rt,   -rt/2,    0]) Seite_vh([xi+2*rt, rt, zi+2*rt]);     // vorne
  translate([  -rt/2,       0,    0]) Seite_lr([     rt, yi, zi+2*rt]);     // links
  translate([xi+rt/2,       0,    0]) Seite_lr([     rt, yi, zi+2*rt]);     // rechts
  translate([    -rt, yi+rt/2,    0]) Seite_vh([xi+2*rt, rt, zi+2*rt]);     // hinten
  translate([  spiel,   spiel, rt/2]) Boden([xi-2*spiel, yi-2*spiel, rt]);  // unten

  translate([0,   yi/3, zi+2*rt-zi/2-rt/2]) Trenner([xi, rt, zi/2+1.5*rt]);
  translate([0, yi/3*2, zi+2*rt-zi/2-rt/2]) Trenner([xi, rt, zi/2+1.5*rt]);
  
  translate([   rt,    rt, -1])                     Fuss(rt);
  translate([xi-rt,    rt, -1]) rotate([0, 0,  90]) Fuss(rt);
  translate([   rt, yi-rt, -1]) rotate([0, 0, 270]) Fuss(rt);
  translate([xi-rt, yi-rt, -1]) rotate([0, 0, 180]) Fuss(rt);

  translate([  -rt/2,   -rt/2, zi+2*rt+1]) rotate([180, 0,  90]) Klemme(rt);
  translate([xi+rt/2,   -rt/2, zi+2*rt+1]) rotate([180, 0, 180]) Klemme(rt);
  translate([  -rt/2, yi+rt/2, zi+2*rt+1]) rotate([180, 0,   0]) Klemme(rt);
  translate([xi+rt/2, yi+rt/2, zi+2*rt+1]) rotate([180, 0, 270]) Klemme(rt);
} else if(part==1) {
  translate([0, 0, rt/2]) rotate([-90, 0, 0]) Seite_vh([xi+2*rt, rt, zi+2*rt]);
} else if(part==2) {
  translate([0, 0, rt/2]) rotate([0, 90, 0]) Seite_lr([rt, yi, zi+2*rt]);
} else if(part==3) {
  translate([0, 0, rt/2]) Boden([xi-2*spiel, yi-2*spiel, rt]);
} else if(part==4) {
  translate([0, 0, rt/2]) rotate([-90, 0, 0]) Trenner([xi, rt, zi/2+1.5*rt]);
} else if(part==5) {
  Fuss(rt);
} else if(part==6) {
  Klemme(rt);
}
