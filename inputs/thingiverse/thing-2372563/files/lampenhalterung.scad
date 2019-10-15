
// requires M3 nut cutouts https://www.thingiverse.com/thing:1802332
// Sorry for not modularizing the code...

include <defaults.scad>;
use <Nut.scad>;
use <Bolt.scad>;
use <M3.scad>;

$fn = 120; 

difference() {
    difference() {
        difference() {
            difference() {
                difference() {
                    difference() {
                        difference() {
                            difference() {
                                union() {
                                    // adjust outer diameter of seatpost clamp here!
                                    translate([0,0,-10]) rotate(a=[0,-17,0]) cylinder(38, 14.95, 14.95);
                                    translate([-8,-11.5,0]) cube(size=[80, 23, 30], center=false);
                                }
                                // Adjust inner diameter of seatpost clamp here! A radius 
                                // of 13.75 did fit my 27.2mm seatpost quite well (Anet A8, high temp, 
                                // slight overextrusion)
                                translate([0,0,-10])  rotate(a=[0,-17,0]) cylinder(45, 13.75, 13.75); 
                            }
                            translate([0,0,-15]) cube(size=[230,230,30], center=true); 
                        }
                        union() {
                            translate([15,-4.5,0]) cube(    size=[80,9.5,4.5]);
                            translate([15, -6.8,1.5]) cube(size=[80,14.0, 4.0]); 
                            translate([63, -6.8,0]) cube(size=[10,14.0, 6.0]); 
                        } 
                    }
                    rotate(a=[0,-17,0]) union() {
                        translate([82,624,-25]) cylinder(100, 615, 615);
                         translate([82,-624,-25]) cylinder(100, 615, 615);
                    }
                }
                translate([80,50,257.5]) rotate(a=[90,0,0]) 
                    cylinder(100,250,250);
            }
            union() {
                translate([40,0,-5]) cylinder(100, 1.6, 1.6); 
                translate([40,0,9]) NutM3(h=30) ;
            }
        }
        rotate(a=[0,-107,0]) union() {
            translate([6,0,-80]) cylinder(80,1.6, 1.6);
            translate([6,0,-102]) cylinder(80,3, 3);
            translate([6,0,-10]) NutM3(h=7) ;
        }
    }
    // adjust the Z value of the translation to make the clamp taller or lower 
    translate([0,0,20])  rotate(a=[0,-17,0]) cylinder(50, 50, 50); 
}