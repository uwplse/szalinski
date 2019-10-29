$fn=50;
union(){
    union(){
        translate([3,3,0])cube([66,66,1]);
        translate([0,0,1.5])for(i = [1 : 1 : 8])for(j = [1 : 1 : 8])    translate([i*8,j*8,0])cube([5,5,3], center=true);
        }
    translate([33+3,1.5+3,0])cylinder(d=2,h=8);
    translate([33+3+8,1.5+3,0])cylinder(d=2,h=8);
    translate([33+3-8,1.5+3,0])cylinder(d=2,h=8);
    translate([33+3,66-1.5+3,0])cylinder(d=2,h=8);
    translate([33+3+8,66-1.5+3,0])cylinder(d=2,h=8);
    translate([33+3-8,66-1.5+3,0])cylinder(d=2,h=8);
}