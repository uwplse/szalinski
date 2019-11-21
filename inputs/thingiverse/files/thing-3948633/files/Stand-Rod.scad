l=130;
r=4;

$fn=100;

union(){
union(){
union(){
cylinder(l,r,r,center=true);
translate([0,0,72.5])cylinder(15,4,2.5,center=true);
translate([0,0,-72.5])cylinder(15,2.5,4,center=true);
}
}
}