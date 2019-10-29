a=80; //radius
b=10; //thickness
s=5;
t=1;
x=4.5; //rad of magnet
y=5;//height of mag
z=8;

$fn=50;
difference(){
difference(){
union(){
cube([a,s,b]);
rotate([0,0,90])translate([0,-s,0])cube([a,s,b]);
//outet ring
difference(){
cylinder(r=a, h=b);
cylinder(r=a-s, h=b+1);
}
//inner ring
difference(){
cylinder(r=a-s-t, h=b);
cylinder(r=a-s-t-s, h=b+1);
}
}
// cut 3/4 of cylinder
translate([0,-a-.1,-.5])cube([a,a,b+1]);
translate([-a,-a,-.5])cube([a,a,b+1]);
translate([-a-.1,0,-.5])cube([a,a,b+1]);
translate([0,0,-9.9])cylinder(r=a+1, h=10);
}
translate([a/2,s-1,b/2])rotate([90,0,0])cylinder(r=x, h=y);
}