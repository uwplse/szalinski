// Parametric Lamp shade
//thickness of shade
t=1; 
//top radius
tr=55; 
//bottom radius
br=30; 
//screw base height
s=15; 
//length of shade
l=100; 
//height of shade
h=100; 
//angle of shade
a=33; 
$fn=100;


module lampoutline(){
circle(r=2*t);
rotate([0,0,t])square([t,s],center);
translate([0,s,0])rotate([0,0,a])square([t,l],center);
translate([0,s,0])circle(r=t);
translate([-tr,h,0])circle(r=2*t);
}

difference(){
rotate_extrude(angle = 360, convexity = 2) translate([-br,0,0])lampoutline();
    translate([0,0,-s/2])cube([l,l,s], center=true);
}


