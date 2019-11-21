
$fn=100;


// External Diameter (mm)
D_out=20; // 16

// Internal Diameter (mm)
D_in=16; // 14.5

// Total Height (mm)
H=15; // 13

// Edge Height (mm)
bordure=5;

// Rounded edge
r_edge=4;


// engraving form
engraving="heart"; // [none, heart]


/* [Hidden] */


r_out=D_out/2;
r_in=D_in/2;

rm=min(r_in, H)/2;

rotate([180])
difference() {
 cylinder(r=r_out, h=H, center=true);

 translate([0,0,bordure])
  difference() {
   cylinder(r=r_out+1, h=H, center=true);
   cylinder(r=r_in, h=H, center=true);
 }

 translate([r_in,0,(H/2-(H/2-bordure/2-r_in/2))])
   cylinder(r=rm, h=H-bordure, center=true);

 translate([-r_in,0,(H/2-(H/2-bordure/2-r_in/2))])
   cylinder(r=rm, h=H-bordure, center=true);

 translate([0,0,-(H/2-bordure-r_in/2)])
  rotate([90, 0, 90])
   cylinder(r=rm, h=D_in+1, center=true);

 translate([0, 0, -H/2])
  rounded_bot(D_out,r_edge);

 if (engraving=="heart") {
  translate([0, 0, -H/2-1])
   heart(D_out*1/3, 1+1);
 }
}




module rounded_bot(r=16, d=2) {
 translate([0, 0, d/2])
 difference(){
  translate([0,0,-1])
   cylinder(r=r/2+1, h=d+1, center=true);

  cylinder(r=r/2-d, h=2*d+1, center=true);

  cylinder(r=r+2, h=d+1, center=false);

  rotate_extrude(convexity = r/2)
   translate([r/2-d, 0, 0])
    circle(r = d);
 }
}




module heart(s=5, h=1){
  translate([0, -s/6, h/2])
  rotate([0, 0, -45])
    union () {
      cube([s, s, h], center=true);
      translate([-s/2, 0, 0])
        cylinder(r=s/2, h=h, center=true);
      translate([0, s/2, 0])
        cylinder(r=s/2, h=h, center=true);
    }
}