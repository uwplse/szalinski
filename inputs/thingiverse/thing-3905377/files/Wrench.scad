//Number of faces
$fn=6;
//Bolt diameter
d=80;
//Wrench length
h=500;
//Handle length
l=400;
//Handle thickness
t=50;

if (h<=t){t=h;}

module allen(){
    translate([0,0,h-49])cylinder(h=h+t,d=d,center=false);
}
//allen();
module handle(){
    cylinder(h=h,d=d+10,center=false,$fn=100);
}
//handle();
module power(){
    translate([l/2,0,t/2])cube([l,d+10,t],center=true);
}
//power();
module handhold(){
    union(){
        handle();
        power();
    }
}
//handhold();
module wrench(){
    difference(){
        handhold();
        allen();
    }
}
wrench();