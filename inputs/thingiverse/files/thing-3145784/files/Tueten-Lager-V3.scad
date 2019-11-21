// -----------------------------------------------------
// Tueten-Lager V3
//
//  Detlev Ahlgrimm, 10.2018
// -----------------------------------------------------

/* [Main Parameters] */

// inner width
xi=65;      // [20:100]

// inner length
yi=150;     // [20:200]

// inner height
zi=40;      // [20:150]

// bracing radius
rs=2.0;     // [1:0.1:5]

// wall thinckess
wt=0.90;    // [0:0.05:4]

// wall profile
wp=2;       // [0:none, 1:tubes, 2:hex]

/* [Divider Position] */
y1=50;      // [0:200]
y2=0;       // [0:200]
y3=0;       // [0:200]
y4=0;       // [0:200]
y5=0;       // [0:200]


/* [Floor] */
// type
typ=3;      // [0:none, 1:lines, 2:grid, 3:hex]

// floor height (solid)
fhs=0.25;   // [0:0.05:5]

// floor height (lines, grid and hex)
fh=1.0;     // [0.5:0.5:5]

// floor line width (lines, grid and hex)
fw=3;       // [0.5:0.1:5]

// floor line count X (lines, grid and hex)
fcx=3;      // [1:20]

// floor line count Y (grid only)
fcy=8;      // [1:20]


/* [Label Holder] */
// include label holder
ilh=0;      // [0:false, 1:true]

// label holder width
lx=65;      // [20:100]

// label holder height
lz=40;      // [20:150]


/* [Hidden] */
$fn=100;
fh2=(typ>0) ? max(fh, fhs) : fhs;   // die Hoehe des Bodens
//echo("fh2=", fh2);


