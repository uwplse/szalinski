$fs = 0.01*1;
$fa=1*1;

// outer diameter of the pipes
outer_diameter = 25;
// inner diameter of the pipes
inner_diameter = 22;
// length of cylinder going inside pipe
length = 30;
// length of middle cube
middle = 3;
// distance between pipe and cylinder
clearing = 0.2;

part();
rotate([0,180,0]) part();

module part() {
    cube([outer_diameter,outer_diameter,middle], center = true);
    cylinder(h=length+middle/2,r=inner_diameter/2-clearing);
}