/* [Global] */

size_x = 60; // [30:140]

size_y = 80; // [30:140]

size_z = 30; // [30:140]

wall_thickness = 1.8; // [1.2:Small, 1.8:Normal, 2.4:Thick, 3.0:Extra thick]

object_to_create = 1; // [1:Box, 2:Cover, 3:Both]


/* [Hidden] */

// I am sorry, but comments below are in Dutch...

$fs=0.1;
x=size_x; // afmetingen in de x-, y- en z-richting
y=size_y;
z=size_z;
w=wall_thickness; // wanddikte
h=2.4; // hoogte van het opstaande dekselrandje
gap=0.3; // afstand tussen dooswand en opstaand dekselrandje
r=2*w+gap+0.1; // krommingsstraal van de doosjesribben (r >= 2*w+gap)

// kies uit een van de twee opties: onder of boven
if(object_to_create == 1) maak_doos("onder");
if(object_to_create == 3) translate([-2,0,0]) scale([-1,1,1]) maak_doos("onder");
if(object_to_create >= 2) maak_doos("boven");

/*** hieronder code om het doosje te maken ***/

eps=0.1;

module maak_doos(tag) {
    if(tag=="boven") {
        boven();
    } else {
        onder();
    };
};

module doos(x,y,z,r,w) {
    difference() {
        translate([r,r,r]) minkowski() {
            cube([x-2*r,y-2*r,z-2*r]);
            sphere(r=r);
        };
        translate([r,r,r]) minkowski() {
            cube([x-2*r,y-2*r,z-2*r]);
            sphere(r=r-w);
        };
    };
};

module schroefgat() {
    intersection() {
        translate([2*w+gap+3,2*w+gap+3,eps]) union() {
            difference() {
                cylinder(r=1.2+w,h=z-r-2*w-eps);
                translate([0,0,w-eps]) cylinder(r=1.2,h=z-r-w);
            };  
            translate([-w/2,-(2*w+gap+3-0.1),0]) cube([w,2*w+gap+1.8-0.2,z-r-w-h-gap-eps]);
            translate([-(2*w+gap+3-0.1),-w/2,0]) cube([2*w+gap+1.8-0.2,w,z-r-h-gap-w-eps]);
        };
        translate([r,r,r]) minkowski() {
            cube([x-2*r,y-2*r,z-2*r]);
            sphere(r=r-0.1);
        };
    };
};

module schroefgat2() {
    translate([0,0,-eps]) union() {
        cylinder(r1=1.6,r2=1.6,h=2*w+2*eps);
        cylinder(r1=3+0.9*eps,r2=1.2-0.9*eps,h=2+2*eps);
    };
};

module onder() {
    intersection() {
        difference() {
            translate([r,r,r]) minkowski() {
                cube([x-2*r,y-2*r,z-2*r]);
                sphere(r=r);
            };
            translate([r,r,r]) minkowski() {
                cube([x-2*r,y-2*r,z-2*r]);
                sphere(r=r-w);
            };
        };
        translate([0,0,z-r-w]) mirror([0,0,1]) cube(9999);
    };
    translate([0,0,0]) mirror([0,0,0]) schroefgat();
    translate([x,0,0]) mirror([1,0,0]) schroefgat();
    translate([0,y,0]) mirror([0,1,0]) schroefgat();
    translate([x,y,0]) mirror([1,1,0]) schroefgat();
};

module boven() {
    union() {
        difference() {
            intersection() {
                difference() {
                    translate([r,r,r]) minkowski() {
                        cube([x-2*r,y-2*r,r+w+eps]);
                        sphere(r=r);
                    };
                    difference() {
                        translate([r+gap+w/2,r+gap+w/2,r]) minkowski() {
                            cube([x-2*r-2*gap-w,y-2*r-2*gap-w,r+w+eps]);
                            sphere(r=r-w);
                        };
                        translate([2*w+gap+2,2*w+gap+2,0]) cylinder(r=6,h=2*w);
                        translate([x-(2*w+gap+2),2*w+gap+2,0]) cylinder(r=6,h=2*w);
                        translate([2*w+gap+2,y-(2*w+gap+2),0]) cylinder(r=6,h=2*w);
                        translate([x-(2*w+gap+2),y-(2*w+gap+2),0]) cylinder(r=6,h=2*w);
                    };
                };
                translate([0,0,r+w]) mirror([0,0,1]) cube(9999);
            };
            translate([2*w+gap+3,2*w+gap+3,0]) mirror([0,0,0]) schroefgat2();
            translate([x-(2*w+gap+3),2*w+gap+3,0]) mirror([1,0,0]) schroefgat2();
            translate([2*w+gap+3,y-(2*w+gap+3),0]) mirror([0,1,0]) schroefgat2();
            translate([x-(2*w+gap+3),y-(2*w+gap+3),0]) mirror([1,1,0]) schroefgat2();
        };
        intersection() {
            translate([r,r,-r]) difference() {
                minkowski() {
                    cube([x-2*r,y-2*r,3*r+h]);
                    sphere(r=r-w-gap);
                };
                minkowski() {
                    cube([x-2*r,y-2*r,3*r+h]);
                    sphere(r=r-2*w-gap);
                };
            };
            translate([0,0,w-eps]) cube([x,y,h+eps+r]);
        };        
    };        
};


