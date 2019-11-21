/* [Global] */

//Shelf or table thicknes
a=50;

//hock height
b=24;

//depth
l=43;

//horizontal thickness
ht=3.5;

//vertical thickness
vt=2.5;

/* [Hidden] */

// width (messing with that beaks things atm)
w=15;

$fa=6;

rotate([90,0,0])
union() {
  union() {
    cube([l,w,vt]);
    translate([l-ht,0,-a]) cube([ht,w,a]);
  }

  translate([0,w/2,+vt-0.5]) rotate([0,90,0]) cylinder(l,2,2);
  
  union(){
    translate([0,0,-a-vt]) cube([l,w,vt]);
    translate([0,w/2,-a-vt+0.5]) rotate([0,90,0]) cylinder(l,2,2);
  }

  translate([0,0,-a-b-7.5]) cube([ht,w,b+7.5]);

  translate([l,2,vt]) rotate([0,180,0]) cylinder(a+2*vt,2,2);
  translate([l,w-2,vt]) rotate([0,180,0]) cylinder(a+2*vt,2,2);

  translate([0,2,-a]) rotate([0,180,0]) cylinder(b+2*vt+2,2,2);
  translate([0,w-2,-a]) rotate([0,180,0]) cylinder(b+2*vt+2,2,2);


  difference() {
    translate([0,7.5,-a-b-vt-vt-8])
    rotate([0,90,0]) cylinder(l,10,12);

    translate([-.5,-5,-a-b-vt-vt-8-12.5]) cube([l+1,25,18]);

    translate([-.5,-5,-a-b-vt-vt-8]) cube([l+1,5,10]);

    translate([-.5,w,-a-b-vt-vt-8]) cube([l+1,5,10]);
  }
}