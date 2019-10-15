width = 100;
hole = 30;

difference(){
cube([width,width,10], center=true);
cylinder(h=11, r1 = hole, r2 = hole, center=true);
}