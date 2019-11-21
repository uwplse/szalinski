// Adjustable cable manager
// Created by: Kurtis Alessi

// Ignore these values
size = 12 / 1; // // Divided by 1 so customizer ignores them
resolution = 150 / 1; // Divided by 1 so customizer ignores them

// How large of a hole is needed?
holeSize = 12;// [3:17]


Hole_Size = holeSize/2.5; 

// How many combined cable managers do you want?
number = 1;

// How large do you want the holder to be?
scaleFactor = 1;



// Module of object for cable holder
module cableHolder() {
    scale([scaleFactor, scaleFactor, scaleFactor]) union() {
        difference() {
            union() {
                sphere(size, $fn=resolution); //$fn is the resolution
                linear_extrude(size / 1.5, scale = .5, $fn=resolution) offset(3) square(size * 1.5, center = true);
            }
            translate([0, size, size - (Hole_Size/1.4)]) rotate([90,0,0]) cylinder(size*2.5, Hole_Size, Hole_Size, $fn=resolution);
            translate([-size * 1.5, -size, -size * 3]) cube([size*3, size*3, size*3]);
        }
    }
}

// ignore variable values
start = 1;
increment = 1;
for (i = [start : increment : number]) {
    translate([i*size*1.25*scaleFactor, 0, 0]) cableHolder();
}