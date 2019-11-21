$fn=100;

radius = 10;
height = 6;

difference(){
    cylinder(r=radius,h=height);
 for (a =[0:1:90]){
     rotate(a) translate([0,0,0]) cube([radius,radius,a/20]);
 }
    translate([((-radius/2)+1),((-radius/2)+1),0]) cylinder(r=2.1,h=9);
    translate([-radius,0,0]) cube([radius,radius,radius]);
 }