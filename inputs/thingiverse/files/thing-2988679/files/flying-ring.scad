
// Radius of the ring (half of the print bad size)
size = 100; // [50:400]

// Size of the rounded corner, higher is more rouned.You get a circle if = [size], you get a square with rounded corners if = [ring_width]
corner_size = 80; // [10:400]

// Width of the ring
ring_width = 30; // [10:100]

/* [Hidden] */

$fn=100;

for (i = [0:3]){
    rotate([0,0,90*i])
    arm();
}

module arm() {
    translate([size,size-corner_size,0])
    rotate([90,0,0])
    linear_extrude((size - corner_size)*2) profile();

    translate([size-corner_size,size-corner_size,0])
    intersection(){
        cube(corner_size);
        rotate_extrude()
        translate([corner_size,0,0]) profile();
    }
}


module profile() {
    scale(ring_width/40)
    translate([-40,0,0])
    polygon([[0,0],[40,0],[37,3],[35,2],[30,3],[10,3]]);
}