l=200;
w=150;
h=15;
r=4.75;
x=15;
y=15;

$fn=100;

union(){
union(){
union(){
union(){
difference(){
cube(size=[l,w,h],center=true);
translate([75,0,0])cylinder(h+1,r,r,center=true);
}
translate([92.5,67.5,-14])cube(size=[x,y,h],center=true);
translate([92.5,-67.5,-14])cube(size=[x,y,h],center=true);
translate([-92.5,67.5,-14])cube(size=[x,y,h],center=true);
translate([-92.5,-67.5,-14])cube(size=[x,y,h],center=true);
}
}
}
}
