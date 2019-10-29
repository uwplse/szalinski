plateoffsetY=-3; // shift the mount to one side if distance to f.e. Servo is needed
plateoffsetZ=3; // move away
armlength=25;

$fn = 50;


module arm(){
    difference() {
        union(){
    hull(){
rotate([90,0,0])cylinder(r=4, h= 15, center=true);
translate([armlength,plateoffsetY,0])rotate([90,0,0])cylinder(r=4, h= 15, center=true);}
}

for (x=[0,armlength]){
    for (y=[-9,-6,0,6,9]) {
        translate([x,x==armlength ? y+plateoffsetY : y,0])rotate([90,0,0])cylinder(r=4.5,h=3.1, center=true);
        }
    translate([x,0,0])rotate([90,0,0])cylinder(d=3.2,h=armlength+10, center=true);
    }
  }
}
module base() {
    difference() {
        union(){
            translate([-8,0,plateoffsetZ])cube([3,35,13], center=true);
    hull(){
    rotate([90,0,0])cylinder(r=4, h= 17, center=true);
    translate([-8,0,plateoffsetZ])cube([3,18,13], center=true);
        } 
    }
    for(a = [-1,1]) {
    translate([0,a*22.5/2,plateoffsetZ])rotate([0,90,0])cylinder(d=3,h=50, center=true);
//    translate([-6+25,a*22.5/2,plateoffsetZ])rotate([0,90,0])cylinder(d=6,h=5, center=true);
    
    translate([0,a*15.5,0])rotate([90,0,0])cylinder(d=6,h=15, center=true);    
    }

    
    translate([0,0,0])rotate([90,0,0])cylinder(d=3.2,h=50, center=true);
}
}
difference(){
    base();
    arm();
}
arm();