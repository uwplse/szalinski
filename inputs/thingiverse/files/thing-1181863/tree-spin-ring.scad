// Customizable Spinning Ring with Christmas Tree Design
// by pikafoop (www.pikaworx.com)

/* [Basic Options] */

// : U.S. Ring Size (see Advanced Options to specify diameter in mm)
ring_size = 10; //[0:0.25:16]

//
number_of_trees = 5;

//
parts_to_print = 0; // [0:Both, 1:Inner, 2:Outer]

/* [Advanced Options] */

// (mm)
ring_height = 9;

// (mm)
tree_height = 6;

// (mm) : Override ring size and specify inner diameter; 0 means use ring size
ring_diameter = 0;

// (mm) : How thin can we print a layer on your printer?
thinnest_layer = 0.8;

// (mm) : Height of the "bump" on the inner ring
bearing_intrusion = 0.6;

// (mm) : Average distance between inner and outer
bearing_gap = 0.4;

/* [Hidden] */

// : How many facets should our rings have?
resolution = 180; // [30:30:180]

// if we don't override the ring size, calculate using https://en.wikipedia.org/wiki/Ring_size#Equations
inner_diameter = ring_diameter ? ring_diameter : 11.63 + 0.8128*ring_size;
echo(inner_diameter=inner_diameter);

ring_thick = thinnest_layer*2 + bearing_gap + bearing_intrusion;
echo(ring_thick=ring_thick);

inner_thin = thinnest_layer;
inner_thick = thinnest_layer+bearing_intrusion;
inner_diff = bearing_intrusion;
inner_ring_poly_points = [
    [0,0], [inner_thin,0], [inner_thick,inner_diff], // increase
    [inner_thick, inner_diff*2], //bend
    [inner_thin, inner_diff*3],
    [inner_thick, ring_height / 2],
    [inner_thin, ring_height-inner_diff*3],
    [inner_thick, ring_height-inner_diff*2],
    [inner_thick,ring_height-inner_diff], // end bend
    [inner_thin,ring_height], [0, ring_height], [0,0] // decrease & return
];

echo(inner_thick=inner_thick);

outer_displacement = inner_thin + bearing_gap;
outer_thick = ring_thick - outer_displacement;
outer_thin = max(outer_thick - bearing_intrusion, 1.0);
outer_diff = bearing_intrusion;
outer_ring_poly_points = [
    [0,0], [outer_thin,0], [outer_thick,outer_diff], // outer increase
    [outer_thick,ring_height-outer_diff], // outer bump
    [outer_thin, ring_height], [0, ring_height], // outer decrease
    
    [outer_diff, ring_height-outer_diff], // inner decrease
    [outer_diff, ring_height-outer_diff*2],
    [0, ring_height-outer_diff*3], //bend
    [outer_diff, ring_height / 2],
    [0, outer_diff*3],
    [outer_diff, outer_diff*2],
    [outer_diff, outer_diff], [0, 0] // inner increase and return
];

echo(outer_displacement=outer_displacement);

tree_poly_points = [
    [0,0], [2,2], [1,2], [3,4], [2,4], [4,6],
    [6,4], [5,4], [7,2], [6,2], [8,0], [0,0]
];

if (parts_to_print == 1 || parts_to_print == 0) {
    translate([-inner_diameter/2-ring_thick,0,0]) inner_ring();
}

if (parts_to_print == 2 || parts_to_print == 0) {
    translate([inner_diameter/2+ring_thick,0,0]) outer_ring();
}

module inner_ring() {
    rotate_extrude($fn=resolution)
        translate([inner_diameter/2,0,0])
        polygon(inner_ring_poly_points);
}

module outer_ring() {
    difference() {
        rotate_extrude($fn=resolution)
            translate( [inner_diameter/2+outer_displacement, 0, 0] )
            polygon(outer_ring_poly_points);
        if (number_of_trees > 0) trees();
    }
}

module tree_cut() {
    rotate([90,0,0])
        linear_extrude(height=inner_diameter, center=false)
        translate([-4,(ring_height-tree_height)/2,0])
        resize([0,tree_height,0], auto=true)
        polygon(tree_poly_points);
}

module trees() {
    for (x=[1:number_of_trees]) {
        rotate([0, 0, 360*x/number_of_trees]) tree_cut();
    }
}
