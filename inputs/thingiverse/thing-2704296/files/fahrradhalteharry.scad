d1=40;
d2=20;
w=2; //wall
x=8;

D1=d1/2;
D2=d2/2;

union(){
difference(){
cylinder(d2+w+w,D1+w,D1+w,center=true);
cylinder(d2+w+w+1,D1,D1,center=true);
    translate([-D2-w,0,0])
    cube([d1-x,d1-x,d1+w+w],center=true);
}
translate([D2+D1+w,0,0])
rotate(a=90,v=[1,0,0])
difference(){
cylinder(20,D2+w,D2+w,center=true);
cylinder(21,D2,D2,center=true);
    translate([D2,0,0])
    cube([d2-x,d2-x,21],center=true);
}
difference(){
translate([D1-w,0,0])
cube([(d1+d2)/2,20,d2+w+w],center=true);
    translate([D2+D1+w,0,0])
rotate(a=90,v=[1,0,0])
    cylinder(21,D2,D2,center=true);
    cylinder(d2+w+w+1,D1,D1,center=true);
}
}