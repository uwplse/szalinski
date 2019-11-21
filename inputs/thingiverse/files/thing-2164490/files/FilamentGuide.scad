//Filament guide for MPCNC
// 25mm pipes
D=20.8; // Inner diameter of pipe (conduit)

$fn=50;

difference(){
union(){
    rotate_extrude(convexity = 10)
    translate([8, 0, 0])
    circle(r = 4);

    translate([0,0,-5])
    rotate_extrude(convexity = 10)
    translate([5, 0, 0])
    circle(r = 1);

    difference(){
    translate([0,0,-5])cylinder(d=24,h=5);
     translate([0,0,-6])cylinder(d=10,h=2, center=true);
    }
}
cylinder(d=8,h=20, center=true);
}

translate([0,0,-6]){
     difference(){
        cylinder(d2=24,d1=22, h=1);
        cylinder(d=10, h=20, center=true);
     }
}

translate([5,-7.5,-5])minkowski(){cube([6,15,4]);sphere(d=2, $fn=40);}

translate([11,-7.5,-5])rotate([0,-45,0])minkowski(){cube([21,15,6]);sphere(d=2, $fn=40);}

difference(){
union(){
    difference(){
        union(){
             translate([21.7,-7.5,10.1])minkowski(){cube([25,15,4]);sphere(d=2, $fn=40);}
             translate([55,0,-5])cylinder(d=D,h=19.1);
             translate([55,0,9.1])cylinder(d=D+4,h=5);
             translate([55,0,7.1])cylinder(d2=D+4, d1=D,h=2);
             translate([55,0,-6])cylinder(d2=D, d1=D-2,h=1);
             translate([55,0,-6])cylinder(d2=D, d1=D-2,h=1);
             translate([55,0,14.1])cylinder(d1=D+4, d2=D+2,h=1);
        }
    }
}
translate([55,0,0])cylinder(d=D-6,h=50, center=true);
cube([200,3,13], center=true);
}
