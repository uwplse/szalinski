//height
a=5;
//internal radius of holder
b=37/2;
//radius of grabbers
c=7;
//thickness
t=4;

difference(){
hull(){
cylinder(h=a, r=b+t, center=true, $fn=100);
translate([b+t,0,0])cylinder(h=a, r=c, center=true, $fn=100);
rotate([0,0,120])translate([b+t,0,0])cylinder(h=a, r=c, center=true, $fn=100);
rotate([0,0,240])translate([b+t,0,0])cylinder(h=a, r=c, center=true, $fn=100);
}
cylinder(h=a+1, r=b, center=true, $fn=100);
}