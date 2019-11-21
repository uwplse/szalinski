
/* [Basic] */
// Epaisseur du tableau
board_thickness=14; //[14:50]
// Epaisseur de la cale
wedge_thickness=5; //[5:10]
// Largeur
width=30; //[30:50]
// Longueur
length=80; //[60:100]

/* [Hidden] */
$fn=50;
rayon=5;
vis=5;
appart=1;

include <MCAD/nuts_and_bolts.scad>;

difference() {
  cube([width,width,board_thickness]);
  difference() {
    cube([width,width,board_thickness]);
    translate([0,rayon,0])cube([width,width-2*rayon,board_thickness]);
    translate([rayon,0,0])cube([width-2*rayon,width,board_thickness]);
    translate([rayon,rayon,0]) cylinder(r=rayon, h=board_thickness);
    translate([rayon,width-rayon,0]) cylinder(r=rayon, h=board_thickness);
    translate([width-rayon,rayon,0]) cylinder(r=rayon, h=board_thickness);
    translate([width-rayon,width-rayon,0]) cylinder(r=rayon, h=board_thickness);
  }
  translate([width/2,vis,0]) cylinder(r=2.2,h=board_thickness);
  translate([width/2,width-vis,0]) cylinder(r=2.2,h=board_thickness);
  translate([width/2,vis,9.8]) cylinder(r1=2.15,r2=4.2,h=3.2);
  translate([width/2,width-vis,9.8]) cylinder(r1=2.15,r2=4.2,h=3.2);
  translate([width/2,vis,13]) cylinder(r=4.2,h=board_thickness-13);
  translate([width/2,width-vis,13]) cylinder(r=4.2,h=board_thickness-13);
  translate([width/2,width/2,0]) cylinder(r=5,h=board_thickness);
  translate([width/2,width/2,0]) cylinder(r=7.5,h=9);
}



 rotate([180*appart,0,0]) translate ([0,5*appart,board_thickness+0.2-(board_thickness+wedge_thickness)*appart]) 
  difference() {
    union () {
      cube([length,width,wedge_thickness]);
      intersection() {
        translate([width/2,width/2,-5.4]) cylinder(r=4.7,h=5.4);
        translate([0,0,-5.4]) cube([width/2-0.2,width,5.4]);
      }
    }
    difference() {
      cube([length,width,wedge_thickness]);
      translate([0,rayon,0])cube([length,width-2*rayon,wedge_thickness]);
      translate([rayon,0,0])cube([length-2*rayon,width,wedge_thickness]);
      translate([rayon,rayon,0]) cylinder(r=rayon, h=wedge_thickness);
      translate([rayon,width-rayon,0]) cylinder(r=rayon, h=wedge_thickness);
      translate([length-rayon,rayon,0]) cylinder(r=rayon, h=wedge_thickness);
      translate([length-rayon,width-rayon,0]) cylinder(r=rayon, h=wedge_thickness);
    }
    translate([width/2,width/2,-board_thickness-4]) cylinder(r=2.2,h=board_thickness+wedge_thickness+4);
    translate([width/2,width/2,wedge_thickness-1]) cylinder(r=5.2,h=board_thickness+wedge_thickness+1);
  }

translate([(width)*appart,0,-2*appart]) difference() {
  union() {
      intersection() {
        translate([width/2,width/2,board_thickness-5.2]) cylinder(r=4.8,h=5.4);
        translate([0,0,board_thickness-5.2]) cube([width/2-0.2,width,5.4]);
      }
      translate([width/2,width/2,2]) cylinder(r=4.7,h=board_thickness-7.2);
      translate([width/2,width/2,2]) cylinder(r=7.2,h=6.8);
  }
  translate([width/2,width/2,0]) cylinder(r=2.2,h=board_thickness+wedge_thickness+1);
  translate([width/2,width/2,2])  nutHole(size=4,tolerance=0.15);
}