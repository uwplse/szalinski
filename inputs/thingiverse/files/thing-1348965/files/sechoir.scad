/* [Hidden] */
$fn=50;

/* [Parameters] */
// Cylinder distance from center
a=8;
// Outside diameter
b=12;
// Inside diameter
c=8;
// Height
e=30;   

difference(){
    union(){
        translate([a*sqrt(3)/2,a/2,0]) cylinder(d=b,h=e);
        translate([-a*sqrt(3)/2,a/2,0]) cylinder(d=b,h=e);
        translate([0,-a,0]) cylinder(d=b,h=e);
        translate([-a*sqrt(3)/2,0,0]) cube([a*sqrt(3),(a+b)/2,e]);
        rotate(v=[0,0,1],a=120) translate([-a*sqrt(3)/2,0,0]) cube([a*sqrt(3),(a+b)/2,e]);
        rotate(v=[0,0,1],a=-120) translate([-a*sqrt(3)/2,0,0]) cube([a*sqrt(3),(a+b)/2,e]);   
    };  
    translate([a*sqrt(3)/2,a/2,7]) cylinder(d=c,h=e);
    translate([a*sqrt(3)/2,a/2,e-2]) cylinder(d1=c,d2=c+3,h=3);    
    translate([-a*sqrt(3)/2,a/2,7]) cylinder(d=c,h=e);
    translate([-a*sqrt(3)/2,a/2,e-2]) cylinder(d1=c,d2=c+3,h=3);
    translate([0,-a,-7]) cylinder(d=c,h=e);
    translate([0,-a,-1]) cylinder(d2=c,d1=c+3,h=3);
    translate([0,-a,e-7]) cylinder(d1=c,d2=0,h=3);
};