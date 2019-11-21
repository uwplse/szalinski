// -----------------------------------------------------
// Hotend-Fan-Duct (40x40mm fan)
//
//  Detlev Ahlgrimm, 15.12.2018
// -----------------------------------------------------

// diameter heat sink
dh=22.3;

// height heat sink
hh=26.0;

// clamping length
hl=3.0;

// distance fan / heat sink
dfh=17.0;

// wall thickness
wt=2.0;

// normal / heavy version
hv=0;   // [0:normal, 1:heavy]

/* [Hidden] */
$fn=100;



// -----------------------------------------------------
//
// -----------------------------------------------------
module LuefterTraeger() {
  difference() {
    union() {
      hull() {
        for(xy=[[1.5,1.5], [38.5,1.5], [1.5,38.5], [38.5,38.5]]) {
          translate([-40/2+xy[0], -40/2+xy[1], 0]) cylinder(d=3, h=2);
        }
      }
      translate([0, 0, 0]) cylinder(d1=40, d2=min(dh, hh), h=dfh);
    }
    for(xy=[[4,4], [36,4], [4,36], [36,36]]) {
      translate([-40/2+xy[0], -40/2+xy[1], -0.1]) cylinder(d=3.5, h=2.2);
    }
    translate([0, 0, -0.001]) cylinder(d1=40-2*wt, d2=min(dh, hh)-2*wt, h=dfh+0.002);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module KuehlkoerperKlemme() {
  difference() {
    hull() {
      cylinder(d=dh+2*wt, h=hh);
      translate([-dh/2-wt, 0, hh/2]) rotate([0, -90, 0]) cylinder(d=min(dh, hh), h=2);
    }
    translate([0, 0, -0.1]) cylinder(d=dh, h=hh+0.2);
    translate([hl, -dh, -0.1]) cube([dh, 2*dh, hh+0.2]);
    translate([-dh/2-wt-2-0.1, 0, hh/2]) rotate([0, 90, 0]) cylinder(d=min(dh, hh)-2*wt, h=dh);
  }
}

if(hv==0) {
  //translate([hh/2, 0, dfh+dh/2+2*wt]) rotate([0, -90, 0]) 
  {
    translate([-dfh-dh/2-wt-2, 0, hh/2]) rotate([0, 90, 0]) LuefterTraeger();
    KuehlkoerperKlemme();
  }
}







// -----------------------------------------------------
//  lg : Laenge Gewinde
//  lm : Laenge Mutter
// -----------------------------------------------------
module SchraubeM3(lg=20, lm=3.1) {
  union() {
    cylinder(r=3.1, h=lm, $fn=6);
    translate([0, 0, lm-0.1]) cylinder(d=3.3, h=lg+0.1);
  }
}

if(hv==1) {
  difference() {
    union() {
      hull() {
        cylinder(d=dh+2*wt, h=hh);
        translate([-dh/2-wt, -40/2, 0]) cube([wt, 40, hh]);
      }
      hull() {
        translate([-dh/2-wt, -40/2, 0]) cube([wt, 40, hh]);
        //translate([-dh/2-dfh, -40/2, hh/2-20]) cube([2, 40, 40]);
        for(xy=[[1.5,1.5], [38.5,1.5], [1.5,38.5], [38.5,38.5]]) {
          translate([-dh/2-dfh, -40/2+xy[0], hh/2-20+xy[1]]) rotate([0, 90, 0]) cylinder(d=3, h=2);
        }
      }
    }
    translate([0, 0, -0.1]) cylinder(d=dh, h=hh+0.2);
    translate([hl, -dh, -0.1]) cube([dh, 2*dh, hh+0.2]);

    translate([0, 0, hh/2]) rotate([0, -90, 0]) cylinder(d=min(dh, hh)-2, h=dh+dfh);
    translate([-dh/2-dfh-0.1, 0, hh/2]) rotate([0, 90, 0]) cylinder(d1=37, d2=min(dh, hh)-2, h=dfh-wt);

    for(xy=[[4,4], [36,4], [4,36], [36,36]]) {
      translate([-dh/2+2, -40/2+xy[0], hh/2-20+xy[1]]) rotate([0, -90, 0]) rotate([0, 0, 30]) SchraubeM3(3, dfh);
    }
  }
}
