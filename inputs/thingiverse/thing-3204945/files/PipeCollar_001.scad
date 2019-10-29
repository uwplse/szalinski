//pipe outside diameter
pod=75; 
//mounting screw diameter
sd=5; 
//mounting screw head profil
shp=0; //[0:cylinder, 1:hex head A, 2:flat head]
//mounting screw head diameter (widest diameter for hex or flat head screw)
shd=9; 
//mounting screw head height
shh=3.75; 
//wall distance (6mm min)
wd=9;

//tolerance
tol=0.2; 
//definition
$fn=50; 
//Part to render
part=0; //[0:All, 1:Part A, 2:Part B]

/////////////

module All() {
    difference() {
        union() {
            cylinder(d=pod+12,h=15,center=true);
            hull() {for(i=[-pod/2-wd+1.5,-pod/2],j=[-1,1]) translate([i,j*(pod/4),0]) cylinder(d=3,h=15,center=true);}
            hull() {for(i=[-1,1],j=[-1,1]) translate([i*7+0.25*pod/2,j*(pod/2+16),0]) cylinder(d=3,h=15,$fn=32,center=true);}
        }
        
        cylinder(d=pod+1+2*tol,h=17,center=true);
        translate([0.25*pod/2,0,0]) cube([0.75,pod+40,17],center=true);
        rotate([0,-90,0]) {cylinder(d=sd+2*tol,h=pod);}
        if (shp==0) {rotate([0,-90,0]) cylinder(d=shd+2*tol,h=pod/2+shh);}
        else if (shp==1) {rotate([90,0,-90]) cylinder(d=shd+2*tol,h=pod/2+shh,$fn=6);}
        else if (shp==2) {
            rotate([0,-90,0]) {
                cylinder(d=shd+2*tol,h=pod/2+0.51+2*tol);
                translate([0,0,pod/2+0.5+2*tol]) cylinder(d1=shd+2*tol,d2=sd+2*tol,h=shh);
            }
        }
        for(i=[-1,1]) translate([0.25*pod/2,i*(pod/2+10),0]) rotate([0,-90,0]) {
            cylinder(d=3.6,h=20,center=true);
            translate([0,0,-9.5]) cylinder(d=6.5,h=4);
            translate([0,0,5]) rotate([0,0,30]) cylinder(d=7,h=4,$fn=6);
        }
    }
}
module PartA() {
    difference() {
        All();
        translate([1.25*pod/2,0,0]) cube([pod,2*pod,17],center=true);
    }
}

module PartB() {
    difference() {
        All();
        translate([-0.75*pod/2,0,0]) cube([pod,2*pod,17],center=true);
    }
}

module Render(a) {
    if(a==0) {
        PartA();
        translate([6,0,0]) PartB();
    }
    else if(a==1) {PartA();}
    else if(a==2) {PartB();}
}
Render(part);
