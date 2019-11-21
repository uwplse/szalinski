
difference(){

translate([0,0,3]){

cube([10,20,6],center=true);}

translate([0,-7.7,3]){
cylinder(h=6.3, r=1.5,$fn=150, center=true);}

translate([0,7.7,3]){

cylinder(h=6.3, r=1.5,$fn=150, center=true);}

translate([0,3.5,3]){

cube([6.5,3.6,6],center=true);}

translate([0,-3.5,3]){

cube([6.5,3.6,6],center=true);}
}