// -----------------------------------------------------
//  v   : Vektor mit den inneren Abmessungen
//  r   : Radius der Rundungen
//  fh  : Hoehe des Bodens
//  wt  : Wandstaerke
//
//  bei wp==0 gibts keine oberen Rundungen
//  bei r<=wt gibt es keinerlei Rundungen
//
//  "wp", "fh2", "fcx" und "fw" kommen von "ausserhalb"
// -----------------------------------------------------
module base(v, r, fh, wt) {
  rh=(wp==0 || r<=wt) ? 0 : r;    // bei (wp==0 || r<=wt) gibts keine obere Rundung -> rh=0
  //echo("rh=", rh);
  d=2*r;
  difference() {
    union() {
      translate([-wt, -wt, 0]) cube([v.x+2*wt, v.y+2*wt, v.z+fh-rh]);

      if(wp>0 && r>wt) {  // bedingte Ausfuehrung bringt ggf. mehr Render-Geschwindigkeit
        translate([  0,   0, v.z+fh-rh]) sphere(r=r);  // die oberen Ecken
        translate([v.x,   0, v.z+fh-rh]) sphere(r=r);
        translate([  0, v.y, v.z+fh-rh]) sphere(r=r);
        translate([v.x, v.y, v.z+fh-rh]) sphere(r=r);
      }

      if(r>wt) {
        translate([  0,   0, 0]) cylinder(r=r, h=v.z+fh-rh);  // die senkrechten Eck-Rundungen
        translate([v.x,   0, 0]) cylinder(r=r, h=v.z+fh-rh);
        translate([  0, v.y, 0]) cylinder(r=r, h=v.z+fh-rh);
        translate([v.x, v.y, 0]) cylinder(r=r, h=v.z+fh-rh);

        translate([-0.1,    0, 0]) rotate([  0, 90, 0]) cylinder(r=r, h=v.x+0.2);  // die unteren waagerechten Eck-Rundungen
        translate([-0.1,  v.y, 0]) rotate([  0, 90, 0]) cylinder(r=r, h=v.x+0.2);
        translate([   0, -0.1, 0]) rotate([-90,  0, 0]) cylinder(r=r, h=v.y+0.2);
        translate([ v.x, -0.1, 0]) rotate([-90,  0, 0]) cylinder(r=r, h=v.y+0.2);
      }

      if(wp>0 && r>wt) {
        translate([-0.1,    0, v.z+fh-rh]) rotate([  0, 90, 0]) cylinder(r=r, h=v.x+0.2); // die oberen waagerechten Eck-Rundungen
        translate([-0.1,  v.y, v.z+fh-rh]) rotate([  0, 90, 0]) cylinder(r=r, h=v.x+0.2);
        translate([   0, -0.1, v.z+fh-rh]) rotate([-90,  0, 0]) cylinder(r=r, h=v.y+0.2);
        translate([ v.x, -0.1, v.z+fh-rh]) rotate([-90,  0, 0]) cylinder(r=r, h=v.y+0.2);
      }

      if(wp==1) {
        kx=sqrt(v.x*v.x + (v.z+fh-r)*(v.z+fh-r));
        wx=atan(v.x/(v.z+fh-r));
        translate([  0,   0, 0]) rotate([0,  wx, 0]) cylinder(r=r, h=kx);   // Querstreben vorne/hinten
        translate([v.x,   0, 0]) rotate([0, -wx, 0]) cylinder(r=r, h=kx);
        translate([  0, v.y, 0]) rotate([0,  wx, 0]) cylinder(r=r, h=kx);
        translate([v.x, v.y, 0]) rotate([0, -wx, 0]) cylinder(r=r, h=kx);
        ky=sqrt(v.y*v.y + (v.z+fh-r)*(v.z+fh-r));
        wy=atan(v.y/(v.z+fh-r));
        translate([  0,   0, 0]) rotate([-wy, 0, 0]) cylinder(r=r, h=ky);   // Querstreben links/rechts
        translate([  0, v.y, 0]) rotate([ wy, 0, 0]) cylinder(r=r, h=ky);
        translate([v.x,   0, 0]) rotate([-wy, 0, 0]) cylinder(r=r, h=ky);
        translate([v.x, v.y, 0]) rotate([ wy, 0, 0]) cylinder(r=r, h=ky);
      } else if(wp==2) {
        translate([  0,   0,         0]) rotate([  0, -90, 0]) HexPattern(v.z+fh2-r,       v.y, r, v.x/(fcx*2), fw/2, true, true);   // Hex-Pattern rundrum
        translate([v.x,   0, v.z+fh2-r]) rotate([  0,  90, 0]) HexPattern(v.z+fh2-r,       v.y, r, v.x/(fcx*2), fw/2, true, true);
        translate([  0,   0,         0]) rotate([ 90,   0, 0]) HexPattern(      v.x, v.z+fh2-r, r, v.x/(fcx*2), fw/2, true, true);
        translate([  0, v.y, v.z+fh2-r]) rotate([-90,   0, 0]) HexPattern(      v.x, v.z+fh2-r, r, v.x/(fcx*2), fw/2, true, true);
      }
    }
    translate([0, 0, -0.1]) cube([v.x, v.y, v.z+fh+0.2]);   // Kiste aushoehlen
    translate([-d, -d, -d]) cube([v.x+2*d, v.y+2*d, d]);    // Boden plan machen
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module AllTogether() {
  base([xi, yi, zi], rs, fh2, wt);

  // den Boden zufuegen
  if(typ==0) {                    // kein Boden bzw. keine Bodenverstaerkung
    // nix
  } else if(typ==1) {             // Linien
    for(x=[1:fcx]) {
      translate([xi/(fcx+1)*x-fw/2, 0, 0]) cube([fw, yi, fh]);
    }
  } else if(typ==2) {           // Raster
    for(x=[1:fcx]) {
      translate([xi/(fcx+1)*x-fw/2, 0, 0]) cube([fw, yi, fh]);
    }
    for(y=[1:fcy]) {
      translate([0, yi/(fcy+1)*y-fw/2, 0]) cube([xi, fw, fh]);
    }
  } else if(typ==3) {           // Hex-Raster
    HexPattern(xi, yi, fh, xi/(fcx*2), fw/2);
  }

  if(fhs>0) {                   // massiver Boden (ggf. zusaetzlich zur Boden-Verstrebung)
    cube([xi, yi, fhs]);
  }

  // die Trennelemente
  kx=sqrt(xi*xi + (zi+fh2-rs)*(zi+fh2-rs));
  wx=atan(xi/(zi+fh2-rs));
  difference() {
    union() {
      for(y=[y1, y2, y3, y4, y5]) {   // Trennelemente
        if(y>0 && y<yi) {
          if(wp>0 && rs>wt) {
            translate([ 0, y-wt/2,         0]) cube([xi, wt, zi+fh2-rs]);
            translate([ 0,      y,         0]) rotate([0,  90, 0]) cylinder(r=rs, h=xi);
            translate([ 0,      y, zi+fh2-rs]) rotate([0,  90, 0]) cylinder(r=rs, h=xi);
          } else {
            translate([ 0, y-wt/2,         0]) cube([xi, wt, zi+fh2]);
          }
          if(wp==1) {
            translate([ 0, y, 0]) rotate([0,  wx, 0]) cylinder(r=rs, h=kx);
            translate([xi, y, 0]) rotate([0, -wx, 0]) cylinder(r=rs, h=kx);
          } else if(wp==2) {
            translate([0, y+wt/2, rs]) rotate([90, 0, 0]) HexPattern(xi, zi+fh2-2*rs, rs, xi/(fcx*2), fw, true, true);
          }
        }
      }
    }
    if(valid_y()) {   // nur ausfuehren, wenn mindestens eine Trennwand eingebaut wurde
      translate([-2*rs, -2*rs, -2*rs]) cube([xi+4*rs, yi+4*rs, 2*rs]);    // Boden plan machen
    }
  }
  if(ilh==1) {
    translate([xi/2-lx/2, -rs-4, 0]) BeschriftungsHalter([lx, rs+4, lz]);
  }
}
//rotate([0, 0, 90]) 
AllTogether();


// -----------------------------------------------------
//    x : Breite
//    y : Laenge
//    z : Hoehe
//    r : Radius der Aussparungen
//    w : Wandstaerke zwischen den Aussparungen
//    i : invertieren (true:Sechseck-Umrandungen, false:Sechsecke)
//    a : anschraegen (bei true)
// -----------------------------------------------------
module HexPattern(x, y, z, r=3, w=1, i=true, a=false) {
  h=r-(r/2*1.732);  // 1.732=sqrt(3)
  dx=3*r+2*w;
  dy=(r-h)+w;
  r1=(a) ? r-(z+0.2) : r;
  intersection() {
    difference() {
      if(i) cube([x, y, z]);
      for(yi=[0:1:y/dy+1]) {
        for(xi=[0:1:x/dx+1]) {
          if((yi%2)==1) {
            translate([xi*dx, yi*dy, -0.1]) cylinder(r1=r1, r2=r, h=z+0.2, $fn=6);
          } else {
            translate([xi*dx+dx/2, yi*dy, -0.1]) cylinder(r1=r1, r2=r, h=z+0.2, $fn=6);
          }
        }
      }
    }
    if(!i) cube([x, y, z]);
  }
}


// -----------------------------------------------------
//  wie cube() - nur abgerundet
// -----------------------------------------------------
module BoxMitAbgerundetenEcken(x, y, z, r=1) {
  hull() {
    translate([  r,   r,   r]) sphere(r=r);
    translate([x-r,   r,   r]) sphere(r=r);
    translate([  r, y-r,   r]) sphere(r=r);
    translate([x-r, y-r,   r]) sphere(r=r);

    translate([  r,   r, z-r]) sphere(r=r);
    translate([x-r,   r, z-r]) sphere(r=r);
    translate([  r, y-r, z-r]) sphere(r=r);
    translate([x-r, y-r, z-r]) sphere(r=r);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module BeschriftungsHalter(v, sr=5, wt=1) {
  difference() {
    BoxMitAbgerundetenEcken(v.x, v.y, v.z);
    translate([sr, -0.1, sr]) cube([v.x-2*sr, v.y+0.2, v.z]);
    translate([wt, wt, wt]) cube([v.x-2*wt, v.y, v.z]);
  }
}


// -----------------------------------------------------
// Liefert einen Vektor mit den Werten von [y1 - y5],
// die groesser 0 und kleiner yi sind.
// -----------------------------------------------------
function valid_y(v=[y1, y2, y3, y4, y5], c=4) = 
    (c<0) ? [] : concat((v[c]<=0 || v[c]>=yi) ? [] : v[c], valid_y(c=c-1));
