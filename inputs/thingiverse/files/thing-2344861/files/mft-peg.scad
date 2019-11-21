/* [Peg customization] */

// Peg's top diameter
peg_top_diameter=30;

// Peg's top height
peg_top_height=10;

// Peg's diameter (Default fits MFT3, adjust if need)
peg_diameter=19.10;

// Peg's depth (Default fits MFT3 height, adjust if needed)
peg_depth=25;


/* [Nuts customization] */

// Nut's outer diameter (default is m6)
nut_diameter=12.30;

// Nut's inner diameter (default is m6)
nut_inner_diameter=6.45;

// Nut's height (default is m6)
nut_height=5.65;

// Depth at which the nut is "sinked" under the peg's top / above the peg's bottom
nut_depth=2;

// M3
//nut_diameter=6.01;
//nut_inner_diameter=3;
//nut_height=2.4;

// M6
//nut_diameter=12.30;
//nut_inner_diameter=6.45;
//nut_height=5.65;

// M8
//nut_diameter=14.38;
//nut_inner_diameter=8;
//nut_height=6.8;

// M10
//nut_diameter=17.77;
//nut_inner_diameter=10;
//nut_height=8.4;

/* [Advanced] */

// Resolution
CYLINDER_RESOLUTION=128;

difference() {
    peg(peg_diameter, peg_depth, peg_top_diameter, peg_top_height, .25);    
    hole();
    translate([0,0,nut_depth]) nut();
    translate([0,0,peg_top_height + peg_depth - nut_height - nut_depth]) nut();
}


module peg_chamfered(diameter, depth, top_diameter, top_height, chamfer_size) {
     minkowski() {
         peg(diameter, depth, top_diameter, top_height);
         translate([0,0,chamfer_size]) sphere(r=chamfer_size);
     }
}

module peg(diameter, depth, top_diameter, top_height) {
    cylinder(r = top_diameter / 2, h = top_height, $fn=CYLINDER_RESOLUTION);
    translate([ 0, 0, top_height ])
        cylinder(r = diameter / 2, h = depth, $fn=CYLINDER_RESOLUTION);
}

module hole() {
    translate([0,0,-1])
        cylinder(r = nut_inner_diameter / 2, h=peg_top_height + peg_depth + 2, $fn=CYLINDER_RESOLUTION);
}

module nut() {
   cylinder(r = nut_diameter / 2, h = nut_height, $fn=6);
}