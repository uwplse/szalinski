// Resolution of print
$fn = 200;

// Ring size in correspondance to US standard ring sizes
ring_size = 10;

// Thickness of ring: 1 = Thin, 1.5 = Medium, 2 = Thick
thickness = 1.5;

// Set thickness of inner ring cutout: 2 = No cutout, 1.4 = Thin Cutout, 1.1 = Medium cutout, 0.8 = Thick cutout
cutout_thickness = 1.1;

// Set height of inner ring cutout: Small cutout = 5, Medium cutout = 3, Large cutout = 1.5
cutout_height = 3;

// Define color of 3D render (ex. "blue" or "red" or "gold" etc.)
color("gold") final_ring();


// Calculations based on inputs to put into ring extrusion

ring = ring_size * 0.815 + 11.63;

thickness_calc= thickness * (ring/9);


// Extruding ring based on inputs

module ring() {
rotate_extrude()
translate([((ring / 2)+(0.8*ring / 9)),  0])
            scale([0.5 , 1])circle(thickness_calc);
}

module line() {
    rotate_extrude()
    translate([((ring / 2)+(cutout_thickness * ring / 9)),  -0.5 * thickness_calc / cutout_height])
            scale([0.5 , 1])square([thickness_calc, thickness_calc / cutout_height]);
}

module final_ring() {
    difference() {
    ring();
    line();
    }
}