// -----------------------------------------------------
// Ecken-Schutz (nicht fuer die Ecke...sondern fuer das,
//                was ggf. dagegen deppert)
//
//  Detlev Ahlgrimm, 07.2018
// -----------------------------------------------------

$fn=100;

// length side
lng=35;     // [20:1:60]

// height
hgt=10;     // [6:0.5:20]

// wall thickness
ws=2;       // [1:0.1:5]

// ball radius (lng/2+x)
kr=18;      // [10:0.5:35]

// has hole
loch=1;     // [0:false, 1:true]

// has brim
brim=1;   // [0:false, 1:true]


translate([0, 0, lng/sqrt(2)]) rotate([90, 90+45, 0]) 
difference() {
  union() {
    //linear_extrude(hgt+ws) scale([lng+ws, lng+ws, 1]) polygon([[0, 0], [1, 0], [0, 1]]);
    hull() {
      r=2;
      translate([r, r, r]) sphere(r=r);
      translate([r, r, r]) cylinder(r=r, h=hgt+ws-r);
      translate([lng+ws-r, r, r]) sphere(r=r);
      translate([lng+ws-r, r, r]) cylinder(r=r, h=hgt+ws-r);
      translate([r, lng+ws-r, r]) sphere(r=r);
      translate([r, lng+ws-r, r]) cylinder(r=r, h=hgt+ws-r);
    }

    translate([lng/4, lng/4, 0]) difference() {
      translate([0, 0, hgt+ws]) sphere(r=kr);
      translate([0, 0, hgt+ws]) sphere(r=kr-ws);
      translate([-kr, -kr, hgt+ws]) cube([2*kr, 2*kr, kr]);
    }
  }
  translate([ws, ws, ws]) linear_extrude(hgt+ws+1) scale([lng+ws, lng+ws, 1]) polygon([[0, 0], [1, 0], [0, 1]]);
  translate([0, 0, -lng/2]) linear_extrude(lng+hgt+ws)  polygon([[0, lng], [0, lng+2*ws], [lng+2*ws, lng+2*ws], [lng+2*ws, 0], [lng, 0]]);
  
  if(loch) {
    translate([lng/3-3, lng/3-3, -lng]) cube([6, 6, lng]);
    translate([lng/3, lng/3, -1]) cylinder(r=1.5, h=ws+2);
  }
}


if(brim) {
  translate([0, -hgt, 0]) cylinder(r=4, h=0.35);
  translate([-1, -hgt, 0]) cube([2, hgt, 0.35]);
  translate([-sqrt(lng*lng*2)/2+ws/2, -hgt-1, 0]) cube([sqrt(lng*lng*2)-ws, 2, 0.35]);
}
