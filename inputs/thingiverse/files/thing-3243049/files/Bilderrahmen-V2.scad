// -----------------------------------------------------
// Bilderrahmen V2
//
//  Detlev Ahlgrimm, 11.2018
// -----------------------------------------------------

// what to render
part=0;   // [0:assembled, 1:print, 2:frame only, 3:top edge only]

// width of photo
wp=130;   // [70:250]

// height of photo
hp=180;   // [70:250]

// thickness of photo
tp=1;     // [0.5:0.1:3]

// wall thickness
wt=0.8;   // [0.5:0.05:3]

// border thickness
bt=5;     // [1:0.1:10]

// support for opening
iso=0;    // [0:no support, 1:support]

// radius for support
sr=18;    // [10:0.5:30]

// shift for support
ss=0;     // [0:50]


/* [Hidden] */
$fn=100;
inner=[wp, hp, tp];

// -----------------------------------------------------
//    v : Abmessungs-Vektor
//    r : Radius der Aussparungen
//    w : Wandstaerke zwischen den Aussparungen
//    i : invertieren (true:Sechseck-Umrandungen, false:Sechsecke)
//    a : anschraegen 45 Grad (bei true)
// -----------------------------------------------------
module HexPatternV2(v, r=10, w=1, i=true, a=false) {
  dx=r*1.5;
  dy=r*0.866025;      // 0.866025=sqrt(3)/2
  sy=(i) ? -0.1 : 0;
  az=(i) ? 0.2 : 0;
  r1=(a) ? r-w/2-(v.z+0.2) : r-w/2;

  intersection() {
    difference() {
      if(i) cube(v);
      for(yi=[0:1:v.y/dy+1]) {
        for(xi=[0:1:v.x/(2*dx)+1]) {
          if((yi%2)==1) {
            translate([xi*2*dx+dx, yi*dy, sy]) cylinder(r1=r1, r2=r-w/2, h=v.z+az, $fn=6);
          } else {
            translate([xi*2*dx, yi*dy, sy]) cylinder(r1=r1, r2=r-w/2, h=v.z+az, $fn=6);
          }
        }
      }
    }
    if(!i) cube(v);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Frame() {
  rotate([75, 0, 0]) 
  difference() {
    cube([inner.x+2*wt, inner.y+5*wt, inner.z+2*wt]);
    translate([wt, 3*wt, wt]) cube([inner.x, inner.y+3*wt, inner.z]);
    translate([wt+bt, wt+bt, wt+inner.z-0.01]) cube([inner.x-2*bt, inner.y+3*wt, 2*wt]);
    rotate([-75-45, 0, 0]) translate([-0.1, -2*(wt+inner.z), -(wt+inner.z)]) cube([inner.x+2*wt+0.2, 2*(wt+inner.z), wt+inner.z]);
    translate([(inner.x+2*wt)/2, (inner.y+5*wt)/2, -0.1]) scale([(inner.x-20)/2, (inner.y-20)/2, 1]) cylinder(r=1, h=wt+0.2);
  }

  difference() {
    cube([inner.x+2*wt, inner.y/3, wt]);
    translate([(inner.x+2*wt)/2, inner.y/3, -0.1]) scale([1, 0.7, 1]) cylinder(d=inner.x, h=wt+0.2);
  }
  if(iso==1) {
    rotate([75, 0, 0]) intersection() {
      translate([-ss, inner.y+5*wt, 0]) rotate([0, 0, -90]) HexPatternV2([inner.y+5*wt, (inner.x+2*wt)+50, wt-0.01], sr, 4);
      cube([inner.x+2*wt, inner.y+5*wt, inner.z+2*wt]);
    }
  }
  cube([inner.x+2*wt, 1, wt]);

  difference() {
    for(x=[0, inner.x+wt])
      translate([x, 0, 0]) hull() {
        cube([wt, inner.y/3, wt]);
        rotate([75, 0, 0]) cube([wt, inner.y, 0.01]);
      }
    hull() {
      translate([-0.1, inner.y/3, inner.y/6+wt]) rotate([0, 90, 0]) cylinder(r=inner.y/6, h=inner.x+4*wt+0.2);
      translate([-0.1, inner.y/3+inner.y/15, inner.y]) rotate([0, 90, 0]) cylinder(r=inner.y/6, h=inner.x+4*wt+0.2);
    }
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module TopEdge() {
  translate([wt+bt+0.3, 5*wt+inner.y-bt, wt+inner.z-0.2]) cube([inner.x-2*bt-0.6, bt+wt, wt+0.2]);
  translate([3*wt, 3*wt+inner.y, wt+0.1]) cube([inner.x-4*wt, 2*wt, inner.z-0.2]);
  translate([0, inner.y+5*wt+0.1, -wt-0.2]) cube([inner.x+2*wt, wt, inner.z+3*wt+0.2]);
  translate([0, inner.y+wt, -wt-0.2]) cube([inner.x+2*wt, 4*wt+0.2, wt]);
}

if(part==0) {
  Frame();
  rotate([75, 0, 0]) TopEdge();
} else if(part==1) {
  Frame();
  translate([0, -10*wt, 0]) rotate([-90, 0, 0]) translate([0, -(6*wt+inner.y+0.1), wt+0.2]) TopEdge();
} else if(part==2) {
  Frame();
} else if(part==3) {
  translate([0, -10*wt, 0]) rotate([-90, 0, 0]) translate([0, -(5*wt+inner.y+0.1), wt+0.2]) TopEdge();
}
