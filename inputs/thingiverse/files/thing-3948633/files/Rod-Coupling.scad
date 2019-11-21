l=45;
r=8;
r1=4;
r2=2;

$fn=100;

difference(){
difference(){
cylinder(l,r,r,center=true);
translate([0,0,16])cylinder(15,r2,r1,center=true);
translate([0,0,-16])cylinder(15,r1,r2,center=true);
}
}