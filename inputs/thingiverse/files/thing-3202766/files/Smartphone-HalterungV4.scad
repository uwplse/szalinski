// -----------------------------------------------------
// Smartphone-HalterungV4
//
//  Detlev Ahlgrimm, 11.2018
// -----------------------------------------------------

/* [Main parameters] */
outer_radius=40;        // [20:60]
height=100;             // [50:150]
wall_thickness=1;       // [0.5:0.1:4]
angle=26;               // [0:40]
smartphone_deepth=20;   // [5:40]

/* [Hex-Grid parameters] */
start_x=20;             // [0:0.1:40]
start_y=12;             // [0:0.1:40]
radius=10;              // [3:30]
width=1;                // [0.2:0.05:2]

/* [Hidden] */
$fn=100;
c=smartphone_deepth;
a=c*cos(angle);
b=sqrt(c*c-a*a);


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


union() {
  difference() {
    union() {
      difference() {        // aeussere Wand
        cylinder(r=outer_radius, height, $fn=6);
        translate([0, 0, -0.1]) cylinder(r=outer_radius-wall_thickness, height+0.2, $fn=6);
      }
      intersection() {      // Hex-Pattern
        translate([-outer_radius-start_x, -outer_radius-start_y, 0]) HexPatternV2([200, 200, height], radius, width);
        cylinder(r=outer_radius, height, $fn=6);
      }
    }
    // Platz fuer Smartphone schaffen
    translate([-outer_radius-1, -outer_radius*0.866025+2+a, 5]) rotate([-angle, 0, 0]) translate([0, -2*outer_radius, 0]) cube([2*outer_radius+2, 2*outer_radius, 2*height]);
  }
  // Anti-Wegrutsch-Steg
  translate([-outer_radius*0.5, -outer_radius*0.866025+2, 5+b]) rotate([90, 0, 0]) hull() {
    linear_extrude(2) polygon([[0,0], [outer_radius,0], [outer_radius-5,5], [5,5]]);
    translate([0, -2, 1.99]) cube([outer_radius, 2, 0.01]);
  }
}

// Smartphone-Muster draufsetzen
//%translate([-outer_radius-1, -outer_radius*0.866025+2+a, 5]) rotate([-angle, 0, 0]) translate([0, -smartphone_deepth, 0]) cube([2*outer_radius+2, smartphone_deepth, height*1.5]);
