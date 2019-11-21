// Pot ot partition?
make = "pot"; // [pot, partition]

// Diameter at the bottom 
base = 50;
// Diameter at the top
top = 80;

// Height of the medium
ht = 25;
// Height if the reservoir
res  = 25;

// Thickness of the wall
wall = 2;
// Thickness of the floor and partition
floors = 2;
// Diameter of the internal tube
tube = 20;
// Fit tolerance to accomodate the partition inside the tube
tol = 1;
// Diameter of the spout
spout = 30;
// Grating hole diameter
gdia = 3;
// Grating hole pitch
gpitch = 6;

$fn = 60;

function radius_at(z) =  (top*z/(ht+res) + base*(1-z/(ht+res)))/2;
module pot_solid(offset) {
    translate([0,0,res]) cylinder(r1=radius_at(res)-offset, r2=top/2-offset, h=ht);
}
module pot() {
    difference() {
        pot_solid(0);
        pot_solid(wall);
    }
}
module reservoir_solid(offset) {
    union () {
        cylinder(r1=base/2 - offset, r2=radius_at(res) - offset, h=res);
        translate([-radius_at(res/2)+wall/2,0,res/2+offset]) 
            cylinder(r1=0, r2=spout/2 - offset, h=res/2);
    }
}

module reservoir() {
    difference() {
        reservoir_solid(0);
        reservoir_solid(wall);
    }
}

module side_grating() {
    n = floor(PI*tube/2/gpitch);
    angle = 180/n;
    nh = floor(res/gpitch);
    for (j = [1:nh]) {
        translate([0,0,(j-1)*gpitch])
        for (i = [1:n]) {
            rotate([0,0,(i-1)*angle + (j%2)*angle/2]) rotate([90,0,0]) translate([0,0,-tube]) cylinder(r=gdia/2, h=2*tube, $fn=6);
        }
    }
}

module floor_grating() {
    d = radius_at(res+floors);
    for (x = [-d:gpitch:d]) {
        for (y = [-d:gpitch:d]) {
            translate([x,y,0]) cylinder(r=gdia/2, h=floors,$fn=6);
        }
    }
}
module partition() {
    difference() {
        cylinder(r1=radius_at(res), r2 = radius_at(res+floors), h=floors);
        //cylinder(r=tube/2,h=floors);
        floor_grating();
    }
}
module wick() {
    difference () {
        cylinder(r=tube/2, h=res);
        cylinder(r=tube/2-wall, h=res);
        side_grating();
    }
}

module full_pot() {
    union() {
        cylinder(r=base/2,h=floors);
        translate([0,0,floors]) union () {
            reservoir();
            wick();
            pot();
        }
    }
}

module full_partition() {
    difference () {
        union () {
            translate([0,0,floors]) rotate([180,0,0]) partition();
            cylinder(r=tube/2-wall-tol, h=res/3);
        }
        translate([0,0,-res/3]) cylinder(r=tube/2-wall-tol-wall, h=res);
    }
}

if (make == "pot") {
    difference () {
        full_pot();
        //translate([-top,0,0]) cube([top,top,top]);
    }
} else {
    full_partition();
}

        
        
