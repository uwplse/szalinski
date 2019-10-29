$fn=50;

h=30;
d1=73;
d2=d1-5;

module grip(){hull(){translate([d1,0,0])cube([h+5,h,(h-10)/2],center=true);cylinder(h,d1,d1,center=true);}}
module handle(){translate([h+d2,0,-(d2-5)/2])cube([h/2,h,d1],center=true);}
module combined(){hull(){grip();handle();}}
module holder(){difference(){combined();cylinder(100*h,d2,d2,center=true);}}
difference(){holder();translate([d1/1.5,0,-1.75*h])cube([2*h,2.5*d1,2*h],center=true);